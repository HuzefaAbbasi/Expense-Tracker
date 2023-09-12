import 'package:flutter/material.dart';
import '../../utils/themes.dart';

class RemeberMeRow extends StatelessWidget {
  const RemeberMeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(value: false, onChanged: (dummy) {}),
            const Text('Remember me')
          ],
        ),
        InkWell(
          onTap: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Not supported yet'))),
          child: const Text(
            'Forget password?',
            style: TextStyle(
                color: MyThemes.greenColor, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
