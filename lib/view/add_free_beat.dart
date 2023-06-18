import 'package:admin_pannel/controller/beat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class AddFreebeat extends StatelessWidget {
  const AddFreebeat({super.key});

  @override
  Widget build(BuildContext context) {
    final beatName = TextEditingController();
    final producerName = TextEditingController();
    final controller = Get.put(BeatController());
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Material(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: beatName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Beat Name",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: producerName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Producer Name",
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(() => InkWell(
                        onTap: () {
                          controller.uploadBeat(
                              beatName.text, producerName.text, context);
                        },
                        child: Container(
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          child: Center(
                              child: controller.isloading.value
                                  ? const CircularProgressIndicator()
                                  : const Text("Upload Beat")),
                        ),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
