import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class StudioController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> addStudio(String beatName, String description, Function onsucess,
      String price, String location, String imageUrl) async {
    try {
      isloading.value = true;
      final data = {
        "name": beatName,
        "description": description,
        "price": price,
        "location": location,
        "imageUrl": imageUrl,
      };
      await Dio().post(addStudioUrl, data: data);
      onsucess();

      isloading.value = false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
