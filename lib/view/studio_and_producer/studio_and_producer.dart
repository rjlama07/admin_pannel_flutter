import 'package:admin_pannel/view/studio_and_producer/produer.dart';
import 'package:admin_pannel/view/studio_page/studio_page.dart';
import 'package:flutter/material.dart';

import '../../widget/hearder.dart';

class StudioAndProducer extends StatelessWidget {
  const StudioAndProducer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(title: "Studio and Producer"),
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
                          text: "Add Producer",
                        ),
                        Tab(text: "Add Studio")
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                    child:
                        TabBarView(children: [ProducerPage(), StudioPage()])),
              ],
            ),
          ))
        ],
      ),
    ));
  }
}
