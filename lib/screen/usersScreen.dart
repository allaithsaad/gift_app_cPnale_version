import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/controllers/orderController.dart';
import '/controllers/users_controller.dart';
import 'UserOrderScreen.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    final usersCtroller = Get.find<UsersController>();
    final phoneNumber = TextEditingController();
    final orderController = Get.find<OrderController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Screen'),
        centerTitle: true,
        actions: [
          Container(
            width: Get.width * 0.20,
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: phoneNumber,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    buildCounter: (BuildContext context,
                            {int? currentLength,
                            int? maxLength,
                            bool? isFocused}) =>
                        null,
                    maxLength: 9,
                    cursorColor: Colors.deepPurple,
                    style: TextStyle(color: Colors.deepPurple),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.deepPurple, width: 1.0),
                      ),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.deepPurple)),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      labelText: "Phone Number",
                    ),
                    onSubmitted: (c) {
                      if (phoneNumber.text.length == 9) {
                        usersCtroller.searchForUser(phoneNumber.text);
                      } else {
                        Get.snackbar("erroe", 'Phone number is not correct');
                      }
                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (phoneNumber.text.length == 9) {
                        usersCtroller.searchForUser(phoneNumber.text);
                      } else {
                        Get.snackbar("erroe", 'Phone number is not correct');
                      }
                    },
                    icon: Icon(Icons.search_outlined))
              ],
            ),
          )
        ],
      ),
      body: GetBuilder(
        init: Get.find<UsersController>(),
        builder: (controller) => usersCtroller.getUsersIsloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GetBuilder(
                    init: Get.find<UsersController>(),
                    builder: (controller) => usersCtroller.getUsersIsloading ==
                            true
                        ? Center(child: CircularProgressIndicator())
                        : usersCtroller.userList.isEmpty
                            ? Center(child: Text('no Users Date '))
                            : ListView.builder(
                                itemCount: usersCtroller.userList.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text('Phone Number :' +
                                            usersCtroller
                                                .userList[index].phoneNumber
                                                .toString()
                                                .replaceAll("+967", '')),
                                        subtitle: Row(
                                          children: [
                                            Text('name  : ' +
                                                usersCtroller
                                                    .userList[index].name
                                                    .toString()),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(
                                              'BirthDay : ' +
                                                  usersCtroller
                                                      .userList[index].birthDay
                                                      .toString()
                                                      .replaceAll(
                                                          '00:00:00.000', ' '),
                                            ),
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        selected: true,
                                        selectedTileColor: Colors.grey[300],
                                        leading: Icon(Icons.person),
                                        trailing: IconButton(
                                          icon: usersCtroller
                                                  .userList[index].verifiedUser!
                                              ? Icon(Icons.verified)
                                              : Icon(
                                                  Icons.do_disturb_alt_sharp),
                                          onPressed: () {},
                                        ),
                                        onTap: () {
                                          orderController.fatchUserOrders(
                                              usersCtroller
                                                  .userList[index].userId!);
                                          Get.to(
                                            UserOrdersScreen(
                                              "All Order of User :${usersCtroller.userList[index].name} ",
                                              usersCtroller.userList[index]
                                                  .verifiedUser!,
                                              usersCtroller
                                                  .userList[index].blacklist!,
                                              usersCtroller
                                                  .userList[index].userId!,
                                              usersCtroller
                                                  .userList[index].name!,
                                              usersCtroller
                                                  .userList[index].birthDay!,
                                              usersCtroller
                                                  .userList[index].gender!,
                                            ),
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
    );
  }
}
