import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saleonlinemobile/views/shares/headerpage/account_header.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isVisible = true;
  ScrollController controller = ScrollController();

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void initState() {
    super.initState();
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
        key: const Key('refresh'),
        color: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: _handleRefresh,
        height: 70,
        child: Column(key: const Key('content'), children: [
          // page header
          const AccountHeader(
            key: Key('header'),
          ),

          // conten cart
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView(
                key: const Key('list_content'),
                controller: controller,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    key: const Key('mail_btn'),
                    onTap: () {
                      Get.toNamed("/mail");
                    },
                    child: Container(
                      key: const Key('mail_containt'),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                              blurRadius: 0,
                              spreadRadius: 1,
                              offset: Offset(
                                0,
                                0,
                              ),
                            ),
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail_outline,
                            color: Colors.blue[400],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Mail",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[500],
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    key: const Key('phone_btn'),
                    onTap: () {
                      Get.toNamed("/phone");
                    },
                    child: Container(
                      key: const Key('phone_content'),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                              blurRadius: 0,
                              spreadRadius: 1,
                              offset: Offset(
                                0,
                                0,
                              ),
                            ),
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_callback_outlined,
                            color: Colors.blue[400],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Phone",
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[500],
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 0,
                            spreadRadius: 1,
                            offset: Offset(
                              0,
                              0,
                            ),
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assignment_outlined,
                              color: Colors.blue[400],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Purchase history",
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[500],
                              size: 20,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 20),
                          child: Text(
                            "Track your orders statuw, start a return, or view perchase histery and receipts .",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          )
        ]));
  }
}
