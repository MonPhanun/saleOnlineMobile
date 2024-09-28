import 'package:saleonlinemobile/models/homModel/product_cart_vm.dart';
import 'package:saleonlinemobile/models/searchModel/product_search_vm.dart';

class MockVarData {
  // ==== home page
  static List<String> carousel = [
    'https://i.pinimg.com/474x/83/12/71/831271edc70f92b29b2f1dddf5f402a3.jpg',
    'https://i.pinimg.com/474x/27/06/73/27067304e024e85a5fc7c30214297626.jpg',
    'https://i.pinimg.com/474x/47/49/cf/4749cfbca884a542edc9e6c3a8170297.jpg',
    'https://i.pinimg.com/474x/8f/11/50/8f11505c3700e1c16075710247288020.jpg',
    'https://i.pinimg.com/474x/45/56/80/4556808a36dad7a2e8d77d752457b7c0.jpg'
  ];

  static List<String> threeCart = [
    'https://i.pinimg.com/474x/c8/ba/b0/c8bab06ff5b0e178d4958739e61ea646.jpg',
    'https://i.pinimg.com/474x/60/d9/bd/60d9bdc1e0c6c9d4999c9bccfdfa68ed.jpg',
    'https://i.pinimg.com/474x/af/db/77/afdb77e53bd41602b48ecfa88e6f728a.jpg'
  ];

  static List<String> homeCategory = [
    'Saving',
    'Grocery & Essentials',
    'New & Trending',
    'other'
  ];

