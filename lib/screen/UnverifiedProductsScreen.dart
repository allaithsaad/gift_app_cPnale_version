import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/controllers/stroesController.dart';
import '/widgets/like_botton.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UnverifiedProductsScreen extends StatefulWidget {
  const UnverifiedProductsScreen({Key? key}) : super(key: key);

  @override
  _UnverifiedProductsScreenState createState() =>
      _UnverifiedProductsScreenState();
}

class _UnverifiedProductsScreenState extends State<UnverifiedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final storesController = Get.find<StoresController>();
    final name = TextEditingController();
    final description = TextEditingController();
    final verified = TextEditingController();
    final _firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("UnVerified Products Screen"),
        centerTitle: true,
      ),
      body: Obx(
        () => storesController.changeUnverify.value == true
            ? Center(
                child: SpinKitPouringHourGlassRefined(
                color: Colors.red,
                size: 50,
              ))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GetBuilder<StoresController>(
                  builder: (controller) => storesController
                              .unVerifyProducts.length ==
                          0
                      ? Center(
                          child: Text('No New Products '),
                        )
                      : new GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: storesController.unVerifyProducts.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          primary: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                          ),
                          itemBuilder: (context, i) => Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: GestureDetector(
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Stack(
                                        children: [
                                          Center(
                                              child: SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: CachedNetworkImage(
                                                imageUrl:
                                                storesController
                                                    .unVerifyProducts[i]
                                                    .image![0],

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
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(5)),
                                              badgeContent: Text(
                                                  storesController
                                                          .unVerifyProducts[i]
                                                          .price
                                                          .toString() +
                                                      'Ry',
                                                  style: TextStyle(
                                                      color: Colors.white)),
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
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10)),
                                                badgeContent: LikeBotton(
                                                    storesController
                                                        .unVerifyProducts[i]
                                                        .favorite!)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () => {
                                          name.text = storesController
                                              .unVerifyProducts[i].name!,
                                          description.text = storesController
                                              .unVerifyProducts[i].description!,
                                          verified.text = storesController
                                                  .unVerifyProducts[i].verified!
                                              ? "0"
                                              : "1",

                                          Get.defaultDialog(
                                            title: storesController
                                                .unVerifyProducts[i].productId
                                                .toString(),
                                            content: SingleChildScrollView(
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller: name,
                                                      cursorColor:
                                                          Colors.deepPurple,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .deepPurple,
                                                                  width: 1.0),
                                                        ),
                                                        border: new OutlineInputBorder(
                                                            borderSide:
                                                                new BorderSide(
                                                                    color: Colors
                                                                        .deepPurple)),
                                                        prefixIcon: const Icon(
                                                          Icons
                                                              .text_snippet_rounded,
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        labelText:
                                                            "Producte Name",
                                                      ),
                                                    ),
                                                    Container(
                                                      width: Get.width * 0.6,
                                                      child: TextField(
                                                        maxLines: 5,
                                                        controller: description,
                                                        cursorColor:
                                                            Colors.deepPurple,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        decoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .deepPurple,
                                                                    width: 1.0),
                                                          ),
                                                          border: new OutlineInputBorder(
                                                              borderSide:
                                                                  new BorderSide(
                                                                      color: Colors
                                                                          .deepPurple)),
                                                          prefixIcon:
                                                              const Icon(
                                                            Icons
                                                                .text_snippet_rounded,
                                                            color: Colors
                                                                .deepPurple,
                                                          ),
                                                          labelText:
                                                              "Producte Discrption",
                                                        ),
                                                      ),
                                                    ),
                                                    // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                                                    Row(
                                                      children: [
                                                        Text('Verified  : '),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        ToggleSwitch(
                                                          initialLabelIndex:
                                                              int.parse(verified
                                                                  .text),
                                                          minWidth: 90.0,
                                                          cornerRadius: 20.0,
                                                          activeBgColors: [
                                                            [Colors.cyan],
                                                            [Colors.redAccent]
                                                          ],
                                                          activeFgColor:
                                                              Colors.white,
                                                          inactiveBgColor:
                                                              Colors.grey,
                                                          inactiveFgColor:
                                                              Colors.white,
                                                          totalSwitches: 2,
                                                          labels: ['YES', ''],
                                                          icons: [
                                                            null,
                                                            FontAwesomeIcons
                                                                .times
                                                          ],
                                                          onToggle: (index) {
                                                            print(
                                                                'switched to: $index');
                                                            verified.text =
                                                                index
                                                                    .toString();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onConfirm: () {
                                              Get.back();
                                              storesController
                                                  .changeUnverify.value = true;
                                              _firebaseFirestore
                                                  .collection('Product')
                                                  .where('productId',
                                                      isEqualTo:
                                                          storesController
                                                              .unVerifyProducts[
                                                                  i]
                                                              .productId)
                                                  .get()
                                                  .then((value) {
                                                _firebaseFirestore
                                                    .collection('Product')
                                                    .doc(value.docs.first.id)
                                                    .update({
                                                  'name': name.text,
                                                  'description':
                                                      description.text,
                                                  'verified':
                                                      verified.text == '0'
                                                          ? true
                                                          : false,
                                                }).then((value) => {
                                                          storesController
                                                              .changeUnverify
                                                              .value = false,
                                                          storesController
                                                              .getUnVerifyProducts(),
                                                          Get.snackbar(
                                                              "title", "Done ")
                                                        });
                                              }).catchError((onError) {
                                                storesController.changeUnverify
                                                    .value = false;
                                                Get.snackbar("title",
                                                    "Oreation Do't copelet $onError");
                                              });
                                            },
                                            textCancel: 'No',
                                          )

                                          // Get.to(
                                          //     () => ProductPage(
                                          //           storesController
                                          //               .unVerifyProducts[i].name,
                                          //           storesController
                                          //               .unVerifyProducts[i].image,
                                          //           storesController
                                          //               .unVerifyProducts[i].price,
                                          //           storesController
                                          //               .unVerifyProducts[i].productId,
                                          //           storesController
                                          //               .unVerifyProducts[i].description,
                                          //           storesController
                                          //               .unVerifyProducts[i].storeId,
                                          //         ),
                                          //     preventDuplicates: false),
                                        }),
                              )),
                ),
              ),
      ),
    );
  }
}
