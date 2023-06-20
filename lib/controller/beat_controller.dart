import 'package:admin_pannel/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/state_manager.dart';

class BeatController extends GetxController {
  RxBool isloading = false.obs;
  RxBool ispaidBeatLoading = false.obs;
  RxBool isUploading = false.obs;
  RxBool isfullBeatUploading = false.obs;

  RxString sampleBeat = "".obs;
  RxString fullBeat = "".obs;

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
        return (response.data)["beatUrl"];
      } catch (error) {
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
