import 'package:flutter/material.dart';
import 'package:muatmuat/app/template/widgets/halaman_awal/halaman_awal_buyer.dart';
import 'package:muatmuat/app/template/widgets/navbar/navbar.dart';
import 'package:muatmuat/global_variable.dart';

class ExampleHalamanAwalBuyer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// a guide before use this component.
    /// for param [image] , you have to pass a widget that can pass an image whether from assets or network.
    /// > i have provide you some png images that you can use regarding the title.
    /// Dealer & Karoseri > [assets/dealer_karoseri_buyer.png]
    /// Human Capital > [assets/human_capital_buyer.png]
    /// Places & Promo > [assets/places_promos_buyer.png]
    /// Property Warehouse > [assets/property_warehouse_buyer.png]
    /// Repair & Maintenance Services > [assets/repair_maintenance_services_buyer.png]
    /// Transportasi Intermoda > [assets/transportasi_intermoda_buyer.png]
    /// Transportation Store > [assets/transportation_store_buyer.png]
    return Scaffold(
      body: HalamanAwalBuyer(
        title: "Human Capital",
        image: Image.asset(GlobalVariable.urlImageTemplateBuyer + "human_capital_buyer.png",
          fit: BoxFit.cover,
        ),
        location: "Indonesia", /// location based from action [onLocationTap]
        onLocationTap: () {}, /// action when button location was tapped.
        children: [
          /// Here you can use .map() or 'for' iteration to build your view.
          /// 
          /// Example in static ways
          ItemMenuHalamanAwalBuyer(
            context: context,
            image: Image.asset(GlobalVariable.urlImageTemplateBuyer + "kendaraan_kargo_buyer.png"),
            menuTitle: "Kendaraan Kargo",
            onTap: () {
              // a callback that you can use to navigate to other screen.
            },
          ),
          ItemMenuHalamanAwalBuyer(
            context: context,
            image: Image.asset(GlobalVariable.urlImageTemplateBuyer + "kendaraan_kargo_buyer.png"),
            menuTitle: "Kendaraan Kargo",
            onTap: () {},
          ),
        ],
      ),
      /// [ctrl+click] on Navbar to read the documentation.
      bottomNavigationBar: Navbar(
        onTap1: () {},
        onTap2: () {},
        onTap3: () {},
        onTap4: () {},
        selectedIndex: 0,
      ),
    );
  }
}