import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

class GlobalViewModel with ChangeNotifier {
  final GeneratedDatabase db;

  GlobalViewModel(this.db);
}
