import 'package:flutter/material.dart';

import '../utils/constants/color.dart';
import '../utils/constants/padding.dart';
import '../utils/constants/text_style.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: PaddingConstant.all8,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: ColorConstant.secondaryColor,
            ),
          ),
          Padding(
            padding: PaddingConstant.horizontal16,
            child: Text(
              'or',
              style: TextStyleConstant.bodySmall,
            ),
          ),
          Expanded(
            child: Divider(
              color: ColorConstant.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
