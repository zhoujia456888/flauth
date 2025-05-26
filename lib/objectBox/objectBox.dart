import 'package:FlAuth/model/totp_model/totp_model.dart';
import 'package:FlAuth/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../main.dart';

class ObjectBox {

  late final Store store;
  late final Box<TotpModel> totpModelBox;



  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    totpModelBox = store.box<TotpModel>();

  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "flauth"));
    return ObjectBox._create(store);
  }

}