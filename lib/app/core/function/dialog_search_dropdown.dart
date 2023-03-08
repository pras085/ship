import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:muatmuat/app/core/models/dialog_search_dropdown_item_model.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class DialogSearchDropdown extends StatefulWidget {
  List<DialogSearchDropdownItemModel> listItemData;
  List<DialogSearchDropdownItemModel> _listShowItemData = [];
  void Function(DialogSearchDropdownItemModel item) onTapItem;
  TextEditingController _textEditingController = TextEditingController();

  DialogSearchDropdown(
      {@required this.listItemData, @required this.onTapItem}) {
    _listShowItemData.addAll(this.listItemData);
  }

  @override
  _DialogSearchDropdownState createState() => _DialogSearchDropdownState();
}

class _DialogSearchDropdownState extends State<DialogSearchDropdown> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.width - 20,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: CustomTextField(
                context: Get.context,
                controller: widget._textEditingController,
                textInputAction: TextInputAction.done,
                newInputDecoration: InputDecoration(
                  hintText: "GlobalDialogSearchDropdownLabelHintSearch".tr,
                ),
                onChanged: (value) {
                  _onChangeSearch(value);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget._listShowItemData.length,
                  itemBuilder: (context, index) {
                    return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                            widget.onTapItem(widget._listShowItemData[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: CustomText(widget._listShowItemData[index].value),
                          ),
                        ));
                  }),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  void _onChangeSearch(String value) {
    widget._listShowItemData.clear();
    widget._listShowItemData.addAll(widget.listItemData.where((element) =>
        element.value.toLowerCase().contains(value.toLowerCase())));
    setState(() {});
  }
}
