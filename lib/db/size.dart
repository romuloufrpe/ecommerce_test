import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class SizeService {
  Firestore _firestore = Firestore.instance;
  String ref = 'product/productSize';

  Future<List<DocumentSnapshot>> getSizes() =>
      _firestore.collection(ref).getDocuments().then((snaps) {
        return snaps.documents;
      });
}
