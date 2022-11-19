import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_app/src/services/model/user_details.dart';

class LocationService {
  LocationService._internal();
  static LocationService instance = LocationService._internal();

  Future<List<UserDetailsModel>> getCategoryDetails() async {
    List<UserDetailsModel> categoryList = [];
    //   try {
    var resp = await http.get(Uri.parse(
      'http://139.59.22.213:3005/api/product',
    ));

    if (resp.statusCode == 200) {
      var jsonResponse = json.decode(resp.body);
      List responseList = jsonResponse['data']['results'];

      for (var response in responseList) {
        if (response['status'] == '0') {
          response['status'] = false;
        } else {
          response['status'] = true;
        }
        categoryList.add(UserDetailsModel.fromJson(response));
      }

      for (UserDetailsModel user in categoryList) {
        print(user.status);
        print(user.price);
      }
    } else {
      Exception('No document found');
    }
    return categoryList;
  }
}
