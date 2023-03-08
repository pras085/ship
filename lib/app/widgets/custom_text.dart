import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:muatmuat/global_variable.dart';

class CustomText extends StatelessWidget {
  final String fontFamily;
  final TextOverflow overflow;
  final String stringText;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final FontStyle fontStyle;
  final double height;
  final int maxLines;
  final bool fromCenter;
  final bool withoutExtraPadding;
  final TextDecoration decoration;
  final double decorationThickness;
  final Color decorationColor;
  final Paint foreground;
  final TextDirection textDirection;
  final BuildContext bContext;
  final double letterSpacing;

  CustomText(
    this.stringText, {
    this.fontFamily = "AvenirNext",
    this.textAlign = TextAlign.start,
    this.overflow,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
    this.fontStyle = FontStyle.normal,
    this.height = 1,
    this.maxLines,
    this.fromCenter = false,
    this.withoutExtraPadding = false,
    this.decoration,
    this.decorationThickness,
    this.decorationColor,
    this.foreground,
    this.textDirection,
    this.bContext,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    var paddingTop = fontSize * 2.3 / 11;
    return Column(
      crossAxisAlignment:
          fromCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!withoutExtraPadding)
          SizedBox(height: paddingTop),
        Text(stringText,
            textAlign: textAlign,
            overflow: overflow,
            maxLines: maxLines,
            textDirection: textDirection,
            style: TextStyle(
                letterSpacing: letterSpacing,
                fontFamily: fontFamily,
                fontSize: //GlobalVariable.ratioHeight(
                    //bContext != null ? bContext : context) *
                    GlobalVariable.ratioFontSize(
                            bContext != null ? bContext : context) *
                        fontSize,
                fontWeight: fontWeight,
                color: color,
                fontStyle: fontStyle,
                height: height,
                foreground: foreground,
                decoration: decoration,
                decorationThickness: decorationThickness,
                ))
      ],
    );
  }
}

class CustomTextWithIcon extends StatelessWidget {
  final String fontFamily;
  final TextOverflow overflow;
  final String stringText;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final FontStyle fontStyle;
  final double height;
  final int maxLines;
  final bool fromCenter;
  final bool withoutExtraPadding;
  final TextDecoration decoration;
  final Color decorationColor;
  final Paint foreground;
  final TextDirection textDirection;
  final BuildContext bContext;
  final double letterSpacing;
  final String iconAssets;
  final double iconAssetsWidth;
  final double iconAssetsHeight;
  final Function onTap;

  CustomTextWithIcon(
    this.stringText, {
    this.fontFamily = "AvenirNext",
    this.textAlign = TextAlign.start,
    this.overflow,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black,
    this.fontStyle = FontStyle.normal,
    this.height = 1,
    this.maxLines,
    this.fromCenter = false,
    this.withoutExtraPadding = false,
    this.decoration,
    this.decorationColor,
    this.foreground,
    this.textDirection,
    this.bContext,
    this.letterSpacing,
    this.iconAssets,
    this.iconAssetsWidth,
    this.iconAssetsHeight,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var paddingTop = fontSize * 2.3 / 11;
    return Column(
      crossAxisAlignment:
          fromCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!withoutExtraPadding)
          SizedBox(height: paddingTop),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: stringText,
                style: TextStyle(
                    letterSpacing: letterSpacing,
                    fontFamily: fontFamily,
                    fontSize: //GlobalVariable.ratioHeight(
                        //bContext != null ? bContext : context) *
                        GlobalVariable.ratioFontSize(
                                bContext != null ? bContext : context) *
                            fontSize,
                    fontWeight: fontWeight,
                    color: color,
                    fontStyle: fontStyle,
                    height: height,
                    foreground: foreground,
                    decoration: decoration)
              ),
              WidgetSpan(child: 
                GestureDetector(
                  onTap: () {
                    onTap();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      left: GlobalVariable.ratioWidth(context) * 6, 
                    ),
                    // padding: EdgeInsets.only(
                    //   bottom: GlobalVariable.ratioWidth(context) * 6, 
                    // ),
                    alignment: Alignment.center,
                    width: GlobalVariable.ratioWidth(context) * iconAssetsWidth,
                    height: height > 1 ? GlobalVariable.ratioWidth(context) * iconAssetsHeight + 4 : GlobalVariable.ratioWidth(context) * iconAssetsHeight + 6,
                    child: SvgPicture.asset(
                      iconAssets,
                      width: GlobalVariable.ratioWidth(context) * iconAssetsWidth,
                      // height: GlobalVariable.ratioWidth(context) * iconAssetsHeight,
                    ),
                  ),
                ),
              )
            ]
          )
        )
        // Wrap(
        //   children: [
        //     Text(stringText,
        //         textAlign: textAlign,
        //         overflow: overflow,
        //         maxLines: maxLines,
        //         textDirection: textDirection,
        //         style: TextStyle(
        //             letterSpacing: letterSpacing,
        //             fontFamily: fontFamily,
        //             fontSize: //GlobalVariable.ratioHeight(
        //                 //bContext != null ? bContext : context) *
        //                 GlobalVariable.ratioFontSize(
        //                         bContext != null ? bContext : context) *
        //                     fontSize,
        //             fontWeight: fontWeight,
        //             color: color,
        //             fontStyle: fontStyle,
        //             height: height,
        //             foreground: foreground,
        //             decoration: decoration)),
        //     GestureDetector(
        //       onTap: () {
        //         onTap();
        //       },
        //       child: Container(
        //         margin: EdgeInsets.only(
        //           left: GlobalVariable.ratioWidth(context) * 6, 
        //         ),
        //         padding: EdgeInsets.only(
        //           bottom: GlobalVariable.ratioWidth(context) * 6, 
        //         ),
        //         alignment: Alignment.topCenter,
        //         width: GlobalVariable.ratioWidth(context) * iconAssetsWidth,
        //         height: GlobalVariable.ratioWidth(context) * iconAssetsHeight + 4.75,
        //         child: SvgPicture.asset(
        //           iconAssets,
        //           width: GlobalVariable.ratioWidth(context) * iconAssetsWidth,
        //           height: GlobalVariable.ratioWidth(context) * iconAssetsHeight,
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }
}

