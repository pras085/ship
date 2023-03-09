import 'package:flutter/material.dart';
import 'package:muatmuat/app/template/utils/utils.dart';
import 'package:muatmuat/app/template/widgets/card/card_company.dart';
import 'package:muatmuat/app/template/widgets/card/card_item.dart';
import 'package:muatmuat/app/template/widgets/card/card_product.dart';
import 'package:muatmuat/app/widgets/appbar_detail.dart';
import 'package:muatmuat/global_variable.dart';

class ExampleCardProductBuyer extends StatefulWidget {
  @override
  _ExampleCardProductBuyerState createState() => _ExampleCardProductBuyerState();
}

class _ExampleCardProductBuyerState extends State<ExampleCardProductBuyer> {

  // Card
  bool favorite = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetail(
        title: "Example Card Product Buyer",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(GlobalVariable.ratioWidth(context) * 16),
          child: Column(
            children: [
              CardProduct(
                onTap: () {
                  print('card product');
                },
                highlight: true,
                verified: false,
                favorite: favorite,
                onFavorited: () {
                  setState(() {
                    favorite = !favorite;
                  });
                },
                report: true,
                onReported: () {

                },
                topLabel: 'Promo Kota/Kabupaten',
                topLabelColor: LabelColor.blue,
                date: DateTime.parse('2023-01-13 11:59:50'),
                title: 'Truk Mitsubishi Canter FE71/4rd Th2016 Boxesss',
                subtitle: 'per tahun',
                imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUPZciVijHYaJiNgkZlixxwncOX-fF_-Mnrg&usqp=CAU',
                price: 4000000,
                discountPrice: 2999000,
                detail: {
                  'Kondisi': 'Bekas',
                  'Tahun': 2021,
                  'Warna': 'Biru'
                },
                verticalDetail: true,
                maxWidthDetailLabel: 72,
                location: "Tegalsari, Surabaya, Jawa Timur, Indonesia",
                showDateAtFooter: true,
                formatDate: 'dd MMM yyyy',
                company: 'PT Tunas ',
                onContactViewed: () {

                },
              ),
              SizedBox(height: GlobalVariable.ratioWidth(context) * 10),
              CardCompany(
                onTap: () {
                  print('card company');
                },
                highlight: true,
                verified: true,
                favorite: favorite,
                onFavorited: () {
                  setState(() {
                    favorite = !favorite;
                  });
                },
                report: false,
                onReported: () {

                },
                // topLabel: 'Dealer',
                // topLabelColor: LabelColor.blue,
                title: 'PT Tunas Kreasi Digital fdsafasdfasd fsdafsdafsdafdasd',
                subtitle: 'Papandayan Cargo',
                // address: 'Jl. Kupang Baru no 95, Surabaya',
                // date: DateTime.parse('2023-01-13 11:59:50'),
                imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUPZciVijHYaJiNgkZlixxwncOX-fF_-Mnrg&usqp=CAU',
                information: Information(
                  salary: 'Rp.5000.000 - 6.000.000/bulan',
                  gender: 'Wanita, Pria 17 - 42 Tahun',
                  place: 'Kab. Tangerang',
                  deadline: '12 Desember 2022',
                  // education: 'S1 Teknik Industri',
                  // experience: '1 tahun pengalaman',
                  // staff: 'Staff warehouse di PT ABC Indonesia',
                  // skill: 'Ahli',
                  // job: 'HRD',
                  // preference: 'Preferensi Lokasi Kerja: Tangerang'
                ),
                // detail: {
                //   'Kondisi': 'Bekas',
                //   'Tahun': 2021,
                //   'Warna': 'Biru'
                // },
                // location: "Tegalsari, Surabaya, Jawa Timur, Indonesia",
                // tags: ['WFH', 'Fresh Graduate', 'Pengalaman: 1 Tahun'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}