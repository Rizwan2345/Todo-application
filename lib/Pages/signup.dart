import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todo_app/Pages/SignIn.dart';
import 'package:todo_app/Pages/homepage.dart';
import 'package:todo_app/Services/auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth=firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController=TextEditingController();
  TextEditingController _pwdController=TextEditingController();
  bool circular=false;
  AuthClass authClass=AuthClass();


  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      // ignore: prefer_const_constructors
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_constructors
              Text("Sign Up",style:
              // ignore: prefer_const_constructors
              TextStyle(
                fontSize: 35,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              buttonItem("assets/img.png","Continue With Google",()async{
                await authClass.googleSignIn(context);
              }),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 15,
              ),
              buttonItem("assets/img_1.png","Continue With Mobile",(){
              }),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 15,
              ),
              // ignore: prefer_const_constructors
              Text(
                  "or",
                // ignore: prefer_const_constructors
                style: TextStyle(color: Colors.white,fontSize: 16),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              textitem("Email...",_emailController,false),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 15,
              ),
              textitem("Password",_pwdController,true),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 30,
              ),
              colorbutton(),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text("If yo already an Account?",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  ),
                  // ignore: prefer_const_constructors
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(
                          context,
                          // ignore: prefer_const_constructors
                          MaterialPageRoute(builder: (builder)=>SignInPage()),
                              (route) => false);
                    },
                  // ignore: prefer_const_constructors
                  child:Text("Login",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  )
                  ),],
              )
            ],
          ),
        ),
      ),

    );
  }
  Widget colorbutton(){
    return InkWell(
      onTap: ()async{
        setState((){
          circular=true;
        });
       // Future signInWithEmailAndPassword(String email,String password) async{
          try{
            UserCredential userCredential=await firebaseAuth.createUserWithEmailAndPassword(email: _emailController.text, password: _pwdController.text);
            print(userCredential.user!.email);
            setState((){
              circular=false;
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder)=>Home()),
                    (route) => false);
          }catch(e){
            final snackbar=SnackBar(content: Text(e.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            setState((){
              circular=false;
              },);
        }


      },
      child:Container(
      width: MediaQuery.of(context).size.width -90,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
        gradient: LinearGradient(colors: [
          // ignore: prefer_const_constructors
          Color(0xfffd746c),
          // ignore: prefer_const_constructors
          Color(0xffff9068),
          // ignore: prefer_const_constructors
          Color(0xfffd746c),
        ])
      ),
      // ignore: prefer_const_constructors
      child:Center(
        // ignore: prefer_const_constructors
        child: circular?CircularProgressIndicator()
            // ignore: prefer_const_constructors
            :Text(
          "Sign Up",
          // ignore: prefer_const_constructors
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
        ),
      ),
      ),);
  }


  Widget buttonItem(String imagepath,String bottomName,Function() onTap){
    // ignore: sized_box_for_whitespace
    return  InkWell(
      onTap: onTap,
      child:Container(
      width: MediaQuery.of(context).size.width -60,
      height: 60,
      child: Card(
        color: Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          // ignore: prefer_const_constructors
          side: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagepath,
              height: 25,
              width: 25,
            ),
            // ignore: prefer_const_constructors
            SizedBox(width: 15,),
            Text(
              bottomName,
              // ignore: prefer_const_constructors
              style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),)
          ],
        ),
      ),
      ),);
  }
  Widget textitem(String labeltext,TextEditingController controller,bool obscureText){
    // ignore: sized_box_for_whitespace
    return Container(
      width: MediaQuery.of(context).size.width -70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        // ignore: prefer_const_constructors
        style:TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labeltext,
          // ignore: prefer_const_constructors
          labelStyle: TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.amber,
            )
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            // ignore: prefer_const_constructors
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          )
        ),
      ),
    );
  }
}


