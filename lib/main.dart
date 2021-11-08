import 'package:flapkap_app/cubit/cubit.dart';
import 'package:flapkap_app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'models/SalesData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ReportScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportCubit>(
        create: (BuildContext context) =>
        ReportCubit()
          ..getOrders(),
        child: BlocConsumer<ReportCubit, ReportScreenStates>(
          listener: (context, states) {},

          builder: (context, status) {
            ReportCubit cubit =
            BlocProvider.of<ReportCubit>(context);
            return !kIsWeb ? DefaultTabController(
                length: 2, child: buildTabBarScreens(cubit)) : Row(

              children: [
                Expanded(
                  flex: 1,
                  child: buildMetricWidget(cubit),
                ),
                Expanded(
                  flex: 2,
                  child: buildGraphWidget(cubit),
                )
              ],
            );
          },));
  }

  buildTabBarScreens(ReportCubit cubit) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black45,
              indicatorColor: Colors.white,
              tabs: [
                new Tab(
                  child: Text(
                    "Metric",
                  ),
                ),
                new Tab(
                  child: Text(
                    "Graph",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          buildMetricWidget(cubit),
          buildGraphWidget(cubit)
        ],
      ),
    );
  }

  buildGraphWidget(ReportCubit cubit) {
    SfCartesianChart(
      // Initialize category axis
        primaryXAxis: CategoryAxis(),

        series: <LineSeries<SalesData, String>>[
          LineSeries<SalesData, String>(
            // Bind data source
              dataSource: cubit.salesData,
              xValueMapper: (SalesData sales, _) => sales.date,
              yValueMapper: (SalesData sales, _) => sales.orders,
              dataLabelSettings: DataLabelSettings(isVisible: true)

          )
        ]
    );
  }

  buildMetricWidget(ReportCubit cubit) {
    Container(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Total orders: ${cubit.totalOrders}',
            style: TextStyle(color: Colors.black, fontSize: 20),),
          SizedBox(height: 8,),
          Text('Average Price: ${cubit.averagePrice.round()}',
            style: TextStyle(color: Colors.black, fontSize: 20),),
          SizedBox(height: 8,),
          Text('Returned Orders: ${cubit.returnedOrders}',
            style: TextStyle(color: Colors.black, fontSize: 20),)
        ],
      ),
    );
  }
}
