import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickodo/database.dart';

class ComTask extends StatefulWidget {
  ComTask({
    required this.id,
    required this.title,
    required this.description,

    required this.isOdd,
    Key? key}): super(key: key);

  final bool isOdd;
  String id,title,description;

  @override
  State<ComTask> createState() => ComTaskState();
}

class ComTaskState extends State<ComTask> {

  void delete(String task, String id) async
  {
    await DatabaseServ().deleteTask(task, id);
    Navigator.pop(context);
  }
  void complete(String id) async
  {
    await DatabaseServ().markCompleted(id);
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
   double screenHeight = MediaQuery.of(context).size.height;
   double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.isOdd?Color(0xFF1C6E8C):Color(0xFFA4BEF3),
        actions:[ IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  MediaQuery.of(context).size.width - 50, // Adjust the right position
                  kToolbarHeight,
                  0,
                  0,
                ),
                items: [
                  PopupMenuItem<String>(
                    onTap: () {
                      delete("Completed Tasks", widget.id);
                    },
                    value: 'Delete',
                    child: Text('Delete'),
                  ),
                ],
              );
            },
          ),],
      ),
      body: Container(
        width: screenWidth,
        color: widget.isOdd?Color(0xFF1C6E8C):Color(0xFFA4BEF3),

        child: Column(
        
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20,top: 10,right: 12 ),
              child: TextField(
                cursorColor: Colors.white,
                style: GoogleFonts.museoModerno(color: Color.fromARGB(255, 22, 22, 22),fontSize: 25,fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                hintStyle: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 71, 71, 71),fontSize: 25,fontWeight: FontWeight.w600),
                hintText: widget.title,
                contentPadding: EdgeInsets.symmetric(vertical: 20), // Adjust height
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 20),
            Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: screenWidth - 50,
                  child: TextFormField(
                    cursorColor: const Color.fromARGB(255, 255, 255, 255),
                    style: GoogleFonts.zeyada(color: Color.fromARGB(255, 0, 0, 0),fontSize: 24),  
                    
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    
                    decoration: InputDecoration(
                      counterStyle: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      
                    
                      hintText: widget.description,
                      labelStyle: GoogleFonts.zeyada(color: const Color.fromARGB(255, 77, 77, 77),fontSize: 24),
                      hintStyle: GoogleFonts.zeyada(color: const Color.fromARGB(255, 77, 77, 77),fontSize: 24),
                      border: InputBorder.none,
                    ),
                  ),
                ),

            
          ],
          
        ),

      ),
    );
  }
}