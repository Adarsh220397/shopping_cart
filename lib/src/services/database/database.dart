import 'package:shopping_app/src/services/database/sqlite_db.dart';
import 'package:shopping_app/src/services/model/user_details.dart';

class DataBase {
  DataBase._internal();
  static DataBase instance = DataBase._internal();

  Future<bool> insertData(List<UserDetailsModel> selectedList) async {
    //  DateFormat dateFormat = DateFormat("dd-MM-yy hh:mm");
    List<UserDetailsModel> list = [];

    try {
      for (UserDetailsModel emp in list) {
        print(emp.toJson());
        UserDetailsModel i =
            await TransactionDetailDataBase.instance.create(emp);
      }
    } catch (e) {
      print('-------$e');
      return false;
    }
    return true;
  }

  Future<List<UserDetailsModel>> getData() async {
    List<UserDetailsModel> list = [];
    list = await TransactionDetailDataBase.instance.readAllDocuments();

    return list;
  }
}