class CustomTextField extends TextField {
  final BuildContext context;
  final InputDecoration newInputDecoration;
  final EdgeInsets newContentPadding;
  final double textSize;

  CustomTextField({
    @required this.context,
    @required this.newInputDecoration,
    this.newContentPadding,
    this.textSize = 14,
    Key key,
    TextEditingController controller,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle style,
    StrutStyle strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical,
    TextDirection textDirection,
    bool readOnly = false,
    ToolbarOptions toolbarOptions,
    bool showCursor,
    bool autofocus = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    bool maxLengthEnforced = true,
    MaxLengthEnforcement maxLengthEnforcement,
    ValueChanged<String> onChanged,
    VoidCallback onEditingComplete,
    ValueChanged<String> onSubmitted,
    AppPrivateCommandCallback onAppPrivateCommand,
    List<TextInputFormatter> inputFormatters,
    bool enabled,
    double cursorWidth = 2.0,
    double cursorHeight,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool enableInteractiveSelection = true,
    TextSelectionControls selectionControls,
    GestureTapCallback onTap,
    MouseCursor mouseCursor,
    InputCounterWidgetBuilder buildCounter,
    ScrollController scrollController,
    ScrollPhysics scrollPhysics,
    Iterable<String> autofillHints,
    String restorationId,
  }) : super(
            key: key,
            controller: controller,
            focusNode: focusNode,
            decoration: newInputDecoration.copyWith(
                contentPadding: newContentPadding == null
                    ? null
                    : EdgeInsets.fromLTRB(
                        newContentPadding.left,
                        newContentPadding.top + (textSize * 2.3 / 11),
                        newContentPadding.right,
                        newContentPadding.bottom),
                hintStyle: newInputDecoration.hintStyle != null
                    ? newInputDecoration.hintStyle.copyWith(
                        fontFamily: "AvenirNext",
                        fontSize: GlobalVariable.ratioWidth(context) * textSize)
                    : TextStyle(
                        fontFamily: "AvenirNext",
                        fontSize:
                            GlobalVariable.ratioWidth(context) * textSize)),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            style: style == null
                ? TextStyle(
                    fontFamily: "AvenirNext",
                    fontSize: GlobalVariable.ratioWidth(context) * 14)
                : style.copyWith(
                    fontFamily: "AvenirNext",
                    fontSize: GlobalVariable.ratioWidth(context) * textSize),
            strutStyle: strutStyle,
            textAlign: textAlign,
            textAlignVertical: textAlignVertical,
            textDirection: textDirection,
            readOnly: readOnly,
            toolbarOptions: toolbarOptions,
            showCursor: showCursor,
            autofocus: autofocus,
            obscuringCharacter: obscuringCharacter,
            obscureText: obscureText,
            autocorrect: autocorrect,
            smartDashesType: smartDashesType,
            smartQuotesType: smartQuotesType,
            enableSuggestions: enableSuggestions,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands,
            maxLength: maxLength,
            maxLengthEnforced: maxLengthEnforced,
            maxLengthEnforcement: maxLengthEnforcement,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onSubmitted: onSubmitted,
            onAppPrivateCommand: onAppPrivateCommand,
            inputFormatters: inputFormatters,
            enabled: enabled,
            cursorWidth: cursorWidth,
            cursorHeight: cursorHeight,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            keyboardAppearance: keyboardAppearance,
            scrollPadding: scrollPadding,
            dragStartBehavior: dragStartBehavior,
            enableInteractiveSelection: enableInteractiveSelection,
            selectionControls: selectionControls,
            onTap: onTap,
            mouseCursor: mouseCursor,
            buildCounter: buildCounter,
            scrollController: scrollController,
            scrollPhysics: scrollPhysics,
            autofillHints: autofillHints,
            restorationId: restorationId);
}

