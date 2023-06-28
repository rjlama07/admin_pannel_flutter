import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class StudioController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> addStudio(String beatName, String producerName,
      Function onsucess, String price, String location, String imageUrl) async {
    isloading.value = true;
    final data = {
      "name": beatName,
      "description": producerName,
      "price": price,
      "location": location,
      "imageUrl": imageUrl,
    };
    await Dio().post(addStudioUrl, data: data);
    onsucess();

    isloading.value = false;
  }
}
