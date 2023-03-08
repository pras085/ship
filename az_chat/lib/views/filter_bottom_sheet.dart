import 'package:azlogistik_chat/utilities/constants.dart';
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatelessWidget {
  final String? selectedFilter;

  const FilterBottomSheet({
    this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: ASize.spaceText
          ),
          child: Center(
            child: Container(
              width: 38,
              height: 3,
              decoration: BoxDecoration(
                color: AColors.gray3,
                borderRadius: BorderRadius.circular(4)
              ),
            ),
          ),
        ),
        const SizedBox(height: ASize.spaceSmall,),
        Row(
          children: [
            const SizedBox(width: 5,),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.close,
                  color: AColors.primary,
                  size: 24,
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
            ),
            const SizedBox(width: 45,),
          ],
        ),
        _filterItem(
          label: 'Semua',
          selected: selectedFilter == null || selectedFilter == '',
          onTap: (){
            Navigator.of(context).pop('');
          },
        ),
        _filterItem(
          label: 'Belum Dibaca',
          selected: selectedFilter == 'unread',
          onTap: (){
            Navigator.of(context).pop('unread');
          },
        ),
        _filterItem(
          label: 'Sudah Dibaca',
          selected: selectedFilter == 'read',
          onTap: (){
            Navigator.of(context).pop('read');
          },
        ),
      ],
    );
  }

  Widget _filterItem({
    required String label,
    bool selected = false,
    VoidCallback? onTap,
  }){
    return ListTile(
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: selected ? AColors.primary : AColors.black50,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
        )
      ),
      horizontalTitleGap: ASize.spaceMedium,
      minLeadingWidth: 0,
      visualDensity: VisualDensity.compact,
      onTap: onTap,
    );
  }

}