// import 'package:flutter/material.dart';
// import 'package:muatmuat/app/core/function/change_language.dart';
// import 'package:muatmuat/app/core/models/language_model.dart';
// import 'package:get/get.dart';
// import 'package:muatmuat/app/modules/ARK/extra_widget/list_colors_ark.dart';
// import 'package:muatmuat/app/modules/ARK/extra_widget/global_variable_ark.dart';

// class ChangeLanguageWidget extends StatefulWidget {
//   @override
//   _ChangeLanguageWidgetState createState() => _ChangeLanguageWidgetState();
// }

// class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.only(top: 60, right: 20),
//         height: 32,
//         width: 64,
//         decoration: BoxDecoration(
//             // boxShadow: <BoxShadow>[
//             //   BoxShadow(
//             //     color: Color(ListColor.shadowColor4),
//             //     blurRadius: 2,
//             //     offset: Offset(0, 40 / 5),
//             //   ),
//             // ],
//             borderRadius: BorderRadius.circular(
//                 GlobalVariable.ratioWidth(Get.context) * 20),
//             color: Color(ListColor.color5)),
//         child: Material(
//           borderRadius: BorderRadius.circular(
//               GlobalVariable.ratioWidth(Get.context) * 20),
//           color: Colors.transparent,
//           child: InkWell(
//               borderRadius: BorderRadius.circular(
//                   GlobalVariable.ratioWidth(Get.context) * 20),
//               onTap: () async {
//                 await showListLanguage(context);
//               },
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
//                 child: Center(
//                   child: Text(GlobalVariable.languageCode.toUpperCase(),
//                       style: TextStyle(
//                           fontSize: 14,
//                           color: Color(ListColor.color4),
//                           fontWeight: FontWeight.w600)),
//                 ),
//               )),
//         ));
//   }

//   showListLanguage(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return DialogChooseLanguage();
//         });
//   }
// }

// class DialogChooseLanguage extends StatefulWidget {
//   @override
//   _DialogChooseLanguageState createState() => _DialogChooseLanguageState();
// }

// class _DialogChooseLanguageState extends State<DialogChooseLanguage> {
//   bool isGettingLanguage = true;
//   List<ListLanguageData> newListLanguage = [];

//   @override
//   Widget build(BuildContext context) {
//     if (isGettingLanguage) _getListLanguage(context);
//     return AlertDialog(
//         actions: [],
//         content: Container(
//           width: 300,
//           height: 300,
//           child: isGettingLanguage
//               ? Center(
//                   child: SizedBox(
//                       width: 50,
//                       height: 50,
//                       child: CircularProgressIndicator()),
//                 )
//               : ListView.separated(
//                   separatorBuilder: (context, index) {
//                     return Divider(color: Colors.black);
//                   },
//                   itemCount: newListLanguage.length,
//                   itemBuilder: (context, index) {
//                     var selectedLanguage = newListLanguage[index];
//                     return Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           onTap: () async {
//                             await ChangeLanguage(context).setChangeLanguage(
//                                 selectedLanguage.urlSegment,
//                                 selectedLanguage.locale,
//                                 selectedLanguage.title);
//                             Navigator.pop(context, GlobalVariable.languageCode);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Text(selectedLanguage.title,
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: selectedLanguage.urlSegment ==
//                                               GlobalVariable.languageCode
//                                           ? FontWeight.w700
//                                           : FontWeight.w400)),
//                             ),
//                           ),
//                         ));
//                   }
//                   //   return FlatButton(
//                   //       color: selectedLanguage.urlSegment ==
//                   //               GlobalVariable.languageCode
//                   //           ? Color(ListColor.color4)
//                   //           : null,
//                   //       onPressed: () async {
//                   //         await ChangeLanguage(context).setChangeLanguage(
//                   //             selectedLanguage.urlSegment,
//                   //             selectedLanguage.locale,
//                   //             selectedLanguage.title);
//                   //         // await controller.changeLanguage(
//                   //         //     selectedLanguage.urlSegment,
//                   //         //     selectedLanguage.locale,
//                   //         //     selectedLanguage.title);
//                   //         Navigator.pop(context, GlobalVariable.languageCode);
//                   //       },
//                   //       child: Text(
//                   //         selectedLanguage.title,
//                   //         style: TextStyle(
//                   //             color: selectedLanguage.urlSegment ==
//                   //                     GlobalVariable.languageCode
//                   //                 ? Colors.white
//                   //                 : Colors.black),
//                   //       ));
//                   // }),
//                   ),
//         ));
//   }

//   void _getListLanguage(BuildContext context) async {
//     ChangeLanguage changeLanguage = ChangeLanguage(context);
//     newListLanguage = await changeLanguage.getListLanguage();
//     setState(() {
//       isGettingLanguage = false;
//     });
//   }
// }
