import 'dart:async';
import 'dart:math';

import 'package:azlogistik_chat/azlogistik_chat.dart';
import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/models/chat_room.dart';
import 'package:azlogistik_chat/services/chat_request.dart';
import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:azlogistik_chat/utilities/text_helper.dart';
import 'package:azlogistik_chat/views/app_bar.dart';
import 'package:azlogistik_chat/views/chat_page.dart';
import 'package:azlogistik_chat/views/filter_bottom_sheet.dart';
import 'package:azlogistik_chat/views/textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChatListPage extends StatefulWidget {
  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final PagingController<int, ChatRoom> _pagingController = PagingController(firstPageKey: 0);

  String _selectedFilter = '';
  String _keyword = '';

  Timer? _searchTimer;
  TextEditingController _txtSearchController = TextEditingController();

  @override
  void initState() {
    if(ChatCubit.instance.state is ChatLoadSuccess){
      _selectedFilter = (ChatCubit.instance.state as ChatLoadSuccess).selectedFilter;
      _keyword = (ChatCubit.instance.state as ChatLoadSuccess).keyword;
    }

    _pagingController.addPageRequestListener((pageKey) {
      // _fetchPage(pageKey);
      ChatCubit.instance.fetchRoom(
        selectedFilter: _selectedFilter,
        keyword: _keyword,
        pageKey: pageKey
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AAppBar(
        title: 'Inbox',
        actions: [
          AAppBar.actionButton(
            iconSvg: 'assets/images/filter-icon.svg',
            iconColor: Colors.white,
            notifCount: _selectedFilter.isNotEmpty ? 1 : 0,
            showNotifCount: false,
            onPressed: () async {
              var res = await showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )
                ),
                context: context, 
                builder: (context) => FilterBottomSheet(
                  selectedFilter: _selectedFilter,
                )
              );
              if(res is String){
                if(_selectedFilter != res){
                  _selectedFilter = res;
                  ChatCubit.instance.applyFilter(res);
                  setState(() {});
                  _pagingController.refresh();
                }
              }
            }
          )
        ],
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              padding: const EdgeInsets.only(
                left: ASize.spaceMedium,
                right: ASize.spaceMedium,
                top: ASize.spaceMedium,
                bottom: ASize.spaceSmall,
              ),
              height: 60,
              color: AColors.white,
              child: ATextField(
                placeholder: 'Masukkan Pencarian',
                prefix: SvgPicture.asset(
                  'assets/images/search-icon.svg',
                  package: 'azlogistik_chat',
                  height: 20,
                  width: 20,
                ),
                suffix: _txtSearchController.text != '' 
                  ? ASuffixButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: AColors.gray2,
                      ),
                      onPressed: () {
                        _txtSearchController.text = '';
                        _keyword = '';
                        if(_searchTimer != null && _searchTimer!.isActive){
                          _searchTimer!.cancel();
                        }
                        ChatCubit.instance.applyKeyword(_keyword);
                        setState(() {});
                        _pagingController.refresh();
                      }
                    )
                  : null,
                controller: _txtSearchController,
                maxLines: 1,
                onChanged: (val) {
                  if(_searchTimer != null && _searchTimer!.isActive){
                    _searchTimer!.cancel();
                  }
                  _searchTimer = Timer(Duration(milliseconds: 500), (){
                    _keyword = val;
                    ChatCubit.instance.applyKeyword(val);
                    setState(() {});
                    _pagingController.refresh();
                  });
                  setState(() {});
                },
              ),
            ), 
          ),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) { 
          if (state is ChatLoadSuccess) {
            //forget about existing record
            //about the last page, fetch last page number from 
            //backend

            _pagingController.itemList = state.rooms;
            if(state.isLast){
              // _pagingController.appendLastPage(state.rooms);
              _pagingController.nextPageKey = null;
              }
            else{
              // _pagingController.appendPage(state.rooms, state.rooms.length);
              _pagingController.nextPageKey = state.rooms.length;
            }
          }
          if (state is ChatLoadError) {
            _pagingController.error = 'Server error';
          }
          
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: _page(),
          );
        },
      ),
    );
    // return BlocBuilder<ChatCubit, ChatState>(
    //   builder: (context, state) { 
    //     if (state is ChatLoadSuccess) {
    //       //forget about existing record
    //       //about the last page, fetch last page number from 
    //       //backend

    //       _pagingController.itemList = state.rooms;
    //       if(state.isLast){
    //         // _pagingController.appendLastPage(state.rooms);
    //         _pagingController.nextPageKey = null;
    //         }
    //       else{
    //         // _pagingController.appendPage(state.rooms, state.rooms.length);
    //         _pagingController.nextPageKey = state.rooms.length;
    //       }
    //     }
    //     if (state is ChatLoadError) {
    //       _pagingController.error = 'Server error';
    //     }
        
    //     return Scaffold(
    //       appBar: AAppBar(
    //         title: 'Inbox',
    //         actions: [
    //           AAppBar.actionButton(
    //             icon: Icons.tune_rounded,
    //             iconColor: Colors.white,
    //             notifCount: (state is ChatLoadPending && state.selectedFilter.isNotEmpty) ? 1 : 0,
    //             onPressed: () async {
    //               var res = await showModalBottomSheet(
    //                 context: context, 
    //                 builder: (context) => FilterBottomSheet(
    //                   selectedFilter: _selectedFilter,
    //                 )
    //               );
    //               if(res is String){
    //                 if(_selectedFilter != res){
    //                   _selectedFilter = res;
    //                   ChatCubit.instance.applyFilter(res);
    //                   _pagingController.refresh();
    //                 }
    //               }
    //             }
    //           )
    //         ],
    //         bottom: PreferredSize(
    //           preferredSize: const Size.fromHeight(60),
    //           child: Container(
    //             padding: const EdgeInsets.symmetric(
    //               horizontal: ASize.spaceMedium,
    //               vertical: ASize.spaceNormal
    //             ),
    //             height: 60,
    //             color: AColors.white,
    //             child: ATextField(
    //               placeholder: 'Masukkan Pencarian',
    //               prefix: const Icon(
    //                 Icons.search,
    //                 size: 16,
    //                 color: AColors.black50,
    //               ),
    //               maxLines: 1,
    //               onChanged: (val) {
    //                 if(_searchTimer != null && _searchTimer!.isActive){
    //                   _searchTimer!.cancel();
    //                 }
    //                 _searchTimer = Timer(Duration(milliseconds: 500), (){
    //                   _keyword = val;
    //                   ChatCubit.instance.applyKeyword(val);
    //                   _pagingController.refresh();
    //                 });
    //               }
    //             ),
    //           ), 
    //         ),
    //       ),
    //       body: _page(),
    //     );
    //   },
    // );
  }

  Widget _page(){
    return PagedListView<int, ChatRoom>(
      pagingController: _pagingController,
      padding: EdgeInsets.zero,
      builderDelegate: PagedChildBuilderDelegate<ChatRoom>(
        noItemsFoundIndicatorBuilder: (context) {
          String title = '';
          String content = '';
          String image = '';
          if(_keyword != ''){
            title = _keyword + ' tidak ditemukan';
            image = 'assets/images/empty-result.svg';
          }
          else if(_selectedFilter != ''){
            title = 'Filter tidak ditemukan';
            image = 'assets/images/empty-result.svg';
          }
          else{
            title = 'Mari Memulai Obrolan';
            content = 'Terima dan kirim pesan lebih mudah dengan fitur chat dan dapatkan penawaran terbaik untuk produk Anda.';
            image = 'assets/images/empty-room-list.svg';
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image, 
                package: 'azlogistik_chat',
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if(content != '')
                const SizedBox(height: 4),
              if(content != '')
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AColors.gray1
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          );
        },
        itemBuilder: (context, item, index) => _chatRoomItem(item, index),
      ),
    );
  }

  Widget _chatRoomAvatar(ChatRoom item){
    if(item.avatar().isNotEmpty){
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: item.avatar(),
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      );
    }
    else{
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: AColors.gray2,
        ),
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          item.name().substring(0, min(item.name().length, 3)).toUpperCase().trim(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AColors.white,
          ),
        ),
      );
    }
  }

  Widget _chatRoomItem(ChatRoom item, int index) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage(
          room: item
        )));

        _pagingController.refresh();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ASize.spaceMedium,
        ),
        child: Container(
          decoration: index < (_pagingController.itemList?.length ?? 0) - 1
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AColors.gray3A,
                  ),
                ),
              )
            : null,
          padding: const EdgeInsets.symmetric(
            vertical: ASize.spaceText,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _chatRoomAvatar(item),
              const SizedBox( width: ASize.spaceText ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.name(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          TextHelper.convertShortDateAndTime(item.LastMessage?.Created),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: AColors.gray2
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: ASize.spaceSmall),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(item.LastMessage?.IsMe ?? false)
                          Container(
                            padding: const EdgeInsets.only(
                              top: 2,
                              right: 4,
                            ),
                            child: Icon(
                              item.LastMessage!.IsRead
                                  ? Icons.done_all
                                  : Icons.done_all,
                              size: ASize.iconVerySmall,
                              color: item.LastMessage!.IsRead ? AColors.primary : AColors.gray2,
                            ),
                          ),
                        Expanded(child: _lastMessage(item)),
                        if(item.CountUnread != null && item.CountUnread > 0)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AColors.danger,
                            ),
                            width: 16,
                            height: 16,
                            alignment: Alignment.center,
                            child: Text(
                              item.CountUnread > 99 ? '99' : item.CountUnread.toString(),
                              style: const TextStyle(
                                color: AColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lastMessage(ChatRoom item){
    var text = '';
    bool isImage = false;
    if(item.LastMessage?.File != null){
      text = (item.LastMessage?.From?.ID == item.toId() ? item.name() : 'Anda') + ' mengirim ' + ((item.LastMessage?.File?.isImage() ?? false) ? 'gambar' : 'dokumen');
      isImage = true;
    }
    else{
      text = item.LastMessage?.Message ?? '';
    }
    return Row(
      children: [
        if(isImage)
          Container(
            margin: EdgeInsets.only(
              right: ASize.spaceSmall,
            ),
            child: item.LastMessage!.File!.icon(
              size: 16,
              color: AColors.gray2,
            ),
            // child: Icon(
            //   (item.LastMessage?.File?.isImage() ?? false) ? Icons.image : Icons.article,
            //   color: AColors.gray2,
            //   size: 16,
            // ),
          ),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              color: AColors.gray1,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      List<ChatRoom>? newItems;
      newItems = await ChatRequest.getRooms(
        start: pageKey,
      );

      if(newItems == null){
        throw('server error');
      }
      
      final isLastPage = newItems.length < 10;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
}