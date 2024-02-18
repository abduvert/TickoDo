import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickodo/Pages/task.dart';

class Searched extends StatefulWidget {
  Searched({
    required this.title,
    required this.description,
    required isOdd,
    required this.id,
    Key? key}): super(key: key);

  String title,description,id;
  bool isOdd = false;

  @override
  State<Searched> createState() => _SearchedState();
}

class _SearchedState extends State<Searched> {
  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;


    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,top: 7),
      
      child: GestureDetector(
        onTap: () {
          Task(isOdd: widget.isOdd, id: widget.id, title: widget.title, description: widget.description);
        },
        child: Container(
        
          height: 80,
          width: screenWidth,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14),
            color: const Color.fromARGB(255, 212, 212, 212)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,
                style: GoogleFonts.museoModerno(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                  
                  ),),
                Text(widget.description,
                style: GoogleFonts.museoModerno(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400
                  
                  ),),
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}