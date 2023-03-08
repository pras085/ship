import 'package:flutter/material.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/app/modules/Zero%20One/extra_widget/global_variable_zo.dart';

class ZoNotifikasiHargaButton extends StatelessWidget {
  final bool isLoading;
  final void Function() onPressed;
  final String label;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color disabledForegroundColor;
  final Color disabledBackgroundColor;

  const ZoNotifikasiHargaButton({
    Key key,
    this.isLoading = false,
    this.onPressed,
    this.label,
    this.foregroundColor,
    this.backgroundColor,
    this.disabledForegroundColor,
    this.disabledBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool enabled = !isLoading && onPressed != null;
    return Material(
      color: enabled ? backgroundColor : disabledBackgroundColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: GlobalVariable.ratioWidth(context) * 24,
            vertical: GlobalVariable.ratioWidth(context) * 7,
          ),
          child: Row(
            children: [
              // if (isLoading)
              //   SizedBox(
              //     width: GlobalVariable.ratioFontSize(context) * 12,
              //     height: GlobalVariable.ratioFontSize(context) * 12,
              //     child: CircularProgressIndicator(
              //       valueColor: AlwaysStoppedAnimation(disabledForegroundColor),
              //     ),
              //   ),
              // SizedBox(width: GlobalVariable.ratioWidth(context) * 4),
              CustomText(
                label ?? 'OK',
                color: enabled ? foregroundColor : disabledForegroundColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                // height: GlobalVariable.ratioFontSize(context) * (14.4 / 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
