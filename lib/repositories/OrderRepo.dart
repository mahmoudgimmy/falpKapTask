import 'package:flapkap_app/models/Order.dart';

abstract class OrdersRepo {
  Future<List<Order>> getOrders();
}
