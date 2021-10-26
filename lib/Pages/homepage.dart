import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Pages/add_to_do_page.dart';
import 'package:todo_app/Pages/viewdata.dart';
import 'package:todo_app/Services/auth_services.dart';
import 'package:todo_app/customs/todo_card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthClass authClass=AuthClass();
  final Stream<QuerySnapshot> _stream=FirebaseFirestore.instance.collection("Todo").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          // ignore: prefer_const_constructors
          CircleAvatar(
            // ignore: prefer_const_constructors
            backgroundImage: AssetImage("assets/Rizwan.jpeg"),
          ),
          // ignore: prefer_const_constructors
          SizedBox(
            width: 25,
          ),
        ],
        // ignore: prefer_const_constructors
        bottom: PreferredSize(
          // ignore: prefer_const_constructors
          child: Align(
            alignment:Alignment.centerLeft,
            // ignore: prefer_const_constructors
            child: Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(left: 22),
              // ignore: prefer_const_constructors
              child: Text(
                  "Monday 21",
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          BottomNavigationBarItem(
              // ignore: prefer_const_constructors
              icon: Icon(
                  Icons.home,
                size: 32,
                color: Colors.white,
              ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon:InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddToDo()));
              },
            child:Container(
              height: 52,
            width: 52,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // ignore: prefer_const_constructors
              gradient: LinearGradient(
                // ignore: prefer_const_literals_to_create_immutables
                colors: [
                  Colors.indigoAccent,
                  Colors.purple,
                ]
              )
            ),
            // ignore: prefer_const_constructors
            child:Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
            ),
            ),
            title: Container(),
             ),
          BottomNavigationBarItem(
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
            title: Container(),
          ),
        ],
      ),
      // ignore: prefer_const_constructors
      body:StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context,snapshot){
          if(!snapshot.hasData){
            // ignore: prefer_const_constructors
            return Center(child: CircularProgressIndicator(),);
          }
      // ignore: prefer_const_constructors
      return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index){
            IconData iconData;
            Color iconColor;
            Map<String,dynamic> document=
            snapshot.data!.docs[index].data() as Map<String,dynamic>;
            switch(document["Category"]){
              case "Work":
                iconData=Icons.local_post_office_outlined;
                iconColor=Colors.yellow;
                break;
              // ignore: no_duplicate_case_values
              case "Food":
                iconData=Icons.local_grocery_store;
                iconColor=Colors.blue;
                break;
              case "Workout":
                iconData=Icons.alarm;
                iconColor=Colors.teal;
                break;
              case "Design":
                iconData=Icons.audiotrack;
                iconColor=Colors.green;
                break;
              case "Run":
                iconData=Icons.run_circle_outlined;
                iconColor=Colors.red;
                break;
              default:
                iconData=Icons.run_circle_outlined;
                iconColor=Colors.red;
            }
            // ignore: prefer_const_constructors
            return InkWell(
              onTap: (){
                // ignore: prefer_const_constructors
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder)=>
                            ViewData(
                              document: document,
                              id:snapshot.data!.docs[index].id,
                            )
                    )
                );
              },
              child:ToDoCard(
              title: document["title"]==null ? "hey there":document["title"],
              check: true,
              iconBgColor: Colors.black87,
              iconData: iconData,
              iconColor: iconColor,
              time: "11 PM",
            ),);
          });
      }
    ),  );
  }
}
