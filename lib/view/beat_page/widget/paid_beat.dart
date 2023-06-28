import 'package:admin_pannel/constants/colors.dart';
import 'package:admin_pannel/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/beat_controller.dart';
import '../../../widget/sucess_message.dart';

class PaidBeats extends StatelessWidget {
  const PaidBeats({super.key});

  @override
  Widget build(BuildContext context) {
    final beatNameController = TextEditingController();
    final producerNameController = TextEditingController();
    final priceController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final controller = Get.find<BeatController>();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customField(
                    hintText: "Beat name", controller: beatNameController),
                customField(
                    hintText: "Producer name",
                    controller: producerNameController),
                customField(
                  hintText: "Price",
                  controller: priceController,
                  validator: (p0) {
                    try {
                      double.parse(p0.toString());
                    } catch (e) {
                      return "Enter a valid price";
                    }
                  },
                ),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () async {
                      controller.isUploading.value = true;
                      String? beat = await controller.pickAndGetFormData();
                      controller.isUploading.value = false;
                      if (beat != null) {
                        controller.sampleBeat.value = beat;
                      }
                    },
                    child: Obx(() => Upload_button(
                        color: controller.isUploading.value
                            ? Colors.grey[200]
                            : null,
                        text: controller.isUploading.value
                            ? "Uploading..."
                            : controller.sampleBeat.value == ""
                                ? "Upload Sample Beat"
                                : "Uploaded"))),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () async {
                      controller.isfullBeatUploading.value = true;
                      String? beat = await controller.pickAndGetFormData();
                      controller.isfullBeatUploading.value = false;
                      if (beat != null) {
                        controller.fullBeat.value = beat;
                      }
                    },
                    child: Obx(() => Upload_button(
                        color: controller.isfullBeatUploading.value
                            ? Colors.grey[200]
                            : null,
                        text: controller.isfullBeatUploading.value
                            ? "Uploading..."
                            : controller.fullBeat.value == ""
                                ? "Upload Full Beat"
                                : "Uploaded"))),
                const SizedBox(height: 20),
                InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (controller.fullBeat.value != "" ||
                            controller.sampleBeat.value != "") {
                          controller.uploadPaidBeat(
                              beatNameController.text,
                              priceController.text,
                              producerNameController.text, () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 200,
                                  child: SucessMessage(
                                      message: "Beat Uploaded Sucessfully",
                                      onpressed: () {
                                        controller.fullBeat.value = "";
                                        controller.sampleBeat.value = "";
                                        Get.back();
                                      },
                                      buttonlabel: "Ok"),
                                );
                              },
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Plese Upload beats")));
                        }
                      }
                    },
                    child: Obx(() => CustomButton(
                          isloading: controller.ispaidBeatLoading.value,
                          label: "Upload",
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Upload_button extends StatelessWidget {
  const Upload_button({super.key, required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: 200,
      decoration: BoxDecoration(color: color ?? primaryColor),
      child: Row(
        children: [
          const Icon(
            Icons.upload,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

Container customField({
  required String hintText,
  TextEditingController? controller,
  Function(String?)? validator,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return "Field is requireed";
        }
        if (validator != null) {
          String? okay = validator(value);
          return okay;
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
    ),
  );
}
