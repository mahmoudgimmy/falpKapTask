import 'package:flapkap_app/models/Order.dart';
import 'package:flapkap_app/services/local/OrdersLocal.dart';

class ReportViewModel {
  OrdersLocal _orderLocal = OrdersLocal();

  Future<List<Order>> getOrders() => _orderLocal.getOrders();
}
