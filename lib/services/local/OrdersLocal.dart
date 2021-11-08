import 'dart:convert';

import 'package:flapkap_app/models/Order.dart';
import 'package:flapkap_app/repositories/OrderRepo.dart';
import 'package:flapkap_app/utils/ReadJosnFile.dart';

class OrdersLocal extends OrdersRepo {
  @override
  Future<List<Order>> getOrders() async {
    var jsonData = await readJsonData('assets/json/orders.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => Order.fromJson(e)).toList();
  }
}
