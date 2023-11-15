import 'package:flutter/material.dart';

class PlayerSoundController extends ChangeNotifier {
  ValueNotifier isPlaying = ValueNotifier(false);
  bool fistPlay = true;
}
