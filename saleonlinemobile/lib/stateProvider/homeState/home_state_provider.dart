import 'package:flutter/foundation.dart';
import 'package:saleonlinemobile/models/cartModel/cart_local_storage_vm.dart';
import 'package:saleonlinemobile/models/homModel/company_logo_vm.dart';
import 'package:saleonlinemobile/models/homModel/get_store_vm.dart';

class HomeStateProvider extends ChangeNotifier {
  int lengthItemInCart = 0;
  List<CartLocalStorageVm> itemInCart = [];
  // store
  GetStoreVm primaryStore = GetStoreVm();
  CompanyLogoVm companyLogo = CompanyLogoVm();
  List<GetStoreVm> listStore = [];

  getItemInCart(List<CartLocalStorageVm> item) {
    if (item.isNotEmpty) {
      itemInCart = item;
      lengthItemInCart = item.length;
      //print(lengthItemInCart);
    } else {
      // ignore: avoid_print
      print('emty cart');
    }
    notifyListeners();
  }

  setPrimayStore(GetStoreVm primary) {
    primaryStore = primary;
  }

  setListStore(List<GetStoreVm> store) {
    if (store.isNotEmpty) {
      listStore = store;
    }
  }

  setCompanyLogo(CompanyLogoVm logo) {
    companyLogo = logo;
  }
}
