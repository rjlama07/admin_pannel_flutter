import 'package:admin_pannel/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BeatController extends GetxController {
  RxBool isloading = false.obs;

  Future<String?> pickAndGetFormData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<int> bytes = result.files.single.bytes!;
      String fileName = result.files.single.name;

      String url = postBeat;

      FormData formData = FormData.fromMap({
        "beats": MultipartFile.fromBytes(bytes, filename: fileName),
      });

      try {
        Dio dio = Dio();
        Response response = await dio.post(url, data: formData);
        print("Upload response: ${response.data}");
        return (response.data)["beatUrl"];
      } catch (error) {
        print("Upload error: $error");
        return null;
      }
    }
  }

  Future<void> uploadBeat(
      String beatName, String producerName, BuildContext context) async {
    isloading.value = true;
    String? beatLink = await pickAndGetFormData();
    if (beatLink != null) {
      final data = {
        "beatName": beatName,
        "producerName": producerName,
        "beatUrl": beatLink,
      };
      await Dio().post(uploadBeatUrl, data: data);
      isloading.value = false;
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Photo Uoloaded")));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Beat not uploaded")));
      isloading.value = false;
    }
  }
}
