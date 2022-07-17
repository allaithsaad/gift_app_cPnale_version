import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/screen/OffersScreen.dart';

import 'category_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SERVICES SCREEN '),
          centerTitle: true,
        ),
        body: Row(
          children: [
            Custome_service('Offers', () {
              Get.to(() => OffersSCcreen());
            }),
            Custome_service('Category', () {
              Get.to(() => CategoryScreen());
            }),
          ],
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class Custome_service extends StatelessWidget {
  final String? name;
  final Function()? function;

  Custome_service(this.name, this.function);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 5,
                color: Colors.white54,
              )),
          height: 200,
          width: 200,
          child: Center(
              child: Text(
            name!,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          )),
        ),
      ),
    );
  }
}