  static List<ProductCartVM> homeProduct = [
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/03/4b/a6/034ba6d68bfc5e9c98f55ace0e93fa28.jpg',
        name: 'Astronomia Revollution | Jacob & Co.',
        price: 2570000.00,
        localPrice: 2690000.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/54/99/47/549947c7f51cddf57bda2badeb965935.jpg',
        name: 'Jacob & Co. Astronomia Solar',
        price: 1750000.00,
        localPrice: 1960000.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/55/c8/5b/55c85be926efc0b1a90f64d607d3ec8e.jpg',
        name: 'Photography game Camera',
        price: 11500.00,
        localPrice: 12170.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/26/be/56/26be56634ad9773c9d8f6315cac2cba7.jpg',
        name: 'Apple iPhone 14',
        price: 1100.00,
        localPrice: 1170.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl: 'https://m.media-amazon.com/images/I/410eV-BQQvL.UF736,736.jpg',
        name: 'OnePlus 12,16GB',
        price: 670.00,
        localPrice: 7500.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/56/2b/c1/562bc15c8a6137317bf5b23c5874594b.jpg',
        name: 'Astronomia Casino (Jecob & Co)',
        price: 2500000.00,
        localPrice: 1670.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/12/f5/76/12f5766f24d121be446eb04efabb8d89.jpg',
        name: 'SAMSUNG Galaxy Watch 6',
        price: 1200.00,
        localPrice: 1270.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/0e/d7/bf/0ed7bf62ffce9adb0ea54eaf18d925a6.jpg',
        name: '2024 Jacob PINDU Luxury Casino Watch',
        price: 1700000.00,
        localPrice: 1890000.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/b6/db/9c/b6db9c7edf0b530e18a757b3f6f7c9cf.jpg',
        name: 'JACOB & CO. ASTRONOMIA SOLAR',
        price: 2500000.00,
        localPrice: 2874000.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/24/d7/ee/24d7ee306beff96f1da3b43c48ede029.jpg',
        name: 'JACOB & CO. Five Time Zone',
        price: 1300000.00,
        localPrice: 1470000.00,
        currency: 'SGD'),
  ];

  //==========>>> Favorite

  static List<String> favoriteFiltter = [
    'Electronic',
    'Cloth',
    'Funitur',
    'Foods',
    'Drink',
    'Shoes'
  ];

  static List<ProductCartVM> favoriteProduct = [
    ProductCartVM(
        imgUrl: 'https://m.media-amazon.com/images/I/410eV-BQQvL.UF736,736.jpg',
        name: 'OnePlus 12,16GB',
        price: 670.00,
        localPrice: 7500.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/56/2b/c1/562bc15c8a6137317bf5b23c5874594b.jpg',
        name: 'Astronomia Casino (Jecob & Co)',
        price: 2500000.00,
        localPrice: 1670.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/12/f5/76/12f5766f24d121be446eb04efabb8d89.jpg',
        name: 'SAMSUNG Galaxy Watch 6',
        price: 1200.00,
        localPrice: 1270.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/0e/d7/bf/0ed7bf62ffce9adb0ea54eaf18d925a6.jpg',
        name: '2024 Jacob PINDU Luxury Casino Watch',
        price: 1700000.00,
        localPrice: 1890000.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/b6/db/9c/b6db9c7edf0b530e18a757b3f6f7c9cf.jpg',
        name: 'JACOB & CO. ASTRONOMIA SOLAR',
        price: 2500000.00,
        localPrice: 2874000.00,
        currency: 'SGD'),
    ProductCartVM(
        imgUrl:
            'https://i.pinimg.com/236x/24/d7/ee/24d7ee306beff96f1da3b43c48ede029.jpg',
        name: 'JACOB & CO. Five Time Zone',
        price: 1300000.00,
        localPrice: 1470000.00,
        currency: 'SGD'),
  ];

  //============>> Search

  static List<ProductSearchVm> productSearch = [
    ProductSearchVm(
        imgUrl:
            'https://i.pinimg.com/236x/24/d7/ee/24d7ee306beff96f1da3b43c48ede029.jpg',
        isBestSeller: true,
        isSponsored: true,
        price: 29.63,
        priceCOZ: '13.3 c/oz',
        name:
            'Scarlet Nantes Carrot Seeds for Planting, Over 2,800 Seeds for Growing Indoors or Outdoors  Non-GMO,',
        count: 1,
        isInCart: false),
    ProductSearchVm(
        imgUrl:
            'https://i.pinimg.com/236x/0e/d7/bf/0ed7bf62ffce9adb0ea54eaf18d925a6.jpg',
        isBestSeller: true,
        isSponsored: false,
        price: 59.63,
        priceCOZ: '23.3 c/oz',
        name:
            'Scarlet Nantes Carrot Seeds for Planting, Over 2,800 Seeds for Growing Indoors or Outdoors  Non-GMO,',
        count: 1,
        isInCart: true),
    ProductSearchVm(
        imgUrl:
            'https://i.pinimg.com/236x/0e/d7/bf/0ed7bf62ffce9adb0ea54eaf18d925a6.jpg',
        isBestSeller: false,
        isSponsored: true,
        price: 49.63,
        priceCOZ: '23.3 c/oz',
        name:
            'Scarlet Nantes Carrot Seeds for Planting, Over 2,800 Seeds for Growing Indoors or Outdoors  Non-GMO,',
        count: 1,
        isInCart: false),
    ProductSearchVm(
        imgUrl:
            'https://i.pinimg.com/236x/26/be/56/26be56634ad9773c9d8f6315cac2cba7.jpg',
        isBestSeller: true,
        isSponsored: false,
        price: 22.63,
        priceCOZ: '13.3 c/oz',
        name:
            'Scarlet Nantes Carrot Seeds for Planting, Over 2,800 Seeds for Growing Indoors or Outdoors  Non-GMO,',
        count: 1,
        isInCart: true),
    ProductSearchVm(
        imgUrl:
            'https://i.pinimg.com/236x/12/f5/76/12f5766f24d121be446eb04efabb8d89.jpg',
        isBestSeller: true,
        isSponsored: true,
        price: 76.93,
        priceCOZ: '43.3 c/oz',
        name:
            'Scarlet Nantes Carrot Seeds for Planting, Over 2,800 Seeds for Growing Indoors or Outdoors  Non-GMO,',
        count: 1,
        isInCart: false),
  ];
}
