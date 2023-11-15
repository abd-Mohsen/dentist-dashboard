import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/side_menu_controller.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    return GetBuilder<SideMenuController>(
      builder: (con) => IndexedStack(
        index: con.selectedTab,
        children: con.tabs,
      ),
    );
  }
}
