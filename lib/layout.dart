import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/large_screen.dart';
import 'package:dentist_dashboard/views/components/small_screen.dart';
import 'package:dentist_dashboard/views/components/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  Layout({super.key});
  final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: cs.surface,
        title: Visibility(child: Text("dashboard", style: tt.titleLarge!.copyWith(color: cs.onSurface))),
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
              IconButton(
                onPressed: () {
                  //
                },
                icon: Tooltip(
                  message: "notifications".tr,
                  child: Badge(
                    child: Icon(
                      Icons.notifications,
                      color: cs.onSurface,
                      //semanticLabel: "notifications",
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 2,
                color: cs.onSurface.withOpacity(0.3),
                width: 30,
                indent: 15,
                endIndent: 15,
              ),
              Text(
                "abd Mohsen", //todo: handle the case when name is long (without using sized box)
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: tt.titleSmall!.copyWith(color: cs.onSurface.withOpacity(0.5)),
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
        child: Container(
          color: Colors.black,
          height: 50,
          width: 50,
        ),
      ),
      body: const ResponsiveWidget(largeWidget: LargeScreen(), smallWidget: SmallScreen()),
    );
  }
}
