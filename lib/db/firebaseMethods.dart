import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseMethods{
  Firestore _firestore = Firestore.instance;
  String ref = 'product';
  String productImage ;
  String productDesc;
  String productPrice;
  String productCat;
  String productBrand;

  Future<List<DocumentSnapshot>> productTitle() =>
      _firestore.collection(ref).where('productTitle').getDocuments().then((snaps) {
        print(snaps.documents);
        return snaps.documents;
      });
  Future<List<DocumentSnapshot>> getSuggestions(String suggestions) =>
      _firestore
          .collection(ref)
          .where('title', isEqualTo: suggestions)
          .getDocuments()
          .then((snap) {
        return snap.documents;
      });
}

