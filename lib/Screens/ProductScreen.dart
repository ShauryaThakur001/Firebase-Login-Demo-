import 'package:firebaselogindemo/Firebase/ProductDatabase.dart';
import 'package:firebaselogindemo/Models/product_model.dart';
import 'package:firebaselogindemo/Screens/Products.dart';
import 'package:flutter/material.dart';

class Productscreen extends StatefulWidget {
  const Productscreen({super.key});

  @override
  State<Productscreen> createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  final _formKey = GlobalKey<FormState>();

  Productdatabase service = new Productdatabase();

  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController isAvailableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("CRUD + Model")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Enter Product Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter name...";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: idController,
                      decoration: InputDecoration(
                        labelText: "Enter Product Id",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || value.length > 3) {
                          return "Enter valid id...";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: "Enter Product Price",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter price...";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "Enter Product description",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter desciption...";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: isAvailableController,
                      decoration: InputDecoration(
                        labelText: "Is Product Available",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter availability";
                        }
                        if (value.toLowerCase() != 'true' &&
                            value.toLowerCase() != 'false') {
                          return "Enter true or false";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = ProductModel(
                      id: int.parse(idController.text),
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      description: descriptionController.text,
                      isAvailable:
                          isAvailableController.text.toLowerCase() == 'true',
                    );
                    service.createProduct('ukbs', idController.text, product);
                  }
                },
                child: Text("Create Product"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Products()),
                  );
                },
                child: Text("Read Products"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> updateData = {};

                    if (nameController.text.trim().isNotEmpty) {
                      updateData['name'] = nameController.text.trim();
                    }

                    if (priceController.text.trim().isNotEmpty) {
                      updateData['price'] = double.parse(
                        priceController.text.trim(),
                      );
                    }

                    if (descriptionController.text.trim().isNotEmpty) {
                      updateData['description'] = descriptionController.text
                          .trim();
                    }

                    if (isAvailableController.text.trim().isNotEmpty) {
                      updateData['isAvailable'] =
                          isAvailableController.text.toLowerCase() == 'true';
                    }

                    if (updateData.isNotEmpty) {
                      await service.updateProduct(
                        'ukbs', // collection
                        idController.text, // docId
                        updateData,
                      );
                    }
                  }
                },
                child: const Text("Update Product"),
              ),

              ElevatedButton(
                onPressed: () {
                  service.deleteProduct('ukbs', idController.text);
                },
                child: Text("Delete Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