class CustomTextField2 extends StatelessWidget {
  final InputDecoration newInputDecoration;
  final EdgeInsets newContentPadding;
  final double textSize;
  final Key key;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final TextDirection textDirection;
  final bool readOnly;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType smartDashesType;
  final SmartQuotesType smartQuotesType;
  final bool enableSuggestions;
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final bool maxLengthEnforced;
  final MaxLengthEnforcement maxLengthEnforcement;
  final ValueChanged<String> onChanged;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onSubmitted;
  final AppPrivateCommandCallback onAppPrivateCommand;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final double cursorWidth;
  final double cursorHeight;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final DragStartBehavior dragStartBehavior;
  final bool enableInteractiveSelection;
  final TextSelectionControls selectionControls;
  final GestureTapCallback onTap;
  final MouseCursor mouseCursor;
  final InputCounterWidgetBuilder buildCounter;
  final ScrollController scrollController;
  final ScrollPhysics scrollPhysics;
  final Iterable<String> autofillHints;
  final String restorationId;
  final double borderRadius;
  bool isEnabled = false;

  CustomTextField2(
      {@required this.newInputDecoration,
      @required this.newContentPadding,
      this.textSize = 14,
      this.key,
      this.controller,
      this.focusNode,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none,
      this.style,
      this.strutStyle,
      this.textAlign = TextAlign.start,
      this.textAlignVertical,
      this.textDirection,
      this.readOnly = false,
      this.toolbarOptions,
      this.showCursor,
      this.autofocus = false,
      this.obscuringCharacter = '•',
      this.obscureText = false,
      this.autocorrect = true,
      this.smartDashesType,
      this.smartQuotesType,
      this.enableSuggestions = true,
      this.maxLines = 1,
      this.minLines,
      this.expands = false,
      this.maxLength,
      this.maxLengthEnforced = true,
      this.maxLengthEnforcement,
      this.onChanged,
      this.onEditingComplete,
      this.onSubmitted,
      this.onAppPrivateCommand,
      this.inputFormatters,
      this.enabled,
      this.cursorWidth = 2.0,
      this.cursorHeight,
      this.cursorRadius,
      this.cursorColor,
      this.keyboardAppearance,
      this.scrollPadding = const EdgeInsets.all(20.0),
      this.dragStartBehavior = DragStartBehavior.start,
      this.enableInteractiveSelection = true,
      this.selectionControls,
      this.onTap,
      this.mouseCursor,
      this.buildCounter,
      this.scrollController,
      this.scrollPhysics,
      this.autofillHints,
      this.restorationId,
      this.borderRadius,
      this.isEnabled});

  @override
  Widget build(BuildContext context) {
    var enabledBorder = newInputDecoration.enabledBorder;
    var borderContainer = newInputDecoration.border;
    return Container(
      decoration: BoxDecoration(
          color: newInputDecoration.fillColor,
          border: borderContainer == null
              ? null
              : Border.all(
                  color: isEnabled
                      ? enabledBorder.borderSide.color
                      : borderContainer.borderSide.color,
                  width: isEnabled
                      ? enabledBorder.borderSide.width
                      : borderContainer.borderSide.width),
          borderRadius: borderRadius == null
              ? null
              : BorderRadius.circular(borderRadius)),
      alignment: Alignment.center,
      child: TextField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          decoration: newInputDecoration.copyWith(
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: newContentPadding == null
                  ? null
                  : EdgeInsets.fromLTRB(
                      newContentPadding.left,
                      newContentPadding.top + (textSize * 2.3 / 11),
                      newContentPadding.right,
                      newContentPadding.bottom),
              hintStyle: newInputDecoration.hintStyle != null
                  ? newInputDecoration.hintStyle.copyWith(
                      fontFamily: "AvenirNext",
                      fontSize: GlobalVariable.ratioWidth(context) * textSize)
                  : TextStyle(
                      fontFamily: "AvenirNext",
                      fontSize: GlobalVariable.ratioWidth(context) * textSize)),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: textCapitalization,
          style: style == null
              ? TextStyle(
                  fontFamily: "AvenirNext",
                  fontSize: GlobalVariable.ratioWidth(context) * textSize)
              : style.copyWith(
                  fontFamily: "AvenirNext",
                  fontSize: GlobalVariable.ratioWidth(context) * textSize),
          strutStyle: strutStyle,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          textDirection: textDirection,
          readOnly: readOnly,
          toolbarOptions: toolbarOptions,
          showCursor: showCursor,
          autofocus: autofocus,
          obscuringCharacter: obscuringCharacter,
          obscureText: obscureText,
          autocorrect: autocorrect,
          smartDashesType: smartDashesType,
          smartQuotesType: smartQuotesType,
          enableSuggestions: enableSuggestions,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          maxLength: maxLength,
          maxLengthEnforced: maxLengthEnforced,
          maxLengthEnforcement: maxLengthEnforcement,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSubmitted: onSubmitted,
          onAppPrivateCommand: onAppPrivateCommand,
          inputFormatters: inputFormatters,
          enabled: enabled,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          keyboardAppearance: keyboardAppearance,
          scrollPadding: scrollPadding,
          dragStartBehavior: dragStartBehavior,
          enableInteractiveSelection: enableInteractiveSelection,
          selectionControls: selectionControls,
          onTap: onTap,
          mouseCursor: mouseCursor,
          buildCounter: buildCounter,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          autofillHints: autofillHints,
          restorationId: restorationId),
    );
  }
}

