import 'package:dentist_dashboard/constants.dart';
import 'package:dentist_dashboard/controllers/home_controller.dart';
import 'package:dentist_dashboard/controllers/side_menu_controller.dart';
import 'package:dentist_dashboard/controllers/theme_controller.dart';
import 'package:dentist_dashboard/controllers/user/user_controller.dart';
import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:dentist_dashboard/models/product_model.dart';
import 'package:dentist_dashboard/services/responsiveness.dart';
import 'package:dentist_dashboard/views/components/large_screen.dart';
import 'package:dentist_dashboard/views/components/small_screen.dart';
import 'package:dentist_dashboard/views/users/user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:search_page/search_page.dart';

import 'controllers/locale_controller.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});
  //final GlobalKey<ScaffoldState>? scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;
    LocaleController lC = LocaleController();
    SideMenuController mC = Get.put(SideMenuController());
    HomeController hC = Get.put(HomeController());
    return Scaffold(
      backgroundColor: cs.background,
      appBar: AppBar(
        elevation: Get.isDarkMode ? 0 : 2,
        shadowColor: Colors.grey,
        backgroundColor: ResponsiveWidget.isSmall(context) ? cs.primary : cs.surface,
        title: Visibility(
          visible: !ResponsiveWidget.isSmall(context),
          child: Text(
            "dashboard",
            style: tt.headlineSmall!.copyWith(color: cs.onSurface),
          ),
        ),
        actions: [
          GetBuilder<HomeController>(builder: (con) {
            return Row(
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
                          style: tt.labelLarge!.copyWith(color: Colors.black),
                        ),
                        leading: const Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.black,
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
                        leading: const Icon(
                          Icons.language,
                          color: Colors.black,
                        ),
                        title: DropdownButton(
                          elevation: 50,
                          iconEnabledColor: Colors.black,
                          dropdownColor: Get.isDarkMode ? cs.surface : Colors.grey.shade200,
                          hint: Text(
                            lC.getCurrentLanguageLabel(),
                            style: tt.labelLarge!.copyWith(color: Colors.black),
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
                  icon: Badge(
                    child: Icon(
                      Icons.notifications,
                      color: cs.onSurface,
                      //semanticLabel: "notifications",
                    ),
                  ),
                  position: PopupMenuPosition.under,
                  itemBuilder: (context) => [
                    const PopupMenuItem(
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
                if (con.fetchedProfile) // if i do it in visibility the whole appbar crashes
                  Visibility(
                    visible: !ResponsiveWidget.isSmall(context),
                    child: con.loadingProfile
                        ? const CircularProgressIndicator()
                        : Text(
                            con.currentUser.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: tt.titleSmall!.copyWith(color: cs.onSurface.withOpacity(0.5)),
                          ),
                  ),
                const SizedBox(width: 16),
                CircleAvatar(
                  radius: 22,
                  foregroundImage: con.fetchedProfile
                      ? NetworkImage("$kHostIP/${con.currentUser.image ?? "storage/profile/default.jpg"}")
                      : null,
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      //side: const BorderSide(width: 0.5),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    tooltip: "profile".tr,
                    icon: Icon(
                      Icons.person,
                      color: cs.onSurface,
                    ),
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        enabled: false,
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: cs.onSecondary,
                                child: con.fetchedProfile
                                    ? PhotoView(
                                        imageProvider: NetworkImage(
                                          "$kHostIP/${con.currentUser.image ?? "storage/profile/default.jpg"}",
                                        ),
                                      ) // todo : fix photo view
                                    : null,
                              ),
                              title: Text(
                                con.currentUser.name,
                                style: tt.labelLarge!.copyWith(color: cs.onSurface),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                con.currentUser.email,
                                style: tt.labelMedium!.copyWith(color: cs.onSurface.withOpacity(0.6)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Divider(color: cs.onSurface),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          Get.put(UserController(user: con.currentUser));
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => UserView(user: con.currentUser),
                          );
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.edit,
                            color: cs.onSurface,
                            size: 20,
                          ),
                          title: Text(
                            "edit profile",
                            style: tt.labelLarge!.copyWith(color: cs.onSurface),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(
                            Icons.logout_sharp,
                            color: cs.error,
                            size: 20,
                          ),
                          title: Text(
                            "Sign out",
                            style: tt.labelLarge!.copyWith(color: cs.onSurface),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        onTap: () {
                          con.signOut();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            );
          }),
          // IconButton(
          //   onPressed: () {
          //     showSearch(
          //       context: context,
          //       delegate: SearchPage<BrandModel>(
          //         items: hC.test, // هون حطي المصفوفة يلي فيها كل المنتجات
          //         searchLabel: 'Search medicines',
          //         suggestion: Center(
          //           child: Text('search medicin by its name'),
          //         ),
          //         failure: Center(
          //           child: Text('No medicine found'),
          //         ),
          //         filter: (product) => [
          //           product.title,
          //           //product.sciname,
          //         ],
          //         builder: (product) => ListTile(
          //           title: Text(product.title),
          //           //subtitle: Text(product.price.toString()),
          //           trailing: Text(''),
          //         ),
          //       ),
          //     );
          //   },
          //   icon: Icon(Icons.search),
          // )
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
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.shopping_cart,
                  color: cs.onSurface,
                )
                // Image.asset(
                //   Get.isDarkMode ? "assets/images/logo_white_low_res.png" : "assets/images/logo_black_low_res.png",
                // ),
                ),
      ),
      drawer: Drawer(
        backgroundColor: cs.primary,
        //surfaceTintColor: Colors.black,
        width: 230,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(
                      Icons.shopping_cart,
                      color: cs.onSurface,
                    ),
                  ),
                  Text(
                    "dashboard",
                    style: tt.titleLarge!.copyWith(color: cs.onSurface),
                  ),
                ],
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
