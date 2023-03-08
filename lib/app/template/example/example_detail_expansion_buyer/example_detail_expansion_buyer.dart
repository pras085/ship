import 'package:flutter/material.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/detail_expansion_buyer.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/file_detail_expansion_buyer.dart';
import 'package:muatmuat/app/template/widgets/detail_expansion_buyer/text_detail_expansion_buyer.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';

import '../../../../global_variable.dart';

class ExampleDetailExpansionBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetail(
        title: "Detail Expansion",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailExpansionBuyer(
              headerText: "Deskripsi", 
              // maxHeight: GlobalVariable.ratioWidth(context) * 100,
              child: (isExpanded, isInitialize) => TextDetailExpansionBuyer(
                isExpanded: isExpanded,
                isInitialize: isInitialize,
                text: "lorem ipsum deo t aslasaldjasldjsladjsad",
              ),
            ),
            DetailExpansionBuyer(
              headerText: "Tentang", 
              maxHeight: GlobalVariable.ratioWidth(context) * 100,
              child: (isExpanded, isInitialize) => TextDetailExpansionBuyer(
                isExpanded: isExpanded,
                isInitialize: isInitialize,
                text: "lorem ipsum deo t aslasaldjasldjsladjsad sdlkjsdlksajdlksajdlkasjdlk sasdjlkdjlsdjsalkd klsdjlkasjdasd asdka;sd assdas;dksa;ld  jflsjflasjf;f sdfjdsljfdsjfk jdfjhsaldfjkfj sddhfklsdhf ldkdnf dlkfk dsljkjfdlkfnsd flskdjkfjhds fdsfnd lkfndslfjdsfkdlflkdshf kjdhf dsfh dkfjhdsas fkkajhkljsadh sadlkfkhsdkjlfhsadkljj slkfhfhhn lkhdjfhlkf lsdshff lkfjlkdhfhdjhfldjhflasdflddhfldflajdfd jsdhdflakhjsads fjhfashlsahdadhlksadhlasjhsajkhd jkhsldkkdskdlsKJDKJKSAJAD ",
              ),
            ),
            DetailExpansionBuyer(
              headerText: "Sertifikat", 
              maxHeight: GlobalVariable.ratioWidth(context) * 146,
              child: (isExpanded, isInitialize) => FileDetailExpansionBuyer(
                itemCount: 3, 
                itemBuilder: (ctx, i) {
                  return TileFileDetailExtensionBuyer(
                    image: '',
                    label: "Sertifikat ${i+1}", 
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}