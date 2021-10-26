import 'package:flutter/material.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({Key? key,required this.title,required this.iconData,required this.iconColor,required this.time,required this.check,required this.iconBgColor}) : super(key: key);

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
                scale: 1.5,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              // ignore: prefer_const_constructors
              activeColor:Color(0xff6cf8a9),
              // ignore: prefer_const_constructors
              checkColor: Color(0xff0e3e26),
              value: check,
              onChanged: (bool? value){},
            ),
            ),
            data: ThemeData(
              primarySwatch: Colors.blue,
              // ignore: prefer_const_constructors
              unselectedWidgetColor: Color(0xff5e616a)
            ),
          ),
          Expanded(
              // ignore: sized_box_for_whitespace
              child: Container(
            height: 75,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // ignore: prefer_const_constructors
                  color: Color(0xff2a2e3d),
                  child: Row(
                    children: [
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        height: 33,
                        width: 36,
                        decoration: BoxDecoration(
                          color: iconBgColor,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        // ignore: prefer_const_constructors
                        child: Icon(iconData,color:iconColor ,),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        width: 20,
                      ),
                      // ignore: prefer_const_constructors
                      Expanded(
                      // ignore: prefer_const_constructors
                      child:Text(title,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                      ),
                      ),
                      // ignore: prefer_const_constructors
                      Text(
                        time,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
          ),),
        ],
      ),
    );
  }
}
