import 'package:flutter/material.dart';

import '../app_styles.dart';
import '../size_configs.dart';

class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          name,
          style: TextStyle(
            color: black,
            fontSize: SizeConfig.blockSizeH! * 5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
