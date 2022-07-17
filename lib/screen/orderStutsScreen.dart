import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/orderController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderStutesScreen extends StatefulWidget {
  final String title;
  OrderStutesScreen(this.title);
  static const routeName = '/OrdersStutes';

  @override
  _OrderStutesScreenState createState() => _OrderStutesScreenState();
}

class _OrderStutesScreenState extends State<OrderStutesScreen> {
  launchURL(String? url) async {
    if (await canLaunch(url!)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderCtroller = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Obx(
              () => orderCtroller.isLoadingOrderStuts.value == true
                  ? Center(child: CircularProgressIndicator())
                  : orderCtroller.orderList.isEmpty
                      ? Center(child: Text('no ${widget.title} Date '))
                      : ListView.builder(
                          itemCount: orderCtroller.orderList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text('# ' +
                                      orderCtroller.orderList[index].orderId
                                          .toString()),
                                  subtitle: Text(orderCtroller
                                          .orderList[index].totalPrice
                                          .toString() +
                                      'YR'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  selected: true,
                                  selectedTileColor: Colors.grey[300],
                                  leading: Icon(Icons.shopping_bag_rounded),
                                  trailing: IconButton(
                                    icon: Icon(Icons.do_disturb_alt_sharp),
                                    onPressed: () {
                                      setState(() {
                                        orderCtroller.orderList.removeWhere(
                                            (element) =>
                                                element.orderId ==
                                                orderCtroller
                                                    .orderList[index].orderId);
                                      });
                                      // print(orderCtroller.orderList[index]
                                      //     .deliveryPlaceDiscretion);
                                    },
                                  ),
                                  onTap: () {
                                    Get.defaultDialog(
                                      title: '# ' +
                                          orderCtroller.orderList[index].orderId
                                              .toString(),
                                      content: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Order date : ' +
                                                    orderCtroller
                                                        .orderList[index]
                                                        .orderDate
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                'Delivery date : ' +
                                                    orderCtroller
                                                        .orderList[index]
                                                        .dateOfDelivering
                                                        .toString()
                                                        .replaceAll(
                                                            ':00.000', ''),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'orderprice : ' +
                                                    orderCtroller
                                                        .orderList[index]
                                                        .productPrice
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              Text(
                                                'delvreprice : ' +
                                                    orderCtroller
                                                        .orderList[index]
                                                        .deliveryPrice
                                                        .toString(),
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'total price : ' +
                                                orderCtroller
                                                    .orderList[index].totalPrice
                                                    .toString(),
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 250,
                                            height: 250,
                                            child: CachedNetworkImage(
                                              imageUrl: orderCtroller
                                                  .orderList[index]
                                                  .productImage!,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          Text(
                                            'Delevry to : ${orderCtroller.orderList[index].deliveryPlaceDiscretion}',
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Center(
                                            child: Container(
                                              height: 40,
                                              width: 200,
                                              child: TextButton(
                                                  onPressed: () {
                                                    String url =
                                                        'https://www.google.co.in/maps/@${orderCtroller.orderList[index].delvreyLocation?.latitude.toString()},${orderCtroller.orderList[index].delvreyLocation?.longitude.toString()},21z';
                                                    launchURL(url);
                                                  },
                                                  child: Card(
                                                    color: Colors.blueAccent,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text('Delvr To ')
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                      backgroundColor: Colors.white,
                                      titleStyle:
                                          TextStyle(color: Colors.black),
                                      middleTextStyle:
                                          TextStyle(color: Colors.black),
                                      textConfirm: "Accept",
                                      textCancel: 'Regect',
                                      cancelTextColor: Colors.black,
                                      confirmTextColor: Colors.white,
                                      buttonColor: Colors.red,
                                      barrierDismissible: false,
                                      onConfirm: () {
                                        Get.back();
                                      },
                                    );
                                  },
                                ),
                                Divider()
                              ],
                            );
                          }),
            ),
          )),
    );
  }
}
