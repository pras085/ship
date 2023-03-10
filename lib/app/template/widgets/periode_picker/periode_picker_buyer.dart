import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/utils/utils.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';
import 'package:muatmuat/global_variable.dart';

class PeriodePickerBuyer extends StatelessWidget {
  final String title;
  final String startValue;
  final String endValue;
  final Function(String value) onStartSubmitted;
  final Function(String value) onEndSubmitted;

  const PeriodePickerBuyer({ 
    this.title,
    this.startValue,
    this.endValue,
    this.onStartSubmitted,
    this.onEndSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title.isNotEmpty) ...[
          CustomText(
            title,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            height: 1.2,
          ),
          SizedBox(height: GlobalVariable.ratioWidth(context) * 12)
        ],
        Row(
          children: [
            Expanded(
              child: EditText(
                value: startValue,
                onTap: () async {
                  DateTime startDateTime; 
                  DateTime endDateTime; 
                  if (
                    startValue != null
                    && startValue.trim().isNotEmpty
                  ) {
                    startDateTime = DateTime.parse(startValue);
                  }
                  if (
                    endValue != null
                    && endValue.trim().isNotEmpty
                  ) {
                    endDateTime = DateTime.parse(endValue);
                  }
                  final res = await datePicker(
                    context: context,
                    initialDate: startDateTime,
                    endDate: endDateTime,
                  );
                  if (res != null) {
                    onStartSubmitted(res.toIso8601String());
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: GlobalVariable.ratioWidth(context) * 19,
              ),
              child: CustomText("s/d",
                fontSize: 12,
                height: 14.4/12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF676767),
                withoutExtraPadding: true,
              ),
            ),
            Expanded(
              child: EditText(
                value: endValue,
                onTap: () async {
                  DateTime startDateTime; 
                  DateTime endDateTime; 
                  if (
                    startValue != null
                    && startValue.trim().isNotEmpty
                  ) {
                    startDateTime = DateTime.parse(startValue);
                  }
                  if (
                    endValue != null
                    && endValue.trim().isNotEmpty
                  ) {
                    endDateTime = DateTime.parse(endValue);
                  }
                  final res = await datePicker(
                    context: context,
                    initialDate: endDateTime,
                    startDate: startDateTime,
                  );
                  if (res != null) {
                    onEndSubmitted(res.toIso8601String());
                  }
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Future<DateTime> datePicker({
    BuildContext context,
    DateTime initialDate, 
    DateTime startDate, 
    DateTime endDate,
  }) async {
    // mengatasi masalah error ketika dipilih end date dulu
    // sebelum startdate
    if (endDate != null && initialDate == null) {
      initialDate = endDate;
    }
    var selectedDate = await showDatePicker(
      context: context,
      firstDate: startDate ?? DateTime(DateTime.now().year - 10),
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      lastDate: endDate ?? DateTime.now(),
      initialDate: initialDate ?? DateTime.now(),
    );
    return selectedDate;
  }

}

class EditText extends StatelessWidget {

  final String value;
  final VoidCallback onTap;

  EditText({
    @required this.value,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: GlobalVariable.ratioWidth(context) * 142,
        height: GlobalVariable.ratioWidth(context) * 32,
        padding: EdgeInsets.symmetric(
          horizontal: GlobalVariable.ratioWidth(context) * 8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(ListColor.colorGreyTemplate5),
            width: GlobalVariable.ratioWidth(context) * 1
          ),
          borderRadius: BorderRadius.circular(GlobalVariable.ratioWidth(context) * 6),
        ),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: CustomText(value != null ? Utils.formatDate(
                    value: value, 
                    format: "dd/MM/yyyy",
                  ) : "hh/bb/tttt",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 16.8/14,
                  color: Color(value != null ? 0xFF000000 : 0xFF868686),
                  withoutExtraPadding: true,
                ),
              ),
              SvgPicture.asset(
                "assets/ic_calendar.svg",
                width: GlobalVariable.ratioWidth(context) * 16,
                height: GlobalVariable.ratioWidth(context) * 16,
              ),
            ],
          ),
        )
      ),
    );
  }
}