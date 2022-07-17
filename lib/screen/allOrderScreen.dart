import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/controllers/orderController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class AllOrdersScreen extends StatefulWidget {
  final String title;

  const AllOrdersScreen(this.title);

  @override
  _AllOrdersScreenState createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
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
    final orderId = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(" ${widget.title} screen "),
        centerTitle: true,
        actions: [
          Container(
            width: Get.width * 0.20,
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    onSubmitted: (s) {
                      if (orderId.text.length > 2) {
                        orderCtroller.searchForOrder(orderId.text);
                      }
                    },
                    controller: orderId,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    cursorColor: Colors.deepPurple,
                    style: TextStyle(color: Colors.deepPurple),
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 1.0),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.deepPurple)),
                      prefixIcon: const Icon(
                        Icons.shopping_bag_rounded,
                        color: Colors.deepPurple,
                      ),
                      labelText: "Order Id",
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (orderId.text.length > 2) {
                        orderCtroller.searchForOrder(orderId.text);
                      }
                    },
                    icon: Icon(Icons.search_outlined))
              ],
            ),
          )
        ],
      ),
      body: Container(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => orderCtroller.isLoadingOrderStuts.value == true
                ? Center(child: CircularProgressIndicator())
                : orderCtroller.allOrderList.isEmpty
                    ? Center(child: Text('no Orders '))
                    : ListView.builder(
                        itemCount: orderCtroller.allOrderList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text('# ' +
                                    orderCtroller.allOrderList[index].orderId
                                        .toString()),
                                subtitle: Text(orderCtroller
                                        .allOrderList[index].totalPrice
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
                                      orderCtroller.allOrderList.removeWhere(
                                          (element) =>
                                              element.orderId ==
                                              orderCtroller
                                                  .allOrderList[index].orderId);
                                    });
                                  },
                                ),
                                onTap: () {
                                  Get.defaultDialog(
                                    title: '# ' +
                                        orderCtroller
                                            .allOrderList[index].orderId
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
                                                      .allOrderList[index]
                                                      .orderDate
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              'Delivery date : ' +
                                                  orderCtroller
                                                      .allOrderList[index]
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
                                                      .allOrderList[index]
                                                      .productPrice
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              'delvreprice : ' +
                                                  orderCtroller
                                                      .allOrderList[index]
                                                      .deliveryPrice
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'total price : ' +
                                              orderCtroller.allOrderList[index]
                                                  .totalPrice
                                                  .toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          height: 250,
                                          child: CachedNetworkImage(
                                            imageUrl: orderCtroller
                                                .allOrderList[index]
                                                .productImage!,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                valueColor:
                                                    new AlwaysStoppedAnimation(
                                                        Color(0xFF812C2C)),
                                                strokeWidth: 2,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        Text(
                                          'Delevry to : ${orderCtroller.allOrderList[index].deliveryPlaceDiscretion}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Center(
                                          child: Container(
                                            height: 40,
                                            width: 200,
                                            child: TextButton(
                                                onPressed: () {
                                                  String url =
                                                      'https://www.google.co.in/maps/@${orderCtroller.allOrderList[index].delvreyLocation?.latitude.toString()},${orderCtroller.allOrderList[index].delvreyLocation?.longitude.toString()},21z';
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
                                    titleStyle: TextStyle(color: Colors.black),
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
        ),
      ),
    );
  }
}
