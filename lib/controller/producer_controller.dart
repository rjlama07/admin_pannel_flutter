import 'package:admin_pannel/model/producer_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class ProducerController extends GetxController {
  RxBool isLoading = false.obs;
  RxString imageUrl = "".obs;

  Future<void> addProducer({
    required ProducerModel producerModel,
    required Function onsucess,
  }) async {
    isLoading.value = true;
    Map<String, dynamic> data = producerModel.toJson();
    print(data);
    await Dio().post(addProduerUrl, data: data);
    onsucess();
    isLoading.value = false;
  }
}
