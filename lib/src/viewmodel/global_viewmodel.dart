import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';

class GlobalViewModel with ChangeNotifier {
  final GeneratedDatabase db;

  GlobalViewModel(this.db);
}
