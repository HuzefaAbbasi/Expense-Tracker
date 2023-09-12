import 'package:flutter/material.dart';

class IconRow extends StatelessWidget {
  const IconRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Not supported yet'))),
            icon: Image.asset('assets/icons/login_signup/google_icon.png')),
        IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Not supported yet'))),
            icon: Image.asset('assets/icons/login_signup/facebook_icon.png')),
        IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Not supported yet'))),
            icon: Image.asset('assets/icons/login_signup/linkedin_icon.png')),
      ],
    );
  }
}
