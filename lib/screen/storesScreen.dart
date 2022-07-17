import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/stroesController.dart';
import '/screen/storeScreen.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stores  Screen'),
        centerTitle: true,
      ),
      body: GetBuilder<StoresController>(
          builder: (controller) => new GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: StoresController.storeModel.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                primary: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: CachedNetworkImage(
                                  imageUrl: StoresController
                                      .storeModel[i].shopBackground!,
                                  placeholder: (context, url) => SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
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
                                  badgeContent: Text(
                                      StoresController.storeModel[i].name!)),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Get.to(StoreScreen(
                          image: StoresController.storeModel[i].shopBackground!,
                          name: StoresController.storeModel[i].name!,
                          id: StoresController.storeModel[i].storeId,
                        ));
                      }),
                ),
              )),
    );
  }
}
