import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muatmuat/app/modules/lokasi_truk_siap_muat/lokasi_truk_siap_muat_status_enum.dart';

// tidak dipakai, digabung ke view utama

class LokasiTrukSiapMuatGrabbingWidget extends StatelessWidget {
  LokasiTrukSiapMuatGrabbingWidget(this.currState);

  LokasiTrukSiapMuatStatus currState;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2))
          ]),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 100,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: EdgeInsets.symmetric(horizontal: 15),
          )
        ],
      ),
    );
  }
}
