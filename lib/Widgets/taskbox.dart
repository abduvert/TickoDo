import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickodo/Pages/task.dart';

class TaskBox extends StatefulWidget {
 TaskBox({

    required this.id,
    required this.isOdd,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  final bool isOdd;
  String title,description,id;
  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {

   
  @override
  Widget build(BuildContext context) {
      double screenHeight = MediaQuery.of(context).size.height;
   double screenWidth = MediaQuery.of(context).size.width;
    return widget.isOdd
        ? GestureDetector(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>
            Task(
              isOdd:widget.isOdd,
              title: widget.title,
              description: widget.description,
              id: widget.id,
              
              )));
          },
          child: ClipRect(
              child: Stack(
                children: [
                  Image.asset(
                    "lib/assets/Vector 2.png",
                    fit: BoxFit.fill,
                    height: 500,
                    
                  ),
          
                  Positioned(
                    top: 30,
                    left: 42,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          child: Text(widget.title,style: GoogleFonts.museoModerno(fontSize: 22,fontWeight: FontWeight.w700),)),
                        SizedBox(height: 4,),
                        
                          Container(
                            width: 140,
                            child: Text(widget.description,
                            style: GoogleFonts.zeyada(fontSize: 19,fontWeight: FontWeight.w500,),
                            textAlign: TextAlign.left,
                            
                          ),
                          ),
                        
                      ],
                    ))
                ],
              ),
            ),
        )
        : GestureDetector(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>
            Task(
              isOdd:widget.isOdd,
              title: widget.title,
              description: widget.description,
              id: widget.id,
            )));
          },
          child: ClipRect(
              child: Stack(
                children: [
                  Image.asset(
                    "lib/assets/Vector 3.png",
                    //width: 200, // set your desired width
                    height: 1000,
                    fit: BoxFit.fill,
                    
                  ),
                  Positioned(
                    top: 30,
                    left: 36,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          child: Text(widget.title,
                          style: GoogleFonts.museoModerno(fontSize: 22,fontWeight: FontWeight.w700,),
                          textAlign: TextAlign.left,),
                        ),
                        SizedBox(height: 4,),
                        
                          Container(
                            width: 150,
                            child: Text(widget.description,
                            style: GoogleFonts.zeyada(fontSize: 19,fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                            
                                                  ),
                          ),
                        
                      ],
                    ))
                
                ],
              ),
            ),
        );
  }
}