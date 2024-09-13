import 'package:bankopol/constants/colors.dart';
import 'package:flutter/material.dart';

const investmentListTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 16,
  shadows: [
    Shadow(
      offset: Offset(2, 2),
      blurRadius: 2,
    ),
  ],
);

const eventCardTextStyle = TextStyle(
  color: secondaryColor,
  fontWeight: FontWeight.bold,
  fontSize: 16,
  shadows: [
    Shadow(
      offset: Offset(1, 1),
      blurRadius: 2,
      color: Colors.white,
    ),
  ],
);
