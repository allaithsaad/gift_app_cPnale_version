import 'dart:developer';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '/controllers/CategoryController.dart';
import '/controllers/OffersController.dart';
import '/models/category_model.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryController = Get.find<CategoryController>();
  final ImagePicker _picker = ImagePicker();
  var imageFileExist = false.obs;
  Uint8List? fileBytes;
  String? fileName;
  String? imageUrl1;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.find<CategoryController>();
    final categoryName = TextEditingController();
    final categoryId = TextEditingController();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GetBuilder<OffersController>(
        builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text('Category Screen'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Add Category Dialog",
                    barrierDismissible: false,
                    content: Column(
                      children: [
                        TextField(
                          controller: categoryName,
                          // buildCounter: (BuildContext context,
                          //         {int? currentLength,
                          //         int? maxLength,
                          //         bool? isFocused}) =>
                          //     null,
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
                        TextField(
                          controller: categoryId,
                          // buildCounter: (BuildContext context,
                          //         {int? currentLength,
                          //         int? maxLength,
                          //         bool? isFocused}) =>
                          //     null,
                          maxLength: 3,
                          //        inputFormatters: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: Colors.deepPurple,
                          keyboardType: TextInputType.number,
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
                            labelText: "ترتيب المناسبة ",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () => _selectPhoto1(),
                          child: Card(
                            child: SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                  ),
                                  Obx(
                                    () => Text(
                                      imageFileExist.value == false
                                          ? 'اضغط لاضافه صوره من الأمام'
                                          : 'اضغط لاتعديل صوره المنتج',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
                                () => categoryController
                                            .upLoadingCategory.value ==
                                        true
                                    ? SpinKitThreeInOut(
                                        color: Colors.red,
                                        size: 50.0,
                                      )
                                    : TextButton(
                                        onPressed: () async {
                                          if (fileName == null) {
                                            Get.snackbar('Error ',
                                                "You must Select Image first");
                                          } else {
                                            if (categoryName.text.length < 3) {
                                              Get.snackbar('Error ',
                                                  "The name must be greater than 3 letters");
                                            } else {
                                              if (categoryId.text.length == 0) {
                                                Get.snackbar('Error ',
                                                    "You must Enter  The Category ID ");
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection('Category')
                                                    .where('categoryId',
                                                        isEqualTo: int.parse(
                                                            categoryId.text))
                                                    .get()
                                                    .then((value) async {
                                                  if (value.docs.isNotEmpty) {
                                                    Get.snackbar('Error ',
                                                        "There is category with these Id  ");
                                                  } else {
                                                    categoryController
                                                        .upLoadingCategory
                                                        .value = true;
                                                    // uploadImage( File(imageFile1!.path))
                                                    await _uploadFile1()
                                                        .then((value) {
                                                      if (imageUrl1 != null) {
                                                        DocumentReference
                                                            docRef =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Category")
                                                                .doc();

                                                        docRef
                                                            .set(CategoryModel(
                                                                    categoryId: int.parse(
                                                                        categoryId
                                                                            .text),
                                                                    name: categoryName
                                                                        .text,
                                                                    fcategoryId:
                                                                        docRef
                                                                            .id,
                                                                    imageUrl:
                                                                        imageUrl1,
                                                                    categoryStatues:
                                                                        false)
                                                                .toJson())
                                                            .then((value) {
                                                          categoryController
                                                              .upLoadingCategory
                                                              .value = false;
                                                          categoryController
                                                              .upLoadingCategory
                                                              .value = false;
                                                          Navigator.pop(
                                                              context);
                                                          categoryController
                                                              .getCategory();
                                                        }).catchError(
                                                                (onError) {
                                                          categoryController
                                                              .upLoadingCategory
                                                              .value = false;

                                                          setState(() {
                                                            fileName = null;
                                                          });

                                                          Get.snackbar(
                                                              "tittle",
                                                              onError
                                                                  .toString());
                                                        });
                                                        categoryController
                                                            .upLoadingCategory
                                                            .value = false;
                                                      }
                                                    });
                                                  }
                                                });
                                              }
                                            }
                                          }
                                        },
                                        child:
                                            Text('Add Category to The Store ')),
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
            () => categoryController.isLoadingCategory.value == true
                ? SpinKitHourGlass(
                    color: Colors.red,
                    size: 50.0,
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
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
                                          CategoryController
                                              .categorylist[i].imageUrl!,
                                          fit: BoxFit.cover),
                                    )),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        color: Colors.red,
                                        icon: CategoryController.categorylist[i]
                                                .categoryStatues!
                                            ? Icon(Icons.hide_image_rounded)
                                            : Icon(Icons.show_chart_rounded),
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: 'Alaert ',
                                              content: CategoryController
                                                      .categorylist[i]
                                                      .categoryStatues!
                                                  ? Text(
                                                      'Do u Want to  hide this Category ')
                                                  : Text(
                                                      'Do u Want to  show this Category '),
                                              onConfirm: () {
                                                FirebaseFirestore.instance
                                                    .collection('Category')
                                                    .doc(CategoryController
                                                        .categorylist[i]
                                                        .fcategoryId)
                                                    .update({
                                                  'categoryStatues':
                                                      CategoryController
                                                                  .categorylist[
                                                                      i]
                                                                  .categoryStatues ==
                                                              true
                                                          ? false
                                                          : true
                                                }).then((value) {
                                                  Get.back();
                                                  categoryController
                                                      .getCategory();
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
                                          child: Text(CategoryController
                                              .categorylist[i].name!),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(CategoryController
                                              .categorylist[i].categoryId
                                              .toString()),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {},
                          );
                        }, childCount: CategoryController.categorylist.length),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future _selectPhoto1() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        imageFileExist.value = true;
        fileBytes = result.files.first.bytes;
        fileName = result.files.first.name;
      });
    }
  }

  Future _uploadFile1() async {
    if (fileName!.endsWith('.png') ||
        fileName!.endsWith('.jpg') ||
        fileName!.endsWith('.jpeg') ||
        fileName!.endsWith('.gif') ||
        fileName!.endsWith('.tif') ||
        fileName!.endsWith('.tiff')) {
      await FirebaseStorage.instance
          .ref('Category/$fileName')
          .putData(fileBytes!)
          .then((value) async {
        await value.ref.getDownloadURL().then((value) {
          setState(() {
            imageUrl1 = value;
            if (imageUrl1 != null) {
              print(imageUrl1);
              categoryController.upLoadingCategory.value = false;
              log('DOne');
            } else {
              categoryController.upLoadingCategory.value = false;
              Get.snackbar("title", "Error");
            }
          });
        }).catchError((onError) {
          categoryController.upLoadingCategory.value = false;
          Get.snackbar("error", onError.toString());
        });
      }).catchError((onError) {
        categoryController.upLoadingCategory.value = false;
        Get.snackbar("error", onError.toString());
      });
    } else {
      categoryController.upLoadingCategory.value = false;
      Get.snackbar("error", 'this is not Image ');
    }
    // final ref = storage.FirebaseStorage.instance
    //     .ref()
    //     .child('Category')
    //     .child('${DateTime.now().toIso8601String()}');

    // final result = await ref.putFile(File(path));
    // final fileUrl = await result.ref.getDownloadURL();

    // setState(() {
    //   imageUrl1 = fileUrl;
    // });
  }

  Future<String> uploadImage(PlatformFile file) async {
    try {
      TaskSnapshot upload = await FirebaseStorage.instance
          .ref(
              'events/${file.path}-${DateTime.now().toIso8601String()}.${file.extension}')
          .putData(
            file.bytes!,
            SettableMetadata(contentType: 'image/${file.extension}'),
          );

      String url = await upload.ref.getDownloadURL();
      return url;
    } catch (e) {
      print('error in uploading image for : ${e.toString()}');
      return '';
    }
  }
}
