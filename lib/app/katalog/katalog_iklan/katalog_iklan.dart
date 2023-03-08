import 'package:flutter/material.dart';
import 'package:muatmuat/app/katalog/katalog_iklan/repair_and_maintenances/repair_and_maintenances.dart';
import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';
import 'package:muatmuat/app/style/list_colors.dart';
import 'package:muatmuat/app/widgets/custom_text.dart';

class KatalogIklan extends StatefulWidget {
  @override
  State<KatalogIklan> createState() => _KatalogIklanState();
}

class _KatalogIklanState extends State<KatalogIklan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(ListColor.colorBlue),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
                child: CustomText(
                  "Text Style",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              for(int i = 0; i < 4; i++)
                for(double j = 0; j < 6; j++)
                  Padding(
                    padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
                    child: CustomText(
                      i == 0 ? "Reguler - ${10 + (j * 2)}"
                      : i == 1 ? "Medium - ${10 + (j * 2)}"
                        : i == 2 ? "Demi - ${10 + (j * 2)}"
                          : "Bold - ${10 + (j * 2)}", 
                      fontSize: 10 + (j * 2),
                      fontWeight: 
                        i == 0 ? FontWeight.w400
                        : i == 1 ? FontWeight.w500
                          : i == 2 ? FontWeight.w600
                            : FontWeight.w700,
                    ),
                  ),
              RepairAndMainTenances(

              ),
            ],
          ),
        )
      )
    );
  }
}