import 'package:admin_pannel/controller/beat_controller.dart';
import 'package:admin_pannel/controller/studio_controller.dart';
import 'package:admin_pannel/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/hearder.dart';
import '../beat_page/widget/paid_beat.dart';

class StudioPage extends StatelessWidget {
  const StudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final locationController = TextEditingController();
    // ignore: non_constant_identifier_names
    final studioController = Get.put(StudioController());
    final controller = Get.find<BeatController>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(title: "Add Studio"),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customField(
                        hintText: "Studio name", controller: nameController),
                    customField(
                        hintText: "Description",
                        controller: descriptionController),
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
                    customField(
                        hintText: "Location", controller: locationController),
                    const SizedBox(height: 20),
                    InkWell(
                        onTap: () async {
                          controller.isImageUplaoding.value = true;
                          String? image = await controller.pickAndGetFormData(
                              isImage: true);
                          controller.isImageUplaoding.value = false;
                          if (image != null) {
                            controller.imageUrl.value = image;
                          }
                          // }
                        },
                        child: Obx(() => Upload_button(
                            color: controller.isImageUplaoding.value
                                ? Colors.grey[200]
                                : null,
                            text: controller.isImageUplaoding.value
                                ? "Uploading..."
                                : controller.imageUrl.value == ""
                                    ? "Upload image"
                                    : "Uploaded"))),
                    const SizedBox(height: 20),
                    const CustomButton(isloading: false, label: "Add Studio")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
