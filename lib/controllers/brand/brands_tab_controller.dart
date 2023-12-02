import 'package:dentist_dashboard/models/brand_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../services/remote_services.dart';

class BrandsTabController extends GetxController {
  final List<BrandModel> _searchResult = [];
  List<BrandModel> get searchResult => _searchResult;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  final ScrollController suggestionsScrollController = ScrollController();

  bool _searchEnabled = false;
  bool get searchEnabled => _searchEnabled;

  void toggleSearchState(bool val) {
    _searchEnabled = val;
    if (!val) searchFocusNode.unfocus();
    update();
  }

  //todo: make a request every one second or so, not on every query change
  //todo: result is being duplicated when typing so fast
  Future search() async {
    _searchResult.clear();
    if (searchController.text.trim() != "") {
      _searchResult.clear();
      _searchResult.addAll((await RemoteServices.searchBrands(searchController.text))!);
    }
    print(_searchResult);
    update();
  }
}
