import 'package:FlAuth/model/address_model.dart';
import 'package:FlAuth/model/password_model.dart';
import 'package:FlAuth/model/totp_model.dart';
import 'package:FlAuth/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//adb forward tcp:8090 tcp:8090
//flutter pub run build_runner build


class ObjectBox {

  late final Store store;
  late final Box<TotpModel> totpModelBox;
  late final Box<PasswordModel> passwordModelBox;
  late final Box<AddressModel> addressModelBox;

  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    totpModelBox = store.box<TotpModel>();
    passwordModelBox = store.box<PasswordModel>();
    addressModelBox  = store.box<AddressModel>();

  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "flauth"));
    return ObjectBox._create(store);
  }

}