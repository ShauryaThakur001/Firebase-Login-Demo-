  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebaselogindemo/Models/product_model.dart';

  class Productdatabase {
    final FirebaseFirestore _firebase = FirebaseFirestore.instance;

    Future<void>createProduct(String collName,String docId,ProductModel product)async{
      try {
        await _firebase.collection(collName).doc(docId).set({
        ...product.toJson(),
        'createdAt' : FieldValue.serverTimestamp(),
      });
      print("Product Created");
      } catch (e) {
        print("Error $e");
      }
    }

    Future<void>updateProduct(String collName,String docId,Map<String,dynamic>data)async{
      try {
        await _firebase.collection(collName).doc(docId).update(data);
        print("Product Updated");
      } catch (e) {
        print("Error : $e");
      }
    }

    Future<void>deleteProduct(String collId,String docId)async{
      try {
        await _firebase.collection(collId).doc(docId).delete();
      } catch (e) {
        print("Error : $e");
      }
    }
  }
