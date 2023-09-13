//navigate between screens
import 'package:flutter/material.dart';

void switchScreen(BuildContext context, screenName) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screenName));
}
