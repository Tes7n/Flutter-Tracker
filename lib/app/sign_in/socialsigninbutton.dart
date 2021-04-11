import 'package:flutter/material.dart';

import 'package:flutter_tracker/common_widgets/customelevatedbutton.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    @required String text,
    @required String assetName,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(assetName),
        Text(
          text,
          style: TextStyle(color: textColor, fontSize: 15.0),
        ),
        Opacity(
          opacity: 0.0,
          child: Image.asset(assetName),
        ),
      ],
    ),
    color: color,
    borderRadius: 4.0,
    onPressed: onPressed,
  );
}



