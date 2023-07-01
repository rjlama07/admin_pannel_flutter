import 'package:admin_pannel/controller/producer_controller.dart';
import 'package:admin_pannel/model/producer_model.dart';
import 'package:admin_pannel/widget/hearder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/beat_controller.dart';
import '../../controller/studio_controller.dart';
import '../../widget/custom_button.dart';
import '../../widget/sucess_message.dart';
import '../beat_page/widget/paid_beat.dart';

class ProducerPage extends StatelessWidget {
  const ProducerPage({super.key});
  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ratingController = TextEditingController();
    final activeSinceController = TextEditingController();
    final averageDeliveryController = TextEditingController();
    final controller = Get.put(StudioController());
    final beatController = Get.put(BeatController());

    final genreController = TextEditingController();
    final basicVersionController = TextEditingController();
    final basicRevisionController = TextEditingController();
    final basicPriceController = TextEditingController();
    final standardVersionController = TextEditingController();
    final standardRevisionController = TextEditingController();
    final standardPriceController = TextEditingController();
    final premiumVersionController = TextEditingController();
    final premiumRevisionController = TextEditingController();
    final premiumPriceController = TextEditingController();
    final producerController = Get.put(ProducerController());

    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: GestureDetector(
                          onTap: () async {
                            beatController.isImageUplaoding.value = true;
                            String? image = await beatController
                                .pickAndGetFormData(isImage: true);
                            beatController.isImageUplaoding.value = false;
                            if (image != null) {
                              producerController.imageUrl.value = image;
                            }
                            // }
                          },
                          child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 80,
                                      backgroundImage: producerController
                                                  .imageUrl.value !=
                                              ""
                                          ? NetworkImage(
                                              producerController.imageUrl.value)
                                          : null,
                                      child: beatController
                                              .isImageUplaoding.value
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : null),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Upload Image",
                                    style: TextStyle(color: Colors.blue),
                                  )
                                ],
                              ))),
                    ),
                    const SizedBox(height: 20),
                    customField(hintText: "Name", controller: nameController),
                    customField(
                        hintText: "Rating", controller: ratingController),
                    customField(
                        hintText: "Active Since",
                        controller: activeSinceController),
                    customField(
                        hintText: "Average Delivery Time",
                        controller: averageDeliveryController),
                    customField(
                        hintText: "Genere", controller: genreController),
                    const SizedBox(height: 20),
                    const AppHeader(title: "Package", size: 25),
                    const SizedBox(height: 20),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const AppHeader(title: "Basic", size: 20),
                            const SizedBox(height: 20),
                            customField(
                                hintText: "Version",
                                controller: basicVersionController),
                            customField(
                                hintText: "Revision",
                                controller: basicRevisionController),
                            customField(
                              hintText: "Price",
                              controller: basicPriceController,
                              validator: (p0) {
                                try {
                                  double.parse(p0.toString());
                                } catch (e) {
                                  return "Enter a valid price";
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const AppHeader(title: "Standard", size: 20),
                            const SizedBox(height: 20),
                            customField(
                                hintText: "Version",
                                controller: standardVersionController),
                            customField(
                                hintText: "Revision",
                                controller: standardRevisionController),
                            customField(
                              hintText: "Price",
                              controller: standardPriceController,
                              validator: (p0) {
                                try {
                                  double.parse(p0.toString());
                                } catch (e) {
                                  return "Enter a valid price";
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            const AppHeader(title: "Premium", size: 20),
                            const SizedBox(height: 20),
                            customField(
                                hintText: "Version",
                                controller: premiumVersionController),
                            customField(
                                hintText: "Revision",
                                controller: premiumRevisionController),
                            customField(
                              hintText: "Price",
                              controller: premiumPriceController,
                              validator: (p0) {
                                try {
                                  double.parse(p0.toString());
                                } catch (e) {
                                  return "Enter a valid price";
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    Obx(() => InkWell(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (producerController.imageUrl.value != "") {
                              Package basicPackage = Package(
                                  price: basicPriceController.text,
                                  revision: basicRevisionController.text,
                                  version: basicVersionController.text);
                              Package standardPackage = Package(
                                  price: standardPriceController.text,
                                  revision: standardRevisionController.text,
                                  version: standardVersionController.text);
                              Package premiumPackage = Package(
                                  price: premiumPriceController.text,
                                  revision: premiumRevisionController.text,
                                  version: premiumVersionController.text);

                              producerController.addProducer(
                                  producerModel: ProducerModel(
                                      name: nameController.text,
                                      rating: ratingController.text,
                                      activeSince: activeSinceController.text,
                                      profileUrl:
                                          producerController.imageUrl.value,
                                      averageDeliveryTime:
                                          averageDeliveryController.text,
                                      genre: genreController.text,
                                      package: {
                                        "basic": basicPackage.toJson(),
                                        "standard": standardPackage.toJson(),
                                        "premium": premiumPackage.toJson(),
                                      }),
                                  onsucess: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SucessMessage(
                                            message:
                                                "Producer Uploaded Sucessfully",
                                            onpressed: () {
                                              producerController
                                                  .imageUrl.value = "";
                                              Get.back();
                                            },
                                            buttonlabel: "Ok");
                                      },
                                    );
                                  });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Plese Upload image")));
                          }
                        },
                        child: CustomButton(
                            isloading: producerController.isLoading.value,
                            label: "Add Producer")))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
