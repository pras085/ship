import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class ASuffixButton {
  final Icon icon;
  final VoidCallback onPressed;

  ASuffixButton({
    required this.icon, 
    required this.onPressed,
  });
}

class ATextField extends StatelessWidget{
  final TextEditingController? controller;

  final bool autofocus;

  final TextInputType? keyboardType;

  final String? label;

  final String? placeholder;

  final String? errorText;

  final bool obscureText;
  
  final int? maxLines;

  final Widget? prefix;

  final ASuffixButton? suffix;

  final FocusNode? focusNode;
  
  final FormFieldSetter<String>? onSaved;  
  
  final FormFieldValidator<String>? validator;

  final ValueChanged<String>? onFieldSubmitted;
  
  final ValueChanged<String>? onChanged;

  final bool noBorder; 

  final EdgeInsets? contentPadding;

  final double? lineHeight;

  ATextField({
    Key? key,
    this.controller,
    this.autofocus = false,
    this.keyboardType,
    this.label,
    this.placeholder,
    this.errorText,
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.maxLines,
    this.noBorder = false,
    this.contentPadding,
    this.lineHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(label != null)
            Container(
              margin: const EdgeInsets.only(
                bottom: 8,
              ),
              child: Text(
                label ?? '',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          TextFormField(
            style: TextStyle(
              fontSize: AFont.sizeBody,
              height: lineHeight ?? 24/14,
              fontWeight: FontWeight.w500,
              color: AColors.black,
            ),
            focusNode: focusNode,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            controller: controller,
            autofocus: autofocus,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onSaved: onSaved,
            validator: validator,
            decoration: InputDecoration(
              border: noBorder ? InputBorder.none : OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AColors.black50
                ),
                borderRadius: BorderRadius.circular(8)
              ),
              contentPadding: EdgeInsets.only(
                top: contentPadding?.top ?? ASize.spaceNormal,
                bottom: contentPadding?.bottom ?? ASize.spaceNormal,
                left: contentPadding?.left ?? ASize.spaceMedium,
                right:  contentPadding?.right ?? (suffix != null ? ASize.spaceNormal : ASize.spaceMedium),
              ),
              isDense: true,
              alignLabelWithHint: true,
              hintText: placeholder,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                fontSize: 14,
                height: lineHeight ?? 24/14,
                fontWeight: FontWeight.w500,
                color: AColors.gray1,
              ),
              prefixIcon: prefix,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 0,
              ),
              suffixIcon: suffix != null 
                ? InkWell(
                    onTap: suffix!.onPressed,
                    child: Container(
                      width: 24,
                      height: 24,
                      child: Center(
                        child: suffix!.icon,
                      ),
                    ),
                  )
                : null,
              suffixIconConstraints: const BoxConstraints(
                minWidth: 30,
                minHeight: 0,
              ),
              errorText: errorText,
            ),
            maxLines: maxLines,
            minLines: 1,
          ),
        ],
      ),
    );
  }

}