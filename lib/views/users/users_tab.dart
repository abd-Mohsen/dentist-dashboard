import 'package:dentist_dashboard/controllers/user/users_tab_controller.dart';
import 'package:dentist_dashboard/views/components/my_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme cs = Theme.of(context).colorScheme;
    TextTheme tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: GetBuilder<UsersTabController>(
        init: UsersTabController(),
        builder: (con) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 72.0),
              child: ListView(
                children: [
                  Container(),
                ],
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: MySearchBar(
                textEditingController: con.searchController,
                focusNode: con.searchFocusNode,
                scrollController: con.suggestionsScrollController,
                onTapField: () => con.toggleSearchState(true),
                onTapClear: () {
                  con.searchController.text = "";
                  con.toggleSearchState(true);
                },
                onTapOutsideField: (e) async {
                  await Future.delayed(Duration(milliseconds: 600));
                  con.toggleSearchState(false);
                },
                onQueryChange: (s) => con.search(),
                searchResult: con.searchResult,
                suggestionsVisible: con.searchEnabled && con.searchController.text != "",
                hint: "search for a user by name".tr,
                type: 'user',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
