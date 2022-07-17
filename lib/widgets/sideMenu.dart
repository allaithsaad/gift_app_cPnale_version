import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/CategoryController.dart';
import '/controllers/OffersController.dart';
import '/controllers/admin_controller.dart';
import '/controllers/orderController.dart';
import '/controllers/stroesController.dart';
import '/controllers/users_controller.dart';
import '/screen/OffersScreen.dart';
import '/screen/UnverifiedProductsScreen.dart';
import '/screen/allOrderScreen.dart';
import '/screen/login.dart';
import '/screen/services_screen.dart';
import '/screen/storesScreen.dart';
import '/screen/usersScreen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userf = Get.find<UsersController>();
    final adminController = Get.find<AdminController>();

    final orderController = Get.find<OrderController>();
    final categoryController = Get.find<CategoryController>();
    final storeController = Get.find<StoresController>();
    final offersController = Get.find<OffersController>();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Icon(Icons.card_giftcard),
          ),
          DrawerListTile(
            title: "Order",
            icon: Icons.shopping_bag_outlined,
            press: () {
              Get.to(AllOrdersScreen("All Order"));
              orderController.fatchAllOrder();
            },
          ),
          DrawerListTile(
            title: "Store",
            icon: Icons.store_mall_directory_outlined,
            press: () {
              Get.to(StoresScreen());
              storeController.getStores();
            },
          ),
          DrawerListTile(
            title: "Services",
            icon: Icons.cancel_presentation,
            press: () {
              Get.to(ServicesScreen());
              offersController.getOffers();
              categoryController.getCategory();
            },
          ),
          DrawerListTile(
            title: "UnVerfiy Products",
            icon: Icons.do_not_disturb_on_total_silence,
            press: () {
              Get.to(UnverifiedProductsScreen());
              storeController.getUnVerifyProducts();
            },
            trailing: Card(
              child: Obx(
                () => Badge(
                  padding: EdgeInsets.all(1),
                  toAnimate: true,
                  shape: BadgeShape.square,
                  badgeColor: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      bottomLeft: Radius.circular(0),
                      topRight: Radius.circular(10)),
                  badgeContent: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      storeController.unVerifyProductsNumber.value.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          DrawerListTile(
            title: "User",
            icon: Icons.verified_user_sharp,
            press: () {
              Get.to(UsersScreen());
              userf.getUsers();
            },
          ),
          DrawerListTile(
            title: "Acounting",
            icon: Icons.monetization_on_sharp,
            press: () {},
          ),
          DrawerListTile(
            title: "delivery  Boy",
            icon: Icons.delivery_dining_rounded,
            press: () {},
          ),
          DrawerListTile(
            title: "   Exit    ",
            icon: Icons.exit_to_app_sharp,
            press: () async {
              await FirebaseAuth.instance.signOut();
              adminController.deleteSPAdmin();
              Get.offAll(LogInScreen());
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.icon,
      required this.press,
      this.trailing})
      : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(icon),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.white54, fontSize: 14),
      ),
      trailing: trailing,
    );
  }
}
