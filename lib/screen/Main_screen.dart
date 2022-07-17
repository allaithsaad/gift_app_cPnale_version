import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/admin_controller.dart';
import '/controllers/stroesController.dart';
import '../widgets/sideMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../controllers/orderController.dart';
import '../controllers/DashboradController.dart';
import 'package:intl/intl.dart';

import '../responsive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final v = Get.find<AdminController>();
  final x = Get.find<StoresController>();
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => v.checkStatus());
    v.getCurrentAdminData();
    x.getUnVerifyProducts();
    v.checkStatus();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        body: SafeArea(
          child: Row(
            children: [
              if (Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: SideMenu(),
                ),
              if (Responsive.isDesktop(context))
                Expanded(flex: 5, child: DashboardMain())
            ],
          ),
        ));
  }
}

class DashboardMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dashboradCtroller = Get.find<DashboradCtroller>();
    final orderCtroller = Get.find<OrderController>();
    final adminController = Get.find<AdminController>();
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Dashborad',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Obx(
                    () => Icon(
                      adminController.connectivityStutes.value
                          ? Icons.wifi
                          : Icons.wifi_off_sharp,
                      color: adminController.connectivityStutes.value
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Center(
                        child: Text(
                          DateFormat('MM/dd/yyyy hh:mm:ss')
                              .format(DateTime.now()),
                        ),
                      );
                    },
                  ),
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          'Hi : ${adminController.currentAdminname.value.isEmpty ? "no name" : adminController.currentAdminname.value.toUpperCase()} ',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.account_circle_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    orderCtroller.fatchOrderStatusPage(0, ' verify user');
                  },
                  child: OrderStatus(
                    stream: dashboradCtroller.requestCount0(),
                    color: Colors.red,
                    title: "   verify user",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    orderCtroller.fatchOrderStatusPage(1, 'Order In Hold');
                  },
                  child: OrderStatus(
                    stream: dashboradCtroller.requestCount1(),
                    color: Colors.blueGrey,
                    title: "Order In Hold",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    orderCtroller.fatchOrderStatusPage(2, 'Order In Hold');
                  },
                  child: OrderStatus(
                    stream: dashboradCtroller.requestCount2(),
                    color: Colors.redAccent,
                    title: "Order In Hold",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    orderCtroller.fatchOrderStatusPage(3, 'Store Working on ');
                  },
                  child: OrderStatus(
                    stream: dashboradCtroller.requestCount3(),
                    color: Colors.pinkAccent,
                    title: "Store Working on ",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    orderCtroller.fatchOrderStatusPage(
                        4, 'Without Delivry Boy');
                  },
                  child: OrderStatus(
                    stream: dashboradCtroller.requestCount4(),
                    color: Colors.yellowAccent,
                    title: "Without Delivry Boy ",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    orderCtroller.fatchOrderStatusPage(5, "On Delivry");
                  },
                  child: OrderStatus(
                    stream: dashboradCtroller.requestCount5(),
                    color: Colors.greenAccent,
                    title: "     On Delivry",
                  ),
                ),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    Key? key,
    required this.stream,
    required this.color,
    required this.title,
  }) : super(key: key);

  final Stream<QuerySnapshot> stream;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: color, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.white70,
      child: SizedBox(
        height: 175,
        width: 175,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 30),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Text(
                        snapshot.data?.size.toString() ?? '0',
                        style: TextStyle(color: Colors.black, fontSize: 50),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
