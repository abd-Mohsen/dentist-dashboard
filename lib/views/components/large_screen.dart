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
          child: Material(
            color: cs.primary,
            child: GetBuilder<SideMenuController>(
              builder: (con) => ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: con.sideMenuItems.length,
                itemBuilder: (context, i) => SideMenuCard(
                    onTap: () {
                      con.toggleActiveItem(con.sideMenuItems[i]);
                      // print(Get.currentRoute.contains("${con.sideMenuItems[i].route}"));
                      // print(con.sideMenuItems[i].route);
                      // print(Get.currentRoute);
                    },
                    title: Text(
                      con.sideMenuItems[i].title,
                      style:
                          // con.sideMenuItems[i].isSelected
                          //     ? tt.titleMedium!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold) :
                          tt.titleMedium!.copyWith(color: cs.onPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    icon: Icon(
                      con.sideMenuItems[i].icon,
                      size: 25,
                      color: cs.onPrimary.withOpacity(0.8),
                    ),
                    isSelected: con.sideMenuItems[i].isSelected
                    //&& Get.currentRoute.contains("${con.sideMenuItems[i].route}"),
                    ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: GetBuilder<SideMenuController>(
            builder: (con) => con.selectedTab,
          ),
        ),
      ],
    );
  }
}
