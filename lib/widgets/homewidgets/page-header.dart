import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/utils/routes.dart';
import 'package:money_tracker/utils/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageHeader extends StatefulWidget {
  const PageHeader({super.key});

  @override
  State<PageHeader> createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  String? name = '';
  Future<void> getUserName() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final email = sharedPreferences.getString('email');
    name = email!.split('@')[0];
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    getUserName();
  }

  void logout() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
  }

  @override
  Widget build(BuildContext context) {
    var notificationBox = Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: const BorderRadius.all(Radius.circular(6.67)),
      ),
      child: InkWell(
        onTap: () async {
          logout();
          MyToast.makeToast('Logged out successfully');
          Navigator.pushNamedAndRemoveUntil(
              context, MyRoutes.loginRoute, (route) => false);
        },
        child: const Icon(
          Icons.logout_rounded,
          color: Colors.white,
        ),
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning,',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(name!,
                style: const TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 23)),
          ],
        ),
        notificationBox
      ],
    );
  }
}
