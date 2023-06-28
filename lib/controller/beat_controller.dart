import 'package:admin_pannel/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BeatController extends GetxController {
  RxBool isloading = false.obs;
  RxBool ispaidBeatLoading = false.obs;
  RxBool isUploading = false.obs;
  RxBool isfullBeatUploading = false.obs;
  RxBool isImageUplaoding = false.obs;
  RxString imageUrl = "".obs;

  RxString sampleBeat = "".obs;
  RxString fullBeat = "".obs;

  Future<String?> pickAndGetFormData({
    bool isImage = false,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<int> bytes = result.files.single.bytes!;
      String fileName = result.files.single.name;

      String url = isImage ? uploadImage : postBeat;

      String keyValue = isImage ? "image" : "beats";

      FormData formData = FormData.fromMap({
        keyValue: MultipartFile.fromBytes(bytes, filename: fileName),
      });

      try {
        Dio dio = Dio();
        Response response = await dio.post(url, data: formData);
        if (!isImage) {
          return (response.data)["beatUrl"];
        } else {
          return (response.data)["imageUrl"];
        }
      } catch (error) {
        print(error);
        return null;
      }
    }
  }

  Future<void> uploadBeat(
      String beatName, String producerName, Function onsucess) async {
    isloading.value = true;
    String? beatLink = await pickAndGetFormData();
    if (beatLink != null) {
      final data = {
        "beatName": beatName,
        "producerName": producerName,
        "beatUrl": beatLink,
      };
      await Dio().post(uploadBeatUrl, data: data);
      onsucess();
      isloading.value = false;
    } else {
      // ignore: use_build_context_synchronously
      isloading.value = false;
    }
  }

  Future<void> uploadPaidBeat(String beatName, String price,
      String producerName, Function onsucess) async {
    ispaidBeatLoading.value = true;

    final data = {
      "beatName": beatName,
      "producerName": producerName,
      "beatUrl": fullBeat.value,
      "price": price,
      "sampleUrl": sampleBeat.value,
    };
    await Dio().post(uploadPaidBeatUrl, data: data);
    onsucess();
    ispaidBeatLoading.value = false;
  }
}
