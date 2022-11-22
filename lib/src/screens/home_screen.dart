import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shopping_app/src/screens/categories_screen.dart';
import 'package:shopping_app/src/screens/mobile_number_screen.dart';
import 'package:shopping_app/src/services/auth/auth.dart';
import 'package:shopping_app/src/services/model/user_details.dart';
import 'package:shopping_app/src/utils/app_constants.dart';
import 'package:shopping_app/src/utils/progress_view.dart';

import '../utils/circle_shaped_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Common Variables
  late ThemeData themeData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  String? date;

  List<UserDetailsModel> details = [];

  @override
  void initState() {
    super.initState();
  }

  void setLoadingState(bool status) {
    if (mounted) {
      setState(() {
        isLoading = status;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
          child: KeyboardDismissOnTap(
            child: ProgressWidget(
                isShow: isLoading,
                color: Colors.black,
                opacity: 1,
                child: homeScreenBodyUI()),
          ),
        ));
  }

  Widget homeScreenBodyUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 10,
          right: 15,
          child: InkWell(
              child: const Text(
                'Logout',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
              onTap: () {
                AuthService.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MobileNumberScreen()));
              }),
        ),
        Positioned(
          top: 0,
          right: 50,
          child: CustomPaint(
            painter: OpenPainter(),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: homeScreenBody()),
        Positioned(
          top: MediaQuery.of(context).size.height / 12,
          left: MediaQuery.of(context).size.width / 3.2,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: const Text(
              'CATEGORIES',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget categories(String text) {
    return Card(
      child: Container(
          color: const Color.fromARGB(255, 1, 16, 39),
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Center(
            child: Text(
              text,
              style:
                  themeData.textTheme.headline5!.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }

  Widget homeScreenBody() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 10),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(children: [
                    InkWell(
                      onTap: navigateToLoginDetails,
                      child: categories('Electronics'),
                    ),
                    InkWell(
                      onTap: navigateToLoginDetails,
                      child: categories('Sports'),
                    ),
                    InkWell(
                      onTap: navigateToLoginDetails,
                      child: categories('Fashion'),
                    ),
                    InkWell(
                      onTap: navigateToLoginDetails,
                      child: categories('Grocery'),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  navigateToLoginDetails() async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LoginDetails()),
    );
  }
}
