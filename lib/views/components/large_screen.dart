import 'package:dentist_dashboard/controllers/side_menu_controller.dart';
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
          child: Container(
            color: cs.primary,
            child: GetBuilder<SideMenuController>(
              builder: (con) => ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: con.sideMenuItems.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: ListTile(
                    onTap: () {
                      con.toggleActiveItem(con.sideMenuItems[i]);
                    },
                    title: Text(
                      con.sideMenuItems[i].title,
                      style: con.sideMenuItems[i].isSelected
                          ? tt.titleMedium!.copyWith(color: cs.onPrimary, fontWeight: FontWeight.bold)
                          : tt.titleSmall!.copyWith(color: cs.onPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: Icon(
                      con.sideMenuItems[i].icon,
                      size: con.sideMenuItems[i].isSelected ? 30 : 20,
                      color: cs.onPrimary.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(color: cs.background),
        ),
      ],
    );
  }
}
