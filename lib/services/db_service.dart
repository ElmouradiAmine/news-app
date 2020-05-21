import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static DBService instance = DBService();

  Firestore _db;

  DBService() {
    _db = Firestore.instance;
  }

  String _userCollection = 'Users';

  Future<void> createUserInDB(String _uid, String _name, String _email,
      String _imageURL, String _fourDigitPin, String _failSafeDigitPin) async {
    try {
      return await _db.collection(_userCollection).document(_uid).setData({
        'name': _name,
        'email': _email,
        'image': _imageURL,
        'lastSeen': DateTime.now().toUtc(),
        'fourDigitPin': _fourDigitPin,
        'failSafeDigitPin': _failSafeDigitPin,
      });
    } catch (e) {
      print(e);
    }
  }
}
