import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '/controllers/orderController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:url_launcher/url_launcher.dart';

class UserOrdersScreen extends StatefulWidget {
  final String title;
  final bool verfiy;
  final bool blaklist;
  final bool gender;
  final String id;
  final String name;
  final String birthDay;

  const UserOrdersScreen(this.title, this.verfiy, this.blaklist, this.id,
      this.name, this.birthDay, this.gender);

  @override
  _UserOrdersScreenState createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
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
    final TextEditingController verified = TextEditingController();
    final TextEditingController blackList = TextEditingController();
    final TextEditingController name = TextEditingController();
    final TextEditingController birthDay = TextEditingController();

    verified.text = widget.verfiy ? '0' : '1';
    blackList.text = widget.blaklist ? '0' : '1';
    name.text = widget.name;
    birthDay.text = widget.birthDay.replaceAll('00:00:00.000', "");
    return Scaffold(
      appBar: AppBar(
        title: Text(" ${widget.title}  "),
        centerTitle: true,
        actions: [],
      ),
      body: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.gender ? Colors.pink[200] : Colors.blue[200],
                  border: Border(
                    top: BorderSide.none,
                    bottom: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide(color: Colors.black, width: 3),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        maxRadius: 50,
                        backgroundImage: widget.gender
                            ? AssetImage('assets/images/w.png')
                            : AssetImage('assets/images/m.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: name,
                        cursorColor: Colors.deepPurple,
                        style: TextStyle(color: Colors.deepPurple),
                        readOnly: true,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 1.0),
                          ),
                          border: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.deepPurple)),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ),
                          labelText: "User Name",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: birthDay,
                        cursorColor: Colors.deepPurple,
                        style: TextStyle(color: Colors.deepPurple),
                        readOnly: true,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepPurple, width: 1.0),
                          ),
                          border: new OutlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.deepPurple)),
                          prefixIcon: const Icon(
                            Icons.date_range,
                            color: Colors.deepPurple,
                          ),
                          labelText: "Birth Day",
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ToggleSwitch(
                        initialLabelIndex: int.parse(verified.text),
                        minWidth: 150.0,
                        cornerRadius: 20.0,
                        activeBgColors: [
                          [Colors.cyan],
                          [Colors.redAccent]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: ['Verified', 'UnVerified'],
                        icons: [
                          FontAwesomeIcons.userCheck,
                          FontAwesomeIcons.times
                        ],
                        onToggle: (index) {
                          print('switched to: $index');
                          verified.text = index.toString();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ToggleSwitch(
                        initialLabelIndex: int.parse(blackList.text),
                        minWidth: 150.0,
                        cornerRadius: 20.0,
                        activeBgColors: [
                          [Colors.redAccent],
                          [Colors.cyan]
                        ],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: ['In The BlackList', 'Out The BlackList'],
                        icons: [
                          FontAwesomeIcons.userSlash,
                          FontAwesomeIcons.user
                        ],
                        onToggle: (index) {
                          print('switched to: $index');
                          blackList.text = index.toString();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.id)
                                .update({
                              'blacklist': blackList.text == "0" ? true : false,
                              'verifiedUser':
                                  verified.text == "0" ? true : false
                            }).then((value) {
                              Get.back();
                              Get.snackbar('title', 'Done');
                            }).catchError((onError) {
                              Get.snackbar(
                                  "error", "Oprtion Can't be Done $onError");
                            });
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Save Changes '),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.save)
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 4,
            child: Container(
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
                                            orderCtroller
                                                .allOrderList[index].orderId
                                                .toString()),
                                        subtitle: Text(orderCtroller
                                                .allOrderList[index].totalPrice
                                                .toString() +
                                            'YR'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        selected: true,
                                        selectedTileColor: Colors.grey[300],
                                        leading:
                                            Icon(Icons.shopping_bag_rounded),
                                        trailing: IconButton(
                                          icon:
                                              Icon(Icons.do_disturb_alt_sharp),
                                          onPressed: () {
                                            setState(() {
                                              orderCtroller.allOrderList
                                                  .removeWhere((element) =>
                                                      element.orderId ==
                                                      orderCtroller
                                                          .allOrderList[index]
                                                          .orderId);
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Order date : ' +
                                                          orderCtroller
                                                              .allOrderList[
                                                                  index]
                                                              .orderDate
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      'Delivery date : ' +
                                                          orderCtroller
                                                              .allOrderList[
                                                                  index]
                                                              .dateOfDelivering
                                                              .toString()
                                                              .replaceAll(
                                                                  ':00.000',
                                                                  ''),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'orderprice : ' +
                                                          orderCtroller
                                                              .allOrderList[
                                                                  index]
                                                              .productPrice
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Text(
                                                      'delvreprice : ' +
                                                          orderCtroller
                                                              .allOrderList[
                                                                  index]
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
                                                          .allOrderList[index]
                                                          .totalPrice
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 250,
                                                  height: 250,
                                                  child: CachedNetworkImage(
                                                    imageUrl: orderCtroller
                                                        .allOrderList[index]
                                                        .productImage!,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            SizedBox(
                                                      height: 20.0,
                                                      width: 20.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress,
                                                        valueColor:
                                                            new AlwaysStoppedAnimation(
                                                                Color(
                                                                    0xFF812C2C)),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black),
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
                                                          color:
                                                              Colors.blueAccent,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                    'Delvr To ')
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
          ),
        ],
      ),
    );
  }
}
