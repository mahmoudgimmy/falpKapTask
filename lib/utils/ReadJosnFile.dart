import 'package:flutter/services.dart' as rootBundle;

Future<String> readJsonData(path) async =>
    await rootBundle.rootBundle.loadString(path);