class CustomTextFormField extends TextFormField {
  final BuildContext context;
  final InputDecoration newInputDecoration;
  final EdgeInsets newContentPadding;
  final double textSize;

  CustomTextFormField({
    @required this.context,
    @required this.newInputDecoration,
    this.newContentPadding,
    this.textSize = 14,
    Key key,
    TextEditingController controller,
    String initialValue,
    FocusNode focusNode,
    InputDecoration decoration = const InputDecoration(),
    TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions toolbarOptions,
    bool showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType smartDashesType,
    SmartQuotesType smartQuotesType,
    bool enableSuggestions = true,
    bool maxLengthEnforced = true,
    MaxLengthEnforcement maxLengthEnforcement,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    ValueChanged<String> onChanged,
    GestureTapCallback onTap,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    FormFieldSetter<String> onSaved,
    FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    bool enabled,
    double cursorWidth = 2.0,
    double cursorHeight,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    TextSelectionControls selectionControls,
    InputCounterWidgetBuilder buildCounter,
    ScrollPhysics scrollPhysics,
    Iterable<String> autofillHints,
    AutovalidateMode autovalidateMode,
    ScrollController scrollController,
    bool isShowCounter = true,
  }) : super(
            key: key,
            controller: controller,
            initialValue: initialValue,
            focusNode: focusNode,
            decoration: newInputDecoration.copyWith(
                contentPadding: newContentPadding == null
                    ? null
                    : EdgeInsets.fromLTRB(
                        newContentPadding.left,
                        newContentPadding.top + (textSize * 2.3 / 11),
                        newContentPadding.right,
                        newContentPadding.bottom),
                hintStyle: newInputDecoration.hintStyle != null
                    ? newInputDecoration.hintStyle.copyWith(
                        fontFamily: "AvenirNext",
                        fontSize: GlobalVariable.ratioWidth(context) * textSize)
                    : TextStyle(
                        fontFamily: "AvenirNext",
                        fontSize:
                            GlobalVariable.ratioWidth(context) * textSize),
                counterText: isShowCounter ? null : ""),
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            style: style == null
                ? TextStyle(
                    fontFamily: "AvenirNext",
                    fontSize: GlobalVariable.ratioWidth(context) * textSize)
                : style.copyWith(
                    fontFamily: "AvenirNext",
                    fontSize: GlobalVariable.ratioWidth(context) * textSize),
            strutStyle: strutStyle,
            textAlign: textAlign,
            textAlignVertical: textAlignVertical,
            textDirection: textDirection,
            readOnly: readOnly,
            toolbarOptions: toolbarOptions,
            showCursor: showCursor,
            autofocus: autofocus,
            obscuringCharacter: obscuringCharacter,
            obscureText: obscureText,
            autocorrect: autocorrect,
            smartDashesType: smartDashesType,
            smartQuotesType: smartQuotesType,
            enableSuggestions: enableSuggestions,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands,
            maxLength: maxLength,
            maxLengthEnforced: maxLengthEnforced,
            maxLengthEnforcement: maxLengthEnforcement,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            onSaved: onSaved,
            validator: validator,
            inputFormatters: inputFormatters,
            enabled: enabled,
            cursorWidth: cursorWidth,
            cursorHeight: cursorHeight,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            keyboardAppearance: keyboardAppearance,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            selectionControls: selectionControls,
            buildCounter: buildCounter,
            scrollPhysics: scrollPhysics,
            autofillHints: autofillHints,
            autovalidateMode: autovalidateMode);
}

class FontTopPadding {
  static double getSize(double fontSize) {
    return (fontSize * 2.3 / 11);
  }
}
