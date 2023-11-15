import 'package:flutter/material.dart';

class CustomSnakbar extends SnackBar {
  CustomSnakbar({super.key, required String? message})
      : super(content: Text(message ?? 'Algo de Errado'));
}
