import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/bloc/meta_bloc.dart';
import 'package:azlogistik_chat/models/chat.dart';
import 'package:azlogistik_chat/models/chat_room.dart';
import 'package:azlogistik_chat/models/cloud_file.dart';
import 'package:azlogistik_chat/models/link_metadata.dart';
import 'package:azlogistik_chat/models/member.dart';
import 'package:azlogistik_chat/models/photo_file.dart';
import 'package:azlogistik_chat/services/chat_request.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:azlogistik_chat/utilities/text_helper.dart';
import 'package:azlogistik_chat/views/app_bar.dart';
import 'package:azlogistik_chat/views/chat_bubble.dart';
import 'package:azlogistik_chat/views/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatPage extends StatefulWidget {

  final ChatRoom room;
  final String? defaultText;

  const ChatPage({
    required this.room,
    this.defaultText,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final PagingController<int, Chat> _pagingController = PagingController(firstPageKey: 0);
  final TextEditingController _textEditingController = TextEditingController();
  late FocusNode _textFocusNode;

  Member? _me;

  Timer? _readTimer;
  Timer? _markReadTimer;
  Timer? _textChangedTimer;

  late ChatRoom _room;

  // LinkMetaData? _linkMetaData;

  bool _isBlocked = false;
  bool _isBlockedTo = false;

  @override
  void initState() {
    _room = widget.room;

    Config.chatPageController.state = this;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _textFocusNode = FocusNode(
      onKey: (node, event) {
        return KeyEventResult.ignored;
      }
    );

    super.initState();

    // member.loadMember().then((value) => _me = value);
    _me = Member(
      ID: ChatCubit.instance.state.memberId,
      Name: 'Saya',
    );

    // if(_room.name() == ''){
    fetchRoomDetail();
    // }

    _textEditingController.text = widget.defaultText ?? '';
    _textEditingController.addListener(() {
      _textChangedTimer?.cancel();
      _textChangedTimer = Timer(const Duration(milliseconds: 1000), () async {
        MetaCubit.instance?.fetchMeta(_textEditingController.text);
        _textChangedTimer = null;
      });
      MetaCubit.instance?.fetchMeta(''); // to clear preview
    });
  }

  @override
  void dispose() {
    if(MetaCubit.instance != null){
      MetaCubit.instance!.close();
      MetaCubit.instance = null;
    }
    Config.chatPageController.state = null;
    _pagingController.dispose();
    if(_markReadTimer != null){
      _markReadTimer!.cancel();
    }
    _textChangedTimer?.cancel();
    _cancelReadTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('AVATAR : ' + _room.avatar());
    return BlocProvider<MetaCubit>(
      create: (context) => MetaCubit.newInstance(widget.defaultText),
      child: Scaffold(
        appBar: AAppBar(
          titleSpacing: 0,
          backgroundColor: AColors.white,
          customTitle: Row(
            children: [
              if(_room.avatar().isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    _room.avatar(),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              if(_room.avatar().isEmpty)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AColors.gray2,
                  ),
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(
                    _room.name().substring(0, min(_room.name().length, 3)).toUpperCase().trim(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AColors.white,
                    ),
                  ),
                ),
              const SizedBox(
                width: ASize.spaceNormal,
              ),
              Expanded(
                child: Text(
                  _room.name(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AColors.black,
                    fontFamily: 'Rubik'
                  ),
                ),
              )
            ],
          ),
        ),
        // bottomNavigationBar: _inputWrapper(),
        body: Column(
          children: [
            Expanded(
              child: _chatList(),
            ),
            _isBlocked
            ? _blockedWidget()
            : _inputWrapper(),
          ],
        ),
      ),
    );
  }

  Widget _blockedWidget() {
    var paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(
        left: ASize.spaceNormal, 
        right: ASize.spaceNormal, 
        top: ASize.spaceText, 
        bottom: ASize.spaceText + paddingBottom,
      ),
      decoration: ATheme.boxShadow,
      alignment: Alignment.center,
      child: (_isBlockedTo ? Config.blockedToMessage : Config.blockedMessage) ?? RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: _isBlockedTo 
                ? 'Pengguna ini telah diblokir oleh sistem karena telah 5x mengirimkan kata-kata kasar. '
                : 'Anda telah diblokir oleh sistem karena telah 5x mengirimkan kata-kata kasar. Untuk dapat melakukan chat kembali, ',
            ),
            if(!_isBlockedTo)
              TextSpan(
                text: 'hubungi Admin',
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
                recognizer: TapGestureRecognizer()..onTap = (){}
              )
          ]
        )
      ),
    );
  }

  Widget _inputWrapper(){
    var paddingBottom = MediaQuery.of(context).padding.bottom;
    return BlocBuilder<MetaCubit, MetaState>(
      builder: (context, state){
        // debugPrint('Bloc Builder ' + state.toString());
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(state is MetaLoadSuccess)
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(ASize.spaceNormal),
                    color: AColors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AColors.black50,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: ASize.spaceNormal,
                        horizontal: ASize.spaceMedium,
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              right: ASize.spaceNormal,
                            ),
                            width: 83,
                            height: 57,
                            color: AColors.black28,
                            child: state.metaData.Image != null && state.metaData.Image!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: state.metaData.Image!,
                                  width: 83,
                                  height: 57,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Container(),
                                )
                              : null,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.metaData.Title ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 14/12,
                                    fontWeight: FontWeight.bold,
                                    color: AColors.black90,
                                  ),
                                ),
                                const SizedBox(height: ASize.spaceSmall),
                                Text(
                                  state.metaData.Description ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: 14/12,
                                    color: AColors.black50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                        onTap: (){
                          MetaCubit.instance?.fetchMeta('');
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          child: Center(
                            child: Icon(
                              Icons.close_rounded,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                  )
                ],
              ),
            Container(
              padding: EdgeInsets.only(
                left: ASize.spaceNormal, 
                right: ASize.spaceNormal, 
                top: ASize.spaceText, 
                bottom: ASize.spaceText + paddingBottom,
              ),
              decoration: ATheme.boxShadow,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AColors.black28),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: ASize.spaceSmall,
                  horizontal: ASize.spaceNormal,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: showPictureDialog,
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationZ(-0.785398),
                            child: const Icon(
                              Icons.link,
                              color: AColors.black50,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ASize.spaceSmall,),
                    Container(
                      width: 1,
                      height: 18,
                      color: AColors.black28
                    ),
                    Expanded(
                      child: ATextField(
                        focusNode: _textFocusNode,
                        controller: _textEditingController,
                        maxLines: 5,
                        noBorder: true,
                        lineHeight: 14/12,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: ASize.spaceText,
                        )
                      ),
                    ),
                    SizedBox(width: ASize.spaceSmall,),
                    InkWell(
                      onTap: (){
                        _send();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/send-icon.svg',
                            package: 'azlogistik_chat',
                            color: _textEditingController.text == '' ? AColors.gray1 : AColors.primary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _chatList(){
    return PagedListView<int, Chat>(
      pagingController: _pagingController,
      padding: const EdgeInsets.only(
        top: 16,
      ),
      builderDelegate: PagedChildBuilderDelegate<Chat>(
        noItemsFoundIndicatorBuilder: (context) {
          return Container();
          // return Column(
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(
          //         vertical: 40,
          //       ),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Image.asset(
          //             'assets/empty-box.png'
          //           ),
          //           Expanded(
          //             child: Column(
          //               mainAxisSize: MainAxisSize.min,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: const <Widget>[
          //                 Text(
          //                   'Belum ada percakapan',
          //                   style: TextStyle(
          //                     fontSize: 14,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           )
          //         ],
          //       )
          //     ),
          //   ],
          // );
        },
        itemBuilder: (context, item, index) {
          Widget? date;
          if(_pagingController.itemList != null && _pagingController.itemList!.isNotEmpty && index == _pagingController.itemList!.length - 1){
            date = _chatDate(item.Created!);
          }
          else if(_pagingController.itemList != null && _pagingController.itemList!.length > index + 1){
            if(item.Created!.day != _pagingController.itemList![index+1].Created!.day ||
                item.Created!.month != _pagingController.itemList![index+1].Created!.month ||
                item.Created!.year != _pagingController.itemList![index+1].Created!.year){
              date = _chatDate(item.Created!);
            }
          }
          if(date != null){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                date,
                ChatBubble(
                  chat: item
                )
              ],
            );
          }
          return ChatBubble(
            chat: item
          );
        },
      ),
      reverse: true,
    );
  }

  Widget _chatDate(DateTime date){
    return Center(
      child: Text(
        _chatDateString(date),
        style: const TextStyle(
          fontSize: 12,
          color: AColors.gray1
        ),
      ),
    );
  }

  String _chatDateString(DateTime date){
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));
    if(date.year == today.year && date.month == today.month && date.day == today.day){
      return 'Hari Ini';
    }
    else if(date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day){
      return 'Kemarin';
    }
    return TextHelper.convertShortDate(date);
  }

  void _setReadTimer(){
    _cancelReadTimer();
    _readTimer = Timer.periodic(Duration(seconds: 5), (_) => fetchReadCheck());
  }
  void _cancelReadTimer(){
    if(_readTimer != null){
      _readTimer?.cancel();
      _readTimer = null;
    }
  }

  void _setMarkAsReadTimer(){
    _markReadTimer = Timer(Duration(seconds: 3), () => _markAsRead());
  }

  Future<void> _markAsRead() async {
    try {
      await ChatRequest.markAsRead(
        toId: _room.toId(),
        messageId: _pagingController.itemList?.first.ID ?? 0
      );
      ChatCubit.instance.fetchNewRooms();
    } catch (error) {
      
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<Chat>? newItems;
      newItems = await ChatRequest.getChats(
        toId: _room.toId(),
        start: pageKey,
      );

      if(newItems == null){
        throw('Server error');
      }
      
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }

      _setMarkAsReadTimer();
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> fetchNewChats() async {
    List<Chat>? newItems;
    newItems = await ChatRequest.getChats(
      toId: _room.toId(),
      lastId: _pagingController.itemList?.first.ID ?? 0
    );
    if(newItems != null){
      _pagingController.itemList = newItems + (_pagingController.itemList ?? []);
      if(_pagingController.nextPageKey != null){
        _pagingController.nextPageKey = _pagingController.nextPageKey! + newItems.length;
      }

      var i=0;
      var found = false;
      for(; i<newItems.length; i++){
        if(!newItems[i].IsMe){
          found = true;
          break;
        }
      }
      if(found){
        for(;i<(_pagingController.itemList?.length ?? 0); i++){
          _pagingController.itemList![i].IsRead = true;
        }
      }

      ChatCubit.instance.fetchNewRooms();
      _setMarkAsReadTimer();
      setState(() {});
    }
  }

  Future<void> fetchReadCheck() async {
    List<Chat>? newItems;
    newItems = await ChatRequest.getChats(
      toId: _room.toId(),
    );
    if(newItems != null && newItems.isNotEmpty && _pagingController.itemList != null){
      var last = newItems.first;
      if(!last.IsMe || last.IsRead){
        for(var i=0; i<_pagingController.itemList!.length; i++){
          _pagingController.itemList![i].IsRead = true;
        }
        ChatCubit.instance.fetchNewRooms();
        _cancelReadTimer();
        setState(() {});
      }
    }
  }

  Future<void> fetchRoomDetail() async {
    ChatRoom? temp = await ChatRequest.getRoomDetail(
      roomId: _room.Code ?? '',
    );

    if(temp != null){
      _room = temp;
      _setReadTimer();
    }
    else{
      _cancelReadTimer();
    }
    setState(() {});
  }

  void _send() async {
    if(_textEditingController.text != ''){
      var message = _textEditingController.text;
      _textEditingController.text = '';
      int tempID = DateTime.now().millisecondsSinceEpoch;
      Chat tempChat = Chat();
      tempChat.From = Member(
        Name: _me?.Name ?? 'Saya',
        ID: _me?.ID ?? ChatCubit.instance.state.memberId,
      );
      tempChat.Message = message;
      tempChat.Created = DateTime.now();
      tempChat.TempID = tempID;
      tempChat.IsError = false;
      tempChat.IsRead = true;
      tempChat.IsViolation = false;

      _pagingController.itemList = [tempChat] + (_pagingController.itemList ?? []);
      setState(() {});

      var chat = await ChatRequest.sendChat(
        toId: _room.toId(),
        text: message,
      );

      if(chat != null){
        // _pagingController.itemList = [chat] + _pagingController.itemList;
        var index = _pagingController.itemList?.indexOf(tempChat) ?? -1;
        if(index > -1){
          _pagingController.itemList?[index] = chat;
        }
        if(_pagingController.nextPageKey != null){
          _pagingController.nextPageKey = _pagingController.nextPageKey! + 1;
        }
        _room.LastMessage = chat;
        _setReadTimer();
        setState(() {});
      }
      else{
        tempChat.IsError = true;
        setState(() {});
      }
      ChatCubit.instance.fetchNewRooms();
    }
  }

  void showPictureDialog() async {
    var filePath = await showModalBottomSheet(
      context: context, 
      builder: (context){
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: const Text('Camera'),
              leading: const Icon(Icons.camera_alt_outlined, color: AColors.primary,),
              onTap: () async {
                final File? photo = await ImagePicker.pickImage(
                  maxWidth: 1280,
                  maxHeight: 1280,
                  source: ImageSource.camera,
                  // preferredCameraDevice: CameraDevice.rear,
                );
                Navigator.of(context).pop(photo?.path);
              }
            ),
            ListTile(
              title: const Text('Gallery'),
              leading: const Icon(Icons.photo_outlined, color: AColors.primary),
              onTap: () async {
                final File? photo = await ImagePicker.pickImage(
                  maxWidth: 1280,
                  maxHeight: 1280,
                  source: ImageSource.gallery,
                );
                Navigator.of(context).pop(photo?.path);
              },
            ),
            ListTile(
              title: const Text('Document'),
              leading: const Icon(Icons.article_outlined, color: AColors.primary),
              onTap: () async {
                var result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowMultiple: false,
                  allowedExtensions: [
                    'doc', 'docx', 
                    'xls', 'xlsx', 'csv',
                    'ppt', 'pptx', 'pages',
                    'txt','rtf',
                    'pdf',
                    'zip', 'rar',
                  ]
                );
                Navigator.of(context).pop(result?.files.single.path);
              },
            ),
          ]
        );
      },
    );

    _sendFile(filePath);
  }

  void _sendFile(String? filePath) async {
    if(filePath != null){
      var message = '';
      int tempID = DateTime.now().millisecondsSinceEpoch;
      Chat tempChat = Chat();
      tempChat.From = Member(
        Name: _me?.Name ?? 'Saya',
        ID: _me?.ID ?? ChatCubit.instance.state.memberId,
      );
      tempChat.Message = message;
      tempChat.Created = DateTime.now();
      tempChat.TempID = tempID;
      tempChat.IsError = false;
      tempChat.IsRead = true;
      tempChat.IsViolation = false;
      tempChat.File = PhotoFile(
        Original: filePath
      );

      _pagingController.itemList = [tempChat] + (_pagingController.itemList ?? []);
      setState(() {});

      //upload file
      CloudFile? cloudFile = await ChatRequest.uploadFile(filePath);
      Chat? chat;
      if(cloudFile != null){
        chat = await ChatRequest.sendChat(
          toId: _room.toId(),
          text: message,
          fileId: cloudFile.ID,
        );
      }

      if(chat != null){
        // _pagingController.itemList = [chat] + _pagingController.itemList;
        int index = _pagingController.itemList?.indexOf(tempChat) ?? -1;
        if(index > -1){
          _pagingController.itemList?[index] = chat;
        }
        if(_pagingController.nextPageKey != null){
          _pagingController.nextPageKey = _pagingController.nextPageKey! + 1;
        }
        _setReadTimer();
        setState(() {});
      }
      else{
        tempChat.IsError = true;
        setState(() {});
      }

      ChatCubit.instance.fetchNewRooms();
    }
  }

  List<String> extractUrls(String text) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> matches = exp.allMatches(text);

    List<String> urls = [];
    matches.forEach((match) {
      urls.add(text.substring(match.start, match.end));
    });
    
    return urls;
  }

  void blocked([bool isMe = true]){
    FocusScope.of(context).unfocus();
    setState(() {
      _isBlocked = true;
      _isBlockedTo = !isMe;
    });
  }
}

class ChatPageController{
  _ChatPageState? state;

  void fetchNewChats(){
    if(state != null){
      state!.fetchNewChats();
    }
  }

  bool isShowNotification(String code){
    return state == null || state!._room.Code != code;
  }

  void blocked([bool isMe = true]){
    if(state != null){
      state!.blocked(isMe);
    }
  }
}