import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shopping_app/src/screens/cart_screen.dart';
import 'package:shopping_app/src/services/database/database.dart';
import 'package:shopping_app/src/services/location/location.dart';
import 'package:shopping_app/src/services/model/user_details.dart';
import 'package:shopping_app/src/utils/progress_view.dart';
import 'package:badges/badges.dart';
import 'package:sqflite/sqflite.dart';

class LoginDetails extends StatefulWidget {
  const LoginDetails({super.key});

  @override
  State<LoginDetails> createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  late ThemeData themeData;
  bool isLoading = false;
  List<UserDetailsModel> list = [];
  // List<UserModel> todayLoginList = [];
  // List<UserModel> yesterdayLoggedList = [];
  // List<UserModel> otherList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<UserDetailsModel> selectedList = [];
  List<UserDetailsModel> notSelectedList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    list = await LocationService.instance.getCategoryDetails();

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Categories'),
          backgroundColor: const Color.fromARGB(255, 1, 16, 39),
          actions: [
            _shoppingCartBadge(),
            // IconButton(
            //   icon: const Icon(
            //     Icons.shopping_cart,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => CartScreen(
            //                   selectedList: selectedList,
            //                 )));
            //   },
            // )
          ],
        ),
        //  key: _scaffoldKey,
        body: SafeArea(
          child: KeyboardDismissOnTap(
            child: ProgressWidget(
                isShow: isLoading,
                color: Colors.black,
                opacity: 1,
                child: categoryDetails()),
          ),
        ));
  }

  Widget _shoppingCartBadge() {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: Duration(milliseconds: 300),
      animationType: BadgeAnimationType.slide,
      badgeContent: Text(
        selectedList.length.toString(),
        style: TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () async {
            await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CartScreen(
                          selectedList: selectedList,
                        )));

            bool bUpdate = await DataBase.instance.insertData(selectedList);
          }),
    );
  }

  Widget categoryDetails() {
    return isLoading
        ? const CircularProgressIndicator()
        : SingleChildScrollView(
            child: Column(
              children: [
                category('Electronics'),
                detailsCardRow(0, 2),
                SizedBox(
                  height: 5,
                ),
                category('Sports'),
                detailsCardRow(2, 4),
                SizedBox(
                  height: 5,
                ),
                category('Fashion'),
                detailsCardRow(4, 6),
                SizedBox(
                  height: 5,
                ),
                category('Grocery'),
                detailsCardRow(6, 8),
              ],
            ),
          );
  }

  Widget detailsCardRow(int start, int end) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (UserDetailsModel user in list.getRange(start, end))
          FilterChip(
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: user.status ? Colors.black : Colors.white, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            label: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 3,
                color: user.status ? Colors.black : Colors.white,
                child: Card(
                  color: user.status ? Colors.black : Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          image(user),
                          Text(
                            user.name,
                            style: themeData.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    user.status ? Colors.white : Colors.black),
                          ),
                          Text(
                            user.title,
                            style: themeData.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    user.status ? Colors.white : Colors.black),
                          ),
                          Text(
                            user.product,
                            style: themeData.textTheme.subtitle1!.copyWith(
                                color:
                                    user.status ? Colors.white : Colors.black),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            user.remark,
                            style: themeData.textTheme.subtitle1!.copyWith(
                                color:
                                    user.status ? Colors.white : Colors.black),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            user.price.toString(),
                            style: themeData.textTheme.headline6!.copyWith(
                                color:
                                    user.status ? Colors.white : Colors.black),
                            textAlign: TextAlign.left,
                          ),
                          Icon(
                            Icons.add,
                            color: user.status ? Colors.white : Colors.black,
                          ),
                        ]),
                  ),
                )),
            selected: user.status,
            onSelected: (isItemSelected) {
              user.status = isItemSelected;
              print(isItemSelected);
              if (user.status) {
                selectedList.add(user);
              } else {
                selectedList.remove(user);
              }

              setState(() {});
            },
          ),
      ],
    );
  }

  // Widget iconButton(UserDetailsModel user) {
  //   return IconButton(
  //       icon: Icon(
  //         Icons.add,
  //         color: user.status ? Colors.white : Colors.black,
  //       ),
  //       onPressed: () {} //() => onPress(user),
  //       );
  // }

  // onPress(UserDetailsModel user) async {
  //   bool bPress = false;
  //   if (bPress) {
  //     user.status = '0';
  //     bPress = false;
  //   } else {
  //     user.status = '1';
  //     bPress = true;

  //     selectedList.add(user);
  //   }

  //   print(user.status);

  //   setState(() {});
  // }

  Widget image(UserDetailsModel user) {
    // var image = decodeImage(File(user.image).readAsBytesSync())!;

    // File('thumbnail.jpg').writeAsBytesSync(encodeJpg(image));

    //  ByteData bytes = await rootBundle.load(user.image);

    return Image.network('http://139.59.22.213:3005/${user.image}',
        height: 50, width: MediaQuery.of(context).size.width / 2);
  }

  Widget category(String text) {
    return Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: 30,
        child: Center(
          child: Text(
            text,
            style: themeData.textTheme.subtitle1!.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }

  int calculateDifferenceBtwDates(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }
}
