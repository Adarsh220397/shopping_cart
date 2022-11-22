import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../utils/progress_view.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  late ThemeData themeData;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Payment Status'),
          backgroundColor: const Color.fromARGB(255, 1, 16, 39),
        ),
        //  key: _scaffoldKey,
        body: SafeArea(
          child: KeyboardDismissOnTap(
            child: ProgressWidget(
                isShow: isLoading,
                color: Colors.black,
                opacity: 1,
                child: successCard()),
          ),
        ));
  }

  Widget successCard() {
    return Center(
      child: Card(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Successfully Purchased !!',
                  style: themeData.textTheme.titleLarge!
                      .copyWith(color: Colors.black),
                ),
                Text(
                  'Thank You!',
                  style: themeData.textTheme.titleMedium!
                      .copyWith(color: Colors.black),
                )
              ],
            )),
      ),
    );
  }
}
