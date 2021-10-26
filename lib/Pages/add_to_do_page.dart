// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({Key? key}) : super(key: key);


  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
   TextEditingController _titlecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();
  String type = "";
  String category ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
          gradient: LinearGradient(colors: [
            // ignore: prefer_const_constructors
            Color(0xff1d1e26),
            // ignore: prefer_const_constructors
            Color(0xff252041),

          ])
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ignore: prefer_const_constructors
              SizedBox(height: 30,),
              IconButton(onPressed: (){},
                  // ignore: prefer_const_constructors
                  icon: Icon(CupertinoIcons.arrow_left,
                  size: 28,
                    color: Colors.white,
                  ),
              ),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text("Create",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 33,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 8,
                  ),
                  // ignore: prefer_const_constructors
                  Text("New TODO",
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 33,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 25,
                  ),
                  label("Task Title"),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 15,
                  ),
                  title(),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 25,
                  ),
                  label("Task Type"),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 12,
                  ),
                 Row(
                   children: [
                     taskselect("Important", 0xff2664fa),
                     // ignore: prefer_const_constructors
                     SizedBox(
                       width: 20,
                     ),
                     taskselect("Planned", 0xff2bc8d9),
                   ],
                 ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 25,
                  ),
                  label("Description"),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 12,
                  ),
                  description(),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 25,
                  ),
                  label("Category"),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 12,
                  ),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      categoryselect("Food", 0xffff6d6e),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 20,
                      ),
                      categoryselect("Workout", 0xfff29732),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 20,
                      ),
                      categoryselect("Design", 0xff6557ff),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 20,
                      ),
                      categoryselect("Work", 0xff234ebd),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 20,
                      ),
                      categoryselect("Run", 0xff2bc8d9),

                    ],
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 50,
                  ),
                  button(),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget button(){
    return InkWell(
      onTap: ()async {
        final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('Todo')
            .where('title', isEqualTo: _titlecontroller.text)
            .get();

        final List < DocumentSnapshot > documents = result.docs;

        if (documents.length > 0) {

          final snackbar=SnackBar(content: Text("Title Already Exist"));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);


        } else {
          await FirebaseFirestore.instance.collection("Todo").add({
            "title": _titlecontroller.text,
            "task":type.toString(),
            "Category":category.toString(),
            "description":_descriptioncontroller.text,
          });
          Navigator.pop(context);
        }
        },
      child:Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // ignore: prefer_const_constructors
        gradient: LinearGradient(
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
          // ignore: prefer_const_constructors
          Color(0xff8a32f1),
            // ignore: prefer_const_constructors
            Color(0xffad32f9),
          ]
        )
      ),
      // ignore: prefer_const_constructors
      child: Center(
        // ignore: prefer_const_constructors
        child: Text("Add Todo",
        // ignore: prefer_const_constructors
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
        ),
      ),
    ),);
  }


  Widget description(){
    return Container(
      height: 160,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _descriptioncontroller,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Task Title",
            // ignore: prefer_const_constructors
            hintStyle:  TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
            // ignore: prefer_const_constructors
            contentPadding: EdgeInsets.only(left: 20,right: 20)
        ),
      ),
    );
  }

  Widget taskselect(String label,int color){
    return InkWell(
      onTap: (){
        setState(() {
          type=label;
        });
      },
      child:Chip(
      backgroundColor: type==label?Colors.white:Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      label: Text(
        label,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color:type==label?Colors.black: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      // ignore: prefer_const_constructors
      labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),
    ),);
  }

  Widget categoryselect(String label,int color){
    return InkWell(
      onTap: (){
        setState(() {
          category=label;
        });
      },
      child:Chip(
        backgroundColor: category==label?Colors.white:Color(color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      label: Text(
        label,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color:category==label?Colors.black: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      // ignore: prefer_const_constructors
      labelPadding: EdgeInsets.symmetric(horizontal: 17,vertical: 3.8),
    ),);
  }


  Widget title(){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titlecontroller,
        // ignore: prefer_const_constructors
        style: TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          // ignore: prefer_const_constructors
          hintStyle:  TextStyle(
            fontSize: 17,
            color: Colors.grey,
          ),
          // ignore: prefer_const_constructors
          contentPadding: EdgeInsets.only(left: 20,right: 20)
        ),
      ),
    );
  }


  Widget label(String label){
    return Text(
      label,
    // ignore: prefer_const_constructors
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 16.5,
      letterSpacing: 0.2,
    ),
    );
  }
}
