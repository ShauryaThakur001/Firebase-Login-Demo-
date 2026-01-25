import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class supabaseStorageService {
  final ImagePicker _picker = ImagePicker();

  Future<File?>pickImage()async{
    final XFile? image=await _picker.pickImage(source: ImageSource.gallery);

    if (image==null) return null;

    return File(image.path);
  }

  Future<String>uploadFile(File image)async{
    final supabase=Supabase.instance.client;

    final fileName="images/${DateTime.now().millisecondsSinceEpoch}.jpg";

    await supabase.storage
    .from('images')
    .upload(fileName, image);

    final imageUrl=supabase.storage
    .from('images')
    .getPublicUrl(fileName);

    return imageUrl;
  }

  Future<void>saveImageUrlToFirebase(String imageUrl)async{
    await FirebaseFirestore.instance.collection("images").add({
      "imageUrl" : imageUrl,
      "createdAt" : FieldValue.serverTimestamp(),
    });
  }

  Future<void>uploadAndSaveImage()async{
    File? image = await pickImage();
    if (image==null) return;

    String imageUrl = await uploadFile(image);

    await saveImageUrlToFirebase(imageUrl);

    print("✅ Image uploaded & saved");

  }
}