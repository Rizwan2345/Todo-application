import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Pages/add_to_do_page.dart';
import 'package:todo_app/Pages/homepage.dart';
import 'package:todo_app/Pages/signin.dart';
import 'package:todo_app/Pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_app/Services/auth_services.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth=firebase_auth.FirebaseAuth.instance;
  Widget currentPage = SignUpPage();
  AuthClass authClass=AuthClass();

  @override
  void initState(){
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String? userCredential=await authClass.gettoken();
    if( userCredential!=null){
      setState(() {
        currentPage=Home();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: prefer_const_constructors
      home: Home(),
    );
  }
}
