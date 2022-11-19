import 'package:path/path.dart';
import 'package:shopping_app/src/services/model/user_details.dart';
import 'package:sqflite/sqflite.dart';

class TransactionDetailDataBase {
  static final TransactionDetailDataBase instance =
      TransactionDetailDataBase._init();

  static Database? _database;

  TransactionDetailDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactionDetails.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${TableDetails.id} $idType, 
  ${TableDetails.price} $integerType,
  ${TableDetails.createdAt} $textType,
  ${TableDetails.image} $textType,
  ${TableDetails.name} $textType,
  ${TableDetails.product} $textType,
  ${TableDetails.remark} $textType,
  ${TableDetails.title} $textType
  )
''');
  }

  Future<UserDetailsModel> create(UserDetailsModel note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<List<UserDetailsModel>> readAllDocuments() async {
    final db = await instance.database;

    //const orderBy = '${UserDetailsModel.time} ASC';

    final result = await db.query(
      tableNotes,
    );

    return result.map((json) => UserDetailsModel.fromJson(json)).toList();
  }
}
