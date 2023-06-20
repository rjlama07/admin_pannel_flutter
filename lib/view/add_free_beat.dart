import 'package:admin_pannel/controller/beat_controller.dart';
import 'package:admin_pannel/view/beat_page/widget/paid_beat.dart';
import 'package:admin_pannel/widget/custom_button.dart';
import 'package:admin_pannel/widget/sucess_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFreebeat extends StatelessWidget {
  const AddFreebeat({super.key});

  @override
  Widget build(BuildContext context) {
    final beatName = TextEditingController();
    final producerName = TextEditingController();
    final controller = Get.find<BeatController>();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customField(
                            hintText: "Beat Name", controller: beatName),
                        const SizedBox(height: 20),
                        customField(
                            hintText: "Producername", controller: producerName),
                        const SizedBox(height: 30),
                        Obx(() => InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                controller.uploadBeat(
                                    beatName.text, producerName.text, () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 200,
                                        child: SucessMessage(
                                            message:
                                                "Beat Uploaded Sucessfully",
                                            onpressed: () {
                                              Get.back();
                                            },
                                            buttonlabel: "Ok"),
                                      );
                                    },
                                  );
                                });
                              }
                            },
                            child: CustomButton(
                                isloading: controller.isloading.value,
                                label: "Upload")))
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
