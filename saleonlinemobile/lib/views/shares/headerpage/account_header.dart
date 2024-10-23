import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saleonlinemobile/stateProvider/homeState/home_state_provider.dart';

class AccountHeader extends StatefulWidget {
  const AccountHeader({super.key});

  @override
  State<AccountHeader> createState() => _AccountHeaderState();
}

class _AccountHeaderState extends State<AccountHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStateProvider>(builder: (context, value, child) {
      return Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value.primaryStore.name,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                InkWell(
                  onTap: () {},
                  child: Badge(
                    backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                    label: const Text('3'),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4, right: 4),
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      );
    });
  }
}
