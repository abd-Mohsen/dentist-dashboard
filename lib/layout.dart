import 'package:dentist_dashboard/controllers/side_menu_controller.dart';
import 'package:dentist_dashboard/controllers/theme_controller.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/large_screen.dart';
import 'package:dentist_dashboard/views/components/small_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import 'controllers/locale_controller.dart';

class Layout extends StatelessWidget {
  Layout({super.key});
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    LocaleController lC = LocaleController();
    SideMenuController mC = Get.put(SideMenuController());
    return Scaffold(
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0 : 3,
        shadowColor: Colors.grey,
        backgroundColor: ResponsiveWidget.isSmall(context) ? cs.primary : cs.surface,
        title: Visibility(
          visible: !ResponsiveWidget.isSmall(context),
          child: Text(
            "dashboard",
            style: tt.headlineMedium!.copyWith(color: cs.onSurface),
          ),
        ),
        actions: [
          Row(
            children: [
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  //side: const BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                tooltip: "settings".tr,
                icon: Icon(
                  Icons.settings,
                  color: cs.onSurface,
                  //semanticLabel: "notifications",
                ),
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(
                      title: Text(
                        "dark theme".tr,
                        style: tt.labelLarge!.copyWith(color: cs.onBackground),
                      ),
                      leading: Icon(
                        Icons.dark_mode_outlined,
                        color: cs.onBackground,
                      ),
                      trailing: GetBuilder<ThemeController>(
                        init: ThemeController(),
                        builder: (con) => Switch(
                          value: con.switchValue,
                          onChanged: (bool value) {
                            con.updateTheme(value);
                          },
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(
                        Icons.language,
                        color: cs.onBackground,
                      ),
                      title: DropdownButton(
                        elevation: 50,
                        iconEnabledColor: cs.onBackground,
                        dropdownColor: Get.isDarkMode ? cs.surface : Colors.grey.shade200,
                        hint: Text(
                          lC.getCurrentLanguageLabel(),
                          style: tt.labelLarge!.copyWith(color: cs.onSurface),
                        ),
                        //button label is updating cuz whole app is rebuilt after changing locale
                        items: [
                          DropdownMenuItem(
                            value: "ar",
                            child: Text("Arabic ".tr),
                          ),
                          DropdownMenuItem(
                            value: "en",
                            child: Text("English ".tr),
                          ),
                        ],
                        onChanged: (val) {
                          lC.updateLocale(val!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  //side: const BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                tooltip: "notifications".tr,
                icon: Icon(
                  Icons.notifications,
                  color: cs.onSurface,
                  //semanticLabel: "notifications",
                ),
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: ListTile(),
                  ),
                ],
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmall(context),
                child: VerticalDivider(
                  thickness: 2,
                  color: cs.onSurface.withOpacity(0.3),
                  width: 30,
                  indent: 15,
                  endIndent: 15,
                ),
              ),
              Visibility(
                visible: !ResponsiveWidget.isSmall(context),
                child: Text(
                  "abd Mohsen",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: tt.titleSmall!.copyWith(color: cs.onSurface.withOpacity(0.5)),
                ),
              ),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 20,
                backgroundColor: cs.secondary,
                child: IconButton(
                  onPressed: () {
                    //
                  },
                  tooltip: "profile".tr,
                  icon: Icon(
                    Icons.person,
                    color: cs.onSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
        leading: ResponsiveWidget.isSmall(context)
            ? Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: cs.onSurface,
                      size: 32.0,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
            : Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(
                      Icons.shopping_cart,
                      color: cs.onSurface,
                    ),
                  )
                ],
              ),
      ),
      drawer: Drawer(
        backgroundColor: cs.primary,
        //surfaceTintColor: Colors.black,
        width: 220,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                "dashboard",
                style: tt.headlineMedium!.copyWith(color: cs.onSurface),
              ),
            ),
            GetBuilder<SideMenuController>(
              builder: (con) => Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
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
          ],
        ),
      ),
      body: const ResponsiveWidget(largeWidget: LargeScreen(), smallWidget: SmallScreen()),
    );
  }
}
