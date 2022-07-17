import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/orderController.dart';

import 'package:url_launcher/url_launcher.dart';

class OrderScreen extends StatelessWidget {
  final search = Get.find<OrderController>();
  final String title;
  OrderScreen(this.title);
  launchURL(String? url) async {
    if (await canLaunch(url!)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order ' + title),
        centerTitle: true,
      ),
      body: Container(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => search.isLoadingSearchedOrder.isTrue
                ? Center(child: Text('no Orders '))
                : ListView.builder(
                    itemCount: search.searchUserOrder.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text('# ' +
                                search.searchUserOrder[index].orderId
                                    .toString()),
                            subtitle: Text(search
                                    .searchUserOrder[index].totalPrice
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
                              onPressed: () {},
                            ),
                            onTap: () {
                              Get.defaultDialog(
                                title: '# ' +
                                    search.searchUserOrder[index].orderId
                                        .toString(),
                                content: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order date : ' +
                                              search.searchUserOrder[index]
                                                  .orderDate
                                                  .toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Delivery date : ' +
                                              search.searchUserOrder[index]
                                                  .dateOfDelivering
                                                  .toString()
                                                  .replaceAll(':00.000', ''),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'orderprice : ' +
                                              search.searchUserOrder[index]
                                                  .productPrice
                                                  .toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'delvreprice : ' +
                                              search.searchUserOrder[index]
                                                  .deliveryPrice
                                                  .toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'total price : ' +
                                          search
                                              .searchUserOrder[index].totalPrice
                                              .toString(),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 250,
                                      height: 250,
                                      child: CachedNetworkImage(
                                        imageUrl: search.searchUserOrder[index]
                                            .productImage!,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                SizedBox(
                                          height: 20.0,
                                          width: 20.0,
                                          child: CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            valueColor:
                                                new AlwaysStoppedAnimation(
                                                    Color(0xFF812C2C)),
                                            strokeWidth: 2,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Text(
                                      'Delevry to : ${search.searchUserOrder[index].deliveryPlaceDiscretion}',
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
                                                  'https://www.google.co.in/maps/@${search.searchUserOrder[index].delvreyLocation?.latitude.toString()},${search.searchUserOrder[index].delvreyLocation?.longitude.toString()},21z';
                                              launchURL(url);
                                            },
                                            child: Card(
                                              color: Colors.blueAccent,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                middleTextStyle: TextStyle(color: Colors.black),
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
