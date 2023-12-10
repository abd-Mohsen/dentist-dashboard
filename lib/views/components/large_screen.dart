import 'package:dentist_dashboard/controllers/side_menu_controller.dart';
import 'package:dentist_dashboard/views/components/side_menu_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    SideMenuController mC = Get.find();
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GetBuilder<SideMenuController>(
            builder: (con) => Column(
              children: [
                Container(
                  //todo: empty card, and round border when first is selected
                  decoration: BoxDecoration(),
                ),
                Expanded(
                  child: ListView.builder(
                    //padding: const EdgeInsets.only(top: 8),
                    itemCount: con.sideMenuItems.length,
                    itemBuilder: (context, i) => SideMenuCard(
                      onTap: () {
                        con.toggleActiveItem(con.sideMenuItems[i]);
                        // print(Get.currentRoute.contains("${con.sideMenuItems[i].route}"));
                        // print(con.sideMenuItems[i].route);
                        // print(Get.currentRoute);
                      },
                      title: con.sideMenuItems[i].title,
                      icon: con.sideMenuItems[i].icon,
                      isSelected: con.sideMenuItems[i].isSelected, isTop: con.topTab(i), isBottom: con.bottomTab(i),
                      //&& Get.currentRoute.contains("${con.sideMenuItems[i].route}"),
                    ),
                  ),
                ),
                Container(
                  //todo: empty card, and round border when last is selected,
                  //todo: elso expand it when contents are less than screen space
                  decoration: BoxDecoration(),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: GetBuilder<SideMenuController>(
            builder: (con) => IndexedStack(
              index: con.selectedTab,
              children: con.tabs,
            ),
          ),
        ),
      ],
    );
  }
}
