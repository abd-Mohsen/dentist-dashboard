import 'package:dentist_dashboard/controllers/side_menu_controller.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/large_screen.dart';
import 'package:dentist_dashboard/views/components/small_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  Layout({super.key});
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    SideMenuController mC = Get.put(SideMenuController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cs.surface,
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
              IconButton(
                onPressed: () {
                  //
                },
                icon: Icon(
                  Icons.settings,
                  color: cs.onSurface,
                ),
              ),
              Tooltip(
                message: "notifications".tr,
                child: IconButton(
                  onPressed: () {
                    //todo: popup menu & new switch statement
                  },
                  icon: Badge(
                    child: Icon(
                      Icons.notifications,
                      color: cs.onSurface,
                      //semanticLabel: "notifications",
                    ),
                  ),
                ),
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
        child: Column(
          children: [
            Text(
              "dashboard",
              style: tt.headlineMedium!.copyWith(color: cs.onSurface),
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
