import 'package:admin_pannel/view/beat_page/beat_page.dart';
import 'package:admin_pannel/view/dashboard/dashboard.dart';
import 'package:admin_pannel/view/studio_page/studio_page.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class NavController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> pages = const [DashBoard(), BeatPage(), StudioPage()];
  List<NavBarItems> navbarItems = [
    NavBarItems(lable: "Dashboard", icon: Icons.home),
    NavBarItems(lable: "Beats", icon: Icons.music_note),
    NavBarItems(lable: "Studio", icon: Icons.headphones)
  ];
}

class NavBarItems {
  String lable;
  IconData icon;
  NavBarItems({required this.lable, required this.icon});
}
