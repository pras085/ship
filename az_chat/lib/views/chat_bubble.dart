import 'dart:math';
import 'dart:ui';

import 'package:azlogistik_chat/bloc/bloc.dart';
import 'package:azlogistik_chat/models/chat.dart';
import 'package:azlogistik_chat/utilities/config.dart';
import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:azlogistik_chat/utilities/text_helper.dart';
import 'package:azlogistik_chat/views/photo_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


class ChatBubble extends StatelessWidget {
  final Chat chat;
  // final Channel channel;

  ChatBubble({
    Key? key,
    required this.chat,
    // this.channel,
  }) : super(key: key);

  
  String? mySID;
  String? vendorSID;
  // FileApi fileApi = FileApi();
  bool isImage = false;
  Widget? innerContent;
  // Listing listing;
  bool? isDetailFetched = false;
  // CatalogApi catalogApi = CatalogApi();
  bool isLoading = false;
  String? _localPath;
  // ReceivePort _port = ReceivePort();

  @override
  Widget build(BuildContext context) {
    if(chat.IsViolation && !chat.IsMe){
      return Container();
    }
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: ASize.spaceNormal
      ),
      child: LayoutBuilder(builder: (context, size) {
        Widget contentWrapper = content();
        BoxConstraints contentSize = BoxConstraints(
            minHeight: size.minHeight,
            minWidth: ASize.chatBubbleMinWidth,
            maxWidth: max(
                size.maxWidth -
                    (ASize.spaceBox +
                        (2 * ASize.spaceMedium) +
                        (2 * ASize.spaceText)),
                ASize.chatBubbleMinWidth),
            maxHeight: size.maxHeight);

        return Row(
          mainAxisAlignment:
              chat.IsMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment:
              chat.IsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            isExpanded(context, contentSize)
                ? Expanded(child: contentWrapper)
                : contentWrapper
          ],
        );
      }),
    );
  }

  TextStyle _textStyle(){
    return TextStyle(
      color: chat.IsMe ? AColors.white : AColors.black,
      fontSize: 12,
      height: 14/12,
    );
  }

  Widget imageContent(){
    if(chat.File?.ID != null && chat.File!.ID > 0){
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: chat.File!.Small ?? '',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          placeholder: (context, _){
            return const Center(child: const CircularProgressIndicator());
          },
        ),
      );
    }
    else{
      // uploading image
      return Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              chat.File!.Original ?? '',
              package: 'azlogistik_chat'
            ),
            fit: BoxFit.cover,
          ),
          color: AColors.gray3,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              width: 200,
              height: 200,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget docContent(){
    if(chat.File?.ID != null && chat.File!.ID > 0){
      return GestureDetector(
        onTap: () async {
          if(await canLaunch(chat.File!.Original!)){
            launch(chat.File!.Original!);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(ASize.spaceMedium),
          decoration: BoxDecoration(
            border: Border.all(
              color: AColors.gray2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              chat.File!.icon(),
              // const Icon(
              //   Icons.article,
              //   color: AColors.primary,
              //   size: 16,
              // ),
              const SizedBox(
                width: ASize.spaceNormal,
              ),
              Expanded(
                child: Text(
                    chat.File!.getFileName(),
                  ),
              )
              
            ],
          ),
        ),
      );
    }
    else{
      return const SizedBox(
        width: 200,
        child: ClipRect(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }

  Widget metaContent(){
    return GestureDetector(
      onTap: () async {
        if(chat.UrlMetaData?.URL != null  && await canLaunch(chat.UrlMetaData!.URL!)){
          launch(chat.UrlMetaData!.URL!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: ASize.spaceNormal,
          horizontal: ASize.spaceMedium,
        ),
        margin: const EdgeInsets.only(
          bottom: ASize.spaceNormal,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: AColors.black50,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: chat.UrlMetaData!.Image ?? '',
              width: 83,
              height: 57,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(ASize.spaceNormal),
                // color: AColors.black28,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.UrlMetaData!.Title ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 14/12,
                        fontWeight: FontWeight.bold,
                        color: AColors.black90,
                      )
                    ),
                    const SizedBox(height: ASize.spaceSmall),
                    Text(
                      chat.UrlMetaData!.Description ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 14/12,
                        color: AColors.black50,
                      )
                    ),
                  ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content() {
    if(!chat.IsViolation){
      if(chat.File == null){
        var lines = chat.Message.split(RegExp(r"(?:\r\n|\r|\n)"));
        var children = <TextSpan>[];
        for(var line in lines){
          if(children.isNotEmpty){
            children.add(TextSpan(
              text: '\n',
              style: _textStyle()
            ));
          }

          var messages = line.split(' ');
          var lineChildren = <TextSpan>[];
          for(var msg in messages){
            if(lineChildren.isNotEmpty){
              lineChildren.add(TextSpan(
                text: ' ',
                style: _textStyle()
              ));
            }
            lineChildren.add(TextSpan(
              text: msg,
              style: TextHelper.isUrl(msg.trim()) 
                ? _textStyle().copyWith(
                    decoration: TextDecoration.underline
                  )
                : _textStyle(),
              recognizer: TextHelper.isUrl(msg)
                ? (TapGestureRecognizer()..onTap = () async {
                    var url = msg;
                    if(!msg.startsWith('http://') && !msg.startsWith('https://')){
                      url = 'https://' + msg;
                    }
                    if( await canLaunch(url)){
                      launch(url);
                    }
                  })
                : null
            ));
          }
          children.addAll(lineChildren);
        }
        TextSpan messageText = TextSpan(
          children: children
        );
        innerContent = RichText(
          text: messageText,
        );
      }
      // if (chat.File != null) {
      //   if(chat.File?.isImage() ?? false){
      //     innerContent = imageContent();
      //   }
      //   else{
      //     innerContent = docContent();
      //   }
      // }
      // else{
      //   TextSpan messageText = TextSpan(
      //     text: chat.Message,
      //     style: _textStyle(),
      //   );
      //   if(chat.UrlMetaData != null){
      //     innerContent = metaContent();
      //   }
      //   else{
      //     innerContent = RichText(
      //         text: messageText,
      //       );
      //   }
      // }
    }
    else{
      TextSpan messageText = TextSpan(
        text: chat.Message,
        style: _textStyle(),
      );

      innerContent = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.not_interested,
            size: 16,
            color: AColors.gray2,
          ),
          const SizedBox(width: ASize.spaceSmall,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: messageText,
                ),
                if(Config.onTncClicked != null)
                  const SizedBox(height: ASize.spaceSmall,),
                if(Config.onTncClicked != null)
                  GestureDetector(
                    onTap: Config.onTncClicked,
                    child: Text(
                      'Cek Syarat & Ketentuan',
                      style: _textStyle().copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
              ],
            ),
          )
        ],
      );
    }

      Widget result = Container(
        margin: EdgeInsets.only(
          left: (chat.IsMe ? ASize.spaceBox : 0) + ASize.spaceMedium,
          right: (!chat.IsMe ? ASize.spaceBox : 0) + ASize.spaceMedium
        ),
        child: Column(
          crossAxisAlignment:
              chat.IsMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            if(chat.File != null && (chat.File?.isImage() ?? false))
              imageContent(),
            if(chat.File != null && !(chat.File?.isImage() ?? false))
              docContent(),
            if(chat.UrlMetaData != null)
              metaContent(),
            if(innerContent != null)
            Container(
              constraints: const BoxConstraints(
                minWidth: ASize.chatBubbleMinWidth,
                maxWidth: double.infinity,
              ),
              decoration: BoxDecoration(
                color: chat.IsMe ? AColors.primary : AColors.primary50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(chat.IsMe ? 10 : 0),
                  topRight: const Radius.circular(10),
                  bottomLeft: const Radius.circular(10),
                  bottomRight: Radius.circular(chat.IsMe ? 0 : 10),
                )
              ),
              padding: const EdgeInsets.symmetric(
                vertical: ASize.spaceText,
                horizontal: ASize.spaceText
              ),
              child: innerContent,
            ),
            Container(
              // padding: const EdgeInsets.symmetric(
              //   horizontal: ASize.spaceBox
              // ),
              margin: const EdgeInsets.only(
                top: 2
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    TextHelper.convertTimeOnly(chat.Created),
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AColors.gray2,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: ASize.spaceSmall),
                  _iconRead(),
                ],
              ),
            ),
          ],
        ),
      );

    
      return Builder(
        builder: (context) {
          return GestureDetector(
            child: result,
            onTap: (){
              if(chat.File != null && (chat.File?.isImage() ?? false) && chat.File?.ID != null && chat.File!.ID > 0){
                Navigator.of(context).push( PhotoDialog(<String>[chat.File!.Original ?? ''], 0) );
              }
            },
            onLongPress: () {
              Clipboard.setData(ClipboardData(text: chat.Message));
              BotToast.showText(text: 'Pesan berhasil disalin');
            },
          );
        },
      );
    // } else {
    //   return Container(child: Text(chat.Message));
    // }
  }

  Widget _iconRead(){
    if(chat.IsMe){
      if(chat.TempID != null && chat.TempID > 0){
        if(chat.IsError){
          return const Icon(
            Icons.warning,
            size: ASize.iconVerySmall,
            color: AColors.danger,
          );
        }
        else{
          return const Icon(
            Icons.history,
            size: ASize.iconVerySmall,
            color: AColors.gray2,
          );
        }
      }
      return Icon(
        chat.IsRead
            ? Icons.done_all
            : Icons.done_all,
        size: ASize.iconVerySmall,
        color: chat.IsRead ? AColors.primary : AColors.gray2,
      );
    }
    return Container();
  }

  bool isExpanded(BuildContext context, BoxConstraints size) {
    // if (chat.Type == "text" ) {
      bool isFile = chat.File?.ID != null && !(chat.File?.isImage() ?? false);
      if(chat.UrlMetaData != null ||
        isFile || 
        chat.IsViolation){
        return true;
      }

      List<String> lines = chat.Message.split("\n");
      bool isExpanded = false;
      lines.forEach((line) {
        TextSpan messageText = TextSpan(
          text: line,
          style: _textStyle(),
        );

        TextPainter tp = TextPainter(
            text: messageText,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            maxLines: 1);

        tp.layout(maxWidth: size.maxWidth, minWidth: size.minWidth);
        isExpanded = isExpanded || tp.didExceedMaxLines;
      });

      return isExpanded;
    // } else {
    //   return true;
    // }
  }
}
