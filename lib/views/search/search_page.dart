import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/models/mock_var_data.dart';
import 'package:saleonlinemobile/models/searchModel/product_search_vm.dart';
import 'package:saleonlinemobile/views/shares/searchCart/product_search_cart.dart';
import '../shares/headerpage/search_header.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // declear variable
  List<String> _filtter = [];
  List<ProductSearchVm> _product = [];

  bool isVisible = true;
  ScrollController controller = ScrollController();

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
    _filtter = MockVarData.favoriteFiltter;
    _product = MockVarData.productSearch;
    // func listener
    controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    final direction = controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      setState(() {
        isVisible = true;
      });
    } else {
      setState(() {
        isVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: _handleRefresh,
        height: 70,
        child: Column(children: [
          // page header
          const SearchHeader(),

          // sponsered
          showSponsered(),

          // divider
          isVisible
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    height: 0.3,
                    color: Colors.grey[300],
                  ),
                )
              : const SizedBox(),

          // category filter
          filtterCategory(),

          // divider
          isVisible
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    height: 0.3,
                    color: Colors.grey[300],
                  ),
                )
              : const SizedBox(),

          // contain scroll
          Expanded(
              child: ListView(
            controller: controller,
            children: [
              const SizedBox(
                height: 15,
              ),

              // top cart scroll
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (context, index) => topProductCart(
                      'https://i.pinimg.com/236x/b6/db/9c/b6db9c7edf0b530e18a757b3f6f7c9cf.jpg',
                      'Jacob & Co. - Epic X Limited Edition Hand-Wound '),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  height: 0.2,
                  color: Color.fromARGB(226, 224, 224, 224),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    const Text(
                      'Results for "Text Search"',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '(1000+)',
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Text(
                      'Price when purchased online',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.error_outline,
                      color: Colors.grey[600],
                      size: 18,
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 310, crossAxisCount: 1),
                shrinkWrap: true,
                itemCount: _product.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ProductSearchCart(
                    imgUrl: _product[index].imgUrl,
                    isBestSeller: _product[index].isBestSeller,
                    isSponsored: _product[index].isSponsored,
                    price: _product[index].price,
                    priceCOZ: _product[index].priceCOZ,
                    name: _product[index].name,
                    count: _product[index].count,
                    isInCart: _product[index].isInCart,
                  ),
                ),
              )
            ],
          ))
        ]));
  }

  Container topProductCart(String url, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: 110,
      child: Column(
        children: [
          SizedBox(
            height: 90,
            child: Image.network(
              url,
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          Text(
            name,
            style: TextStyle(
                fontSize: 14, color: Theme.of(context).colorScheme.primary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  // filtter category
  AnimatedContainer filtterCategory() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 60 : 0,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 42,
              child: isVisible
                  ? ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(216, 224, 224, 224),
                                borderRadius: BorderRadius.circular(16)),
                            child: Center(
                                child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.filter_list,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  'Filtter',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            )),
                          ),
                        ),
                        for (var val in _filtter)
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        216, 224, 224, 224),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                    child: Text(
                                  val,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                )),
                              ),
                            ),
                          ),
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // show sponsered
  AnimatedContainer showSponsered() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 50 : 0,
      child: Wrap(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 4),
            child: SizedBox(
              height: 42,
              child: isVisible
                  ? Row(
                      children: [
                        SizedBox(
                          height: 42,
                          width: 30,
                          child: Image.network(
                              'https://i.pinimg.com/236x/75/c7/f8/75c7f8b60abee5506aea95036351488d.jpg'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Zero suger gummles'),
                        const Spacer(),
                        Text(
                          'Sponsored',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.error_outline,
                          color: Colors.grey[400],
                          size: 18,
                        )
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
