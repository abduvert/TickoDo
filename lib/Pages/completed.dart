import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickodo/Pages/comtask.dart';
import 'package:tickodo/Pages/task.dart';

class Completed extends StatefulWidget {
  Completed({
     required this.isOdd,
     required this.id,
     required this.title,
     required this.description,
    Key? key,
    }):super(key: key);

  final bool isOdd;
  String id,title,description;

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
   double screenWidth = MediaQuery.of(context).size.width;



    return widget.isOdd
        ? GestureDetector(
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>
              ComTask(
                isOdd: widget.isOdd,
                id: widget.id,
                title: widget.title,
                description: widget.description,
              ),
            )
            
            );
          },
          child: ClipRect(
              child: Stack(
                children: [
                  Image.asset(
                    "lib/assets/Vector 5.png",
                    fit: BoxFit.fill,
                   
                    
                  ),
          
                  Positioned(
                    top: 29,
                    left: 42,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,style: GoogleFonts.museoModerno(fontSize: 22,fontWeight: FontWeight.w700)
                          ),
                        
                      ],
                    ))
                ],
              ),
            ),
        )
        : GestureDetector(
          onTap: (){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>
              ComTask( 
                isOdd: widget.isOdd,
                id: widget.id,
                title: widget.title,
                description: widget.description,),
            )
            
            );
          },
          child: ClipRect(
              child: Stack(
                children: [
                  Image.asset(
                    "lib/assets/Vector 6.png",
                    //width: 200, // set your desired width
                   
                    fit: BoxFit.fill,
                    
                  ),
                  Positioned(
                    top: 29,
                    left: 36,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                        style: GoogleFonts.museoModerno(fontSize: 22,fontWeight: FontWeight.w700,),
                        textAlign: TextAlign.left,),
                        
                        
                      ],
                    ))
                
                ],
              ),
            ),
        );
 
  }
}