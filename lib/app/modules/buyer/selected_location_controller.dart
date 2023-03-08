// global controller to get and update the location
// for buyer
import 'package:get/get.dart';
import 'package:muatmuat/app/template/select_location_buyer/select_location_buyer_model.dart';

class SelectedLocationController extends GetxController {

  final location = Rxn<SelectLocationBuyerModel>();

}
