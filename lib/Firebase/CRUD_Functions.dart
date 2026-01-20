import 'package:cloud_firestore/cloud_firestore.dart';

create(String collName, docName, name, animal, int age) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).set({
    'name': name,
    'animal': animal,
    'age': age,
  });
  print("Data Added");
}

update(String collName, docName, feild, var newFeildValue) async {
  await FirebaseFirestore.instance.collection(collName).doc(docName).update({
    feild: newFeildValue,
  });
  print("Feild Updated");
}

delete(String collName,docName)async{
  await FirebaseFirestore.instance.collection(collName).doc(docName).delete();
  print("Document Deleted");
}
