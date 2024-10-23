import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saleonlinemobile/views/shimmerShare/productCartShimmer/product_cart_shimmer.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key("appbar"),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          key: Key("title"),
          "Phone Number",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SafeArea(
          key: const Key("safe_area"),
          child: Container(
            key: const Key("container"),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              key: const Key("col_column"),
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: CachedNetworkImage(
                    key: const Key("cach_image"),
                    width: MediaQuery.of(context).size.width,
                    imageUrl:
                        "https://i.pinimg.com/564x/a3/f0/e3/a3f0e31002bfb1b4cd4f8d8c5aacaf70.jpg",
                    placeholder: (context, url) => const ProductCartShimmer(),
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  key: const Key("label_phone"),
                  "Enter your Phone Number",
                  style: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: searchInput(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    key: const Key("contain_btn"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(14))),
                    child: const Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  // Search haeder
  Widget searchInput() {
    return CupertinoTextField(
      key: const Key("input"),
      keyboardType: TextInputType.none,
      focusNode: _focusNode,
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 10),
      placeholder: 'XXX XXX XXX',
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: !_isFocused ? Colors.grey.shade500 : Colors.blue.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(14))),
      style: const TextStyle(fontSize: 16),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          "+123",
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
