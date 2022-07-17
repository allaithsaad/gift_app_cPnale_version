import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/controllers/OffersController.dart';

class OffersSCcreen extends StatefulWidget {
  const OffersSCcreen({Key? key}) : super(key: key);

  @override
  _OffersSCcreenState createState() => _OffersSCcreenState();
}

class _OffersSCcreenState extends State<OffersSCcreen> {
  UploadTask? task;
  File? file;
  String? url;

  @override
  Widget build(BuildContext context) {
    final offersController = Get.find<OffersController>();
    final offerName = TextEditingController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<OffersController>(
        builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text('Offers Screen'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Add Offer Dialog",
                    barrierDismissible: false,
                    content: Column(
                      children: [
                        TextField(
                          controller: offerName,
                          buildCounter: (BuildContext context,
                                  {int? currentLength,
                                  int? maxLength,
                                  bool? isFocused}) =>
                              null,
                          maxLength: 20,
                          cursorColor: Colors.deepPurple,
                          style: TextStyle(color: Colors.deepPurple),
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.deepPurple, width: 1.0),
                            ),
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.deepPurple)),
                            prefixIcon: const Icon(
                              Icons.text_format_sharp,
                              color: Colors.deepPurple,
                            ),
                            labelText: "Name ",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          text: 'Select File',
                          icon: Icons.attach_file,
                          onClicked: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();

                            if (result != null) {
                              offersController.upLoadingOffer.value = true;
                              Uint8List? fileBytes = result.files.first.bytes;
                              String fileName = result.files.first.name;

                              // Upload file
                              if (fileName.endsWith('.png') ||
                                  fileName.endsWith('.jpg') ||
                                  fileName.endsWith('.jpeg') ||
                                  fileName.endsWith('.gif') ||
                                  fileName.endsWith('.tif') ||
                                  fileName.endsWith('.tiff')) {
                                await FirebaseStorage.instance
                                    .ref('Offers/$fileName')
                                    .putData(fileBytes!)
                                    .then((value) async {
                                  await value.ref
                                      .getDownloadURL()
                                      .then((value) {
                                    setState(() {
                                      url = value;
                                      if (url != null) {
                                        print(url);
                                        offersController.upLoadingOffer.value =
                                            false;
                                        Get.snackbar("title", "Done");
                                      } else {
                                        offersController.upLoadingOffer.value =
                                            false;
                                        Get.snackbar("title", "Error");
                                      }
                                    });
                                  }).catchError((onError) {
                                    offersController.upLoadingOffer.value =
                                        false;
                                    Get.snackbar("error", onError.toString());
                                  });
                                }).catchError((onError) {
                                  offersController.upLoadingOffer.value = false;
                                  Get.snackbar("error", onError.toString());
                                });
                              } else {
                                offersController.upLoadingOffer.value = false;
                                Get.snackbar("error", 'this is not Image ');
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => offersController.upLoadingOffer.value ==
                                        true
                                    ? SpinKitHourGlass(
                                        color: Colors.red,
                                        size: 50.0,
                                      )
                                    : TextButton(
                                        onPressed: () async {
                                          if (url != null &&
                                              url!.isNotEmpty &&
                                              offerName.text.length > 5) {
                                            DocumentReference docRef =
                                                FirebaseFirestore.instance
                                                    .collection("slideshow")
                                                    .doc();

                                            docRef.set({
                                              'imageUrl': url,
                                              'name': offerName.text,
                                              'offerId': docRef.id
                                            }).then((value) {
                                              Get.back();
                                              Get.snackbar("title", "Done");
                                              offersController.getOffers();
                                            }).catchError((onError) {
                                              Get.snackbar(
                                                  "tittle", onError.toString());
                                            });
                                          } else {
                                            Get.snackbar("title",
                                                "Add Image frist And name");
                                          }
                                        },
                                        child: Text('Add Offer to Users ')),
                              ),
                            ))
                      ],
                    ),
                  );
                },
                icon: Icon(Icons.add_box_rounded),
                color: Colors.white24,
              )
            ],
          ),
          body: Obx(
            () => offersController.isLoadingOffers.value == true
                ? SpinKitHourGlass(
                    color: Colors.red,
                    size: 50.0,
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int i) {
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
                                          OffersController
                                              .offersList[i].imageUrl!,
                                          fit: BoxFit.cover),
                                    )),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        color: Colors.red,
                                        icon: Icon(Icons.delete_forever),
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: 'Alaert ',
                                              content: Text(
                                                  'Do u Want to  Delete this Offer '),
                                              onConfirm: () {
                                                FirebaseFirestore.instance
                                                    .collection('slideshow')
                                                    .doc(OffersController
                                                        .offersList[i].offerId)
                                                    .delete()
                                                    .then((value) {
                                                  offersController.getOffers();
                                                  Get.back();
                                                });
                                              },
                                              textConfirm: 'Ok',
                                              textCancel: 'no');
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(OffersController
                                              .offersList[i].name!),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {},
                          );
                        }, childCount: OffersController.offersList.length),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color.fromRGBO(29, 194, 95, 1),
          minimumSize: Size.fromHeight(50),
        ),
        child: buildContent(),
        onPressed: onClicked,
      );

  Widget buildContent() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ],
      );
}
