//import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/Pages/homepage.dart';
import 'package:todo_app/Pages/signin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass{
  // ignore: prefer_final_fields
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  firebase_auth.FirebaseAuth firebaseAuth=firebase_auth.FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();


  Future<void> googleSignIn(BuildContext context) async{
    try{
      GoogleSignInAccount? googleSignInAccount=await _googleSignIn.signIn();
      if(googleSignInAccount !=null){
        GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount.authentication;
        AuthCredential authCredential=GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try{
          UserCredential userCredential=await firebaseAuth.signInWithCredential(authCredential);
          storetokenAndData(userCredential);
          Navigator.pushAndRemoveUntil(
              context,
              // ignore: prefer_const_constructors
              MaterialPageRoute(builder: (builder)=>Home()),
                  (route) => false);
        }catch(e){
          final snackbar=SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }else{
        // ignore: prefer_const_constructors
        final snackbar=SnackBar(content: Text("Not Able to SignIn"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }catch(e){
      final snackbar=SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
  Future<void> storetokenAndData(firebase_auth.UserCredential userCredential)async{
    await storage.write(key: "token", value: userCredential.credential!.token.toString());
    await storage.write(key: "userCredential", value: userCredential.user!.uid.toString());
  }

  // Future signOut() async{
  //   try{
  //     return await firebaseAuth.signOut();
  //   }
  //   catch(e){
  //     debugPrint(e.toString());
  //     return null;
  //   }
  // }
Future<String?>gettoken()async{
    return await storage.read(key: "userCredential");
}
}