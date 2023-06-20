import 'package:admin_pannel/constants/colors.dart';
import 'package:admin_pannel/controller/nav_controllerd.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavController());
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height * 0.35,
            color: primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: 200,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/logo.png"))),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                      child: Obx(
                    () => ListView(
                      children: controller.navbarItems
                          .map((e) => sideBarItem(
                              e, controller.navbarItems.indexOf(e), controller))
                          .toList(),
                    ),
                  ))
                ],
              ),
            ),
          ),
          Expanded(
              child: Obx(() => IndexedStack(
                    index: controller.selectedIndex.value,
                    children: controller.pages,
                  )))
        ],
      ),
    );
  }
}

InkWell sideBarItem(
    NavBarItems navBarItems, int index, NavController controller) {
  bool isSelected = controller.selectedIndex.value == index;

  return InkWell(
    onTap: () {
      controller.selectedIndex.value = index;
    },
    child: Container(
      color: isSelected ? Colors.white : null,
      margin: const EdgeInsets.only(bottom: 10),
      height: 50,
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Icon(
              navBarItems.icon,
              color: isSelected ? primaryColor : Colors.grey[200],
            ),
            const SizedBox(width: 10),
            Text(
              navBarItems.lable,
              style: TextStyle(
                  color: isSelected ? primaryColor : Colors.grey[200]),
            )
          ],
        ),
      ),
    ),
  );
}
