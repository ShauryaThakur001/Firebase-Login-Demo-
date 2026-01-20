import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogindemo/Screens/HomeScree.dart';
import 'package:firebaselogindemo/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

Widget AuthGate(){
  final user=FirebaseAuth.instance.currentUser;

  if(user!=null){
    return HomeScreen();
  }
  else{
    return LoginScreen();
  }
}


// Also do same work like Manual Auth Gate


// class AuthGate extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (snapshot.hasData) {
//           return HomeScreen();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
// }
