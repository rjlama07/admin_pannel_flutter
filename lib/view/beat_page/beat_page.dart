import 'package:admin_pannel/view/add_free_beat.dart';
import 'package:admin_pannel/view/beat_page/widget/paid_beat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/beat_controller.dart';
import '../../widget/hearder.dart';

class BeatPage extends StatelessWidget {
  const BeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BeatController());
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppHeader(title: "Add Beats"),
            SizedBox(height: 40),
            Expanded(
                child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(
                            text: "Paid Beats",
                          ),
                          Tab(text: "Free Beats")
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                      child:
                          TabBarView(children: [PaidBeats(), AddFreebeat()])),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
