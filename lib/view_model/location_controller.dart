import 'package:get/get.dart';
import 'package:google_map_getx_demo/utils/database.dart';

import '../models/location_model.dart';

class LocationController extends GetxController {
  List<LocationData> data = <LocationData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    data = await DatabaseHelper.instance.getData();
    update();
  }

  addData({required LocationData location}) async {
    await DatabaseHelper.instance.add(location: location);
    getData();
  }

  deleteData({required int id}) async {
    DatabaseHelper.instance.delete(id: id);
    getData();
  }
}
