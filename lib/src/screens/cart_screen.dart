import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shopping_app/src/screens/login_details_screen.dart';
import 'package:shopping_app/src/screens/success_screen.dart';
import 'package:shopping_app/src/services/database/database.dart';
import 'package:shopping_app/src/services/model/user_details.dart';
import 'package:shopping_app/src/utils/button_widget.dart';
import 'package:shopping_app/src/utils/progress_view.dart';

class CartScreen extends StatefulWidget {
  List<UserDetailsModel>? selectedList;
  CartScreen({super.key, this.selectedList});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ThemeData themeData;
  bool isLoading = false;
  List<UserDetailsModel> selectedList = [];
  num total = 0;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    selectedList = widget.selectedList!;

    for (int i = 0; i < selectedList.length; i++) {
      total += selectedList[i].price;
    }

    isLoading = false;
    fetchData();
    setState(() {});
  }

  fetchData() async {
    List<UserDetailsModel> list = [];
    list = await DataBase.instance.getData();

    for (UserDetailsModel i in list) {
      print(i.id);
      print(i.price);
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          backgroundColor: const Color.fromARGB(255, 1, 16, 39),
        ),
        //  key: _scaffoldKey,
        body: SafeArea(
          child: KeyboardDismissOnTap(
            child: ProgressWidget(
                isShow: isLoading,
                color: Colors.black,
                opacity: 1,
                child: cartDetails()),
          ),
        ));
  }

  Widget cartDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (UserDetailsModel user in selectedList)
            Column(
              children: [
                itemCard(user),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
          const SizedBox(
            height: 30,
          ),
          Text('Total : ${'\u{20B9}'} $total',
              style: themeData.textTheme.titleLarge!
                  .copyWith(color: Colors.white)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              text: 'CHECKOUT',
              onClicked: navigateToSucessPage,
              bFullContainerButton: true,
            ),
          ),
          //  ButtonWidget(text: 'CheckOut', onClicked: navigateToSucessPage)
        ],
      ),
    );
  }

  navigateToSucessPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()));
  }

  itemCard(UserDetailsModel user) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 4.5,
        color: user.status ? Colors.white : Colors.black,
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(flex: 1, child: image(user)),
              Expanded(
                flex: 3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: themeData.textTheme.headline6!.copyWith(
                            color: user.status ? Colors.black : Colors.white),
                      ),
                      Text(
                        user.title,
                        style: themeData.textTheme.headline6!.copyWith(
                            color: user.status ? Colors.black : Colors.white),
                      ),
                      Text(
                        user.product,
                        style: themeData.textTheme.subtitle1!.copyWith(
                            color: user.status ? Colors.black : Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        user.remark,
                        style: themeData.textTheme.subtitle1!.copyWith(
                            color: user.status ? Colors.black : Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        user.price.toString(),
                        style: themeData.textTheme.headline6!.copyWith(
                            color: user.status ? Colors.black : Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      //  iconButton(user)
                    ]),
              ),
            ],
          ),
        ));
  }

  Widget image(UserDetailsModel user) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.network('http://139.59.22.213:3005/${user.image}',
          width: MediaQuery.of(context).size.width),
    );
  }
}
