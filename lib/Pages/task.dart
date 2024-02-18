import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickodo/Pages/Home.dart';
import 'package:tickodo/Pages/newtask.dart';
import 'package:tickodo/database.dart';

class Task extends StatefulWidget {
  Task({
    required this.isOdd,
    required this.id,
    required this.title,
    required this.description,
    Key? key}): super(key: key);

  final bool isOdd;
  String title,description,id;

  @override
  State<Task> createState() => TaskState();
}

class TaskState extends State<Task> {

  TextEditingController titleCont = TextEditingController();
  TextEditingController desCont = TextEditingController();
  bool isChanged = false;

  @override
  void initState() {
    titleCont.text = widget.title;
    desCont.text = widget.description;

    titleCont.addListener(() {
      onTextChanged();
    });
    desCont.addListener(() {
      onTextChanged();
    });

    
    super.initState();
    
  }

    void onTextChanged() {
    if (!isChanged) {
      setState(() {
        isChanged = true;
      });
    }
  }


  void onSaveChanges(String task,String id, Map<String, dynamic> data) async {
    // Implement your save changes logic here
    print("Save Changes");
    await DatabaseServ().updateTask(task, id, data);
    // Reset the isChanged flag
    setState(() {
      isChanged = false;
    });
  }

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
        backgroundColor: widget.isOdd?Color(0xFFEC7D10) :Color(0xFF1C6E8C),
        actions:[ 
          
          isChanged
              ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElevatedButton(
                  onPressed:(){ onSaveChanges(
                    "Incomplete Tasks",
                    widget.id,
                    {
                      'title': titleCont.text,
                      'description':desCont.text,
                      'id':HomePageState().userId!.uid,
                      'completed': false
                    }
                  );},
                child: Text("Save",
                style: GoogleFonts.museoModerno(
                  color: const Color.fromARGB(255, 0, 0, 0), fontSize: 12,fontWeight: FontWeight.w400),),
                  style: ElevatedButton.styleFrom(
                    //fixedSize: Size(50, 20),
                    shadowColor: Colors.black
                  ),
                   
                ),
              )
              : 
          IconButton(
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
                      complete(widget.id);
                    },
                    value: 'Mark as Completed',
                    child: Text('Mark as Completed'),
                  ),
                  PopupMenuItem<String>(
                    onTap: () {
                      delete("Incomplete Tasks", widget.id);
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
        color: widget.isOdd?Color(0xFFEC7D10) :Color(0xFF1C6E8C),

        child: Column(
        
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20,top: 10,right: 12 ),
              child: TextField(
                
                controller: titleCont,
                cursorColor: Colors.white,
                style: GoogleFonts.museoModerno(color: Color.fromARGB(255, 22, 22, 22),fontSize: 25,fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                labelStyle: GoogleFonts.museoModerno(color: Color.fromARGB(255, 22, 22, 22),fontSize: 25,fontWeight: FontWeight.w600),
                // hintStyle: GoogleFonts.museoModerno(color: Color.fromARGB(255, 0, 0, 0),fontSize: 25,fontWeight: FontWeight.w600),
                // hintText: widget.title,
                //labelText: widget.title,
                
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
                    controller: desCont,
                    cursorColor: const Color.fromARGB(255, 255, 255, 255),
                    style: GoogleFonts.zeyada(color: Color.fromARGB(255, 0, 0, 0),fontSize: 24),  
                    
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    
                    decoration: InputDecoration(
                      counterStyle: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      
                    
                      //hintText: widget.description,
                      //labelText:widget.description ,
                      labelStyle: GoogleFonts.zeyada(color: Color.fromARGB(255, 0, 0, 0),fontSize: 24),
                      //hintStyle: GoogleFonts.zeyada(color: Color.fromARGB(255, 0, 0, 0),fontSize: 24),
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