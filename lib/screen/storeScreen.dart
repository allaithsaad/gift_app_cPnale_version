import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/stroesController.dart';
import '/widgets/like_botton.dart';

class StoreScreen extends StatefulWidget {
  final String? image;
  final String? name;
  final String? id;

  const StoreScreen({Key? key, this.image, this.name, this.id})
      : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final nameNotification = TextEditingController();
  final StoresController storesController = Get.find();

  final notficationList = ["Reminder", "Notfication", "Alarm"];
  @override
  void initState() {
    storesController.getStoreProduct(widget.id!);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    nameNotification.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<StoresController>(
          builder: (controller) => Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.notification_add),
                      tooltip: 'إرسال إشعار ',
                      onPressed: () {
                        Get.defaultDialog(
                            title: 'Send notification to ( ${widget.name} )',
                            barrierDismissible: false,
                            content: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                width: Get.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(" Type "),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(16),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.black, width: 4),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Obx(
                                          () => DropdownButton<String>(
                                              isExpanded: true,
                                              icon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
                                              value: storesController
                                                  .notificationType.value,
                                              items: notficationList
                                                  .map(buildManuItem)
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  storesController
                                                      .notificationType
                                                      .value = value!;
                                                });
                                              }),
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      controller: nameNotification,
                                      maxLines: 2,
                                      buildCounter: (BuildContext context,
                                              {int? currentLength,
                                              int? maxLength,
                                              bool? isFocused}) =>
                                          null,
                                      maxLength: 150,
                                      cursorColor: Colors.deepPurple,
                                      style:
                                          TextStyle(color: Colors.deepPurple),
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple,
                                              width: 1.0),
                                        ),
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.deepPurple)),
                                        prefixIcon: const Icon(
                                          Icons.text_format_sharp,
                                          color: Colors.deepPurple,
                                        ),
                                        labelText: " Message ",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Card(
                                          color: Colors.white60,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: TextButton(
                                                onPressed: () {
                                                  if (nameNotification
                                                          .text.length >
                                                      10) {
                                                    try {
                                                      DocumentReference docRef =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Store")
                                                              .doc(widget.id)
                                                              .collection(
                                                                  "Notification")
                                                              .doc();
                                                      docRef.set({
                                                        "notificationId":
                                                            docRef.id,
                                                        "name": storesController
                                                            .notificationType
                                                            .value,
                                                        "body": nameNotification
                                                            .text,
                                                        "date": DateTime.now(),
                                                        "senderId": FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid
                                                      }).then((value) {
                                                        Get.back();
                                                        Get.snackbar("title",
                                                            "message send ");
                                                      });
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  } else {
                                                    Get.snackbar("error",
                                                        "message must be longer then 10 letter ");
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.send),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(" send "),
                                                  ],
                                                )),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Card(
                                          color: Colors.white12,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: TextButton(
                                                onPressed: () => Get.back(),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.cancel),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(" Cancel "),
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  ],
                  collapsedHeight: 60.0,
                  centerTitle: true,
                  shadowColor: Colors.black,
                  backgroundColor: Colors.purple[500],
                  floating: false,
                  pinned: true,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        widget.name!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      background: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.png',
                        image: widget.image!,
                        fit: BoxFit.cover,
                      )),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  delegate:
                      SliverChildBuilderDelegate((BuildContext context, int i) {
                    return new GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                  child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.network(
                                    StoresController
                                        .storeProductsModel[i].image![0],
                                    fit: BoxFit.cover),
                              )),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Badge(
                                  toAnimate: true,
                                  shape: BadgeShape.square,
                                  badgeColor: Colors.deepPurple,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(0),
                                      topLeft: Radius.circular(5)),
                                  badgeContent: Text(
                                      StoresController
                                              .storeProductsModel[i].price
                                              .toString() +
                                          'Ry',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Badge(
                                    padding: EdgeInsets.all(1),
                                    toAnimate: true,
                                    shape: BadgeShape.square,
                                    badgeColor: Colors.deepPurple,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(0),
                                        topRight: Radius.circular(10)),
                                    badgeContent: LikeBotton(StoresController
                                        .storeProductsModel[i].favorite!)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {},
                    );
                  }, childCount: StoresController.storeProductsModel.length),
                )
              ],
            ),
          ),
        ),
      );

  DropdownMenuItem<String> buildManuItem(String notficationList) =>
      DropdownMenuItem<String>(
        value: notficationList,
        child: Text(
          notficationList,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      );
}
