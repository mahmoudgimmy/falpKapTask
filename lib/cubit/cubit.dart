import 'package:flapkap_app/cubit/states.dart';
import 'package:flapkap_app/models/Order.dart';
import 'package:flapkap_app/models/SalesData.dart';
import 'package:flapkap_app/viewmodels/ReportScreenViewModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<ReportScreenStates> {
  ReportCubit() : super(Initial());
  double averagePrice = 0.0;
  int returnedOrders = 0;
  int totalOrders = 0;
  List<SalesData> salesData = [];

  var _reportViewModel = ReportViewModel();

  getOrders() {
    _reportViewModel.getOrders().then((orders) {
      totalOrders = orders.length;
      _calculateAveragePrice(orders);
      _calculateReturnedOrders(orders);
      _prepareSalesData(orders);
      emit(PrepareOrdersEnding());
    });
  }

  _calculateAveragePrice(List<Order> orders) {
    double sum = 0.0;
    orders.forEach((e) => sum += e.price);
    averagePrice = sum / orders.length;
  }

  _calculateReturnedOrders(List<Order> orders) {
    orders.forEach((element) {
      if (element.status == Status.RETURNED) returnedOrders++;
    });
  }

  _prepareSalesData(List<Order> orders) async {
    Map map = Map<String, int>();

    orders.forEach((element) {
      if (map.containsKey(element.registered))
        map[element.registered] = map[element.registered] + 1;
      else
        map[element.registered] = 1;
    });

    map.forEach((key, value) {
      var saleData = SalesData(key, value);
      salesData.add(saleData);
    });
  }
}
