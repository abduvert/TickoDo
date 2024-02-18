
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:tickodo/database.dart';

class NewTask extends StatefulWidget {
  const NewTask({
    Key? key}): super(key: key);


  @override
  State<NewTask> createState() => NewTaskState();
}

class NewTaskState extends State<NewTask> {
  
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool enable = false;
  var docId;

  @override
  void initState() {
    
    
    super.initState();
  }

  void updateButtonsVisibility() {
    setState(() {
      enable = !(title.text.isEmpty && description.text.isEmpty);
    });
  }


  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
   double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFEC7D10),
      
        ),
      body: Container(
        color: Color(0xFFEC7D10),

        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:20,top: 10,right: 12 ),
                child: TextField(
                  onChanged: (value) {
                    updateButtonsVisibility();
                  },
                  controller: title,
                  cursorColor: Colors.white,
                  style: GoogleFonts.museoModerno(color: Color.fromARGB(255, 22, 22, 22),fontSize: 25,fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                  hintStyle: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 71, 71, 71),fontSize: 25,fontWeight: FontWeight.w600),
                  hintText: "Title",
                  contentPadding: EdgeInsets.symmetric(vertical: 20), // Adjust height
                    border: InputBorder.none,
                  ),
                ),
              ),
          
              SizedBox(height: 20),
              Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: screenWidth - 50,
                    height: screenHeight-250,
                    child: TextFormField(
                      controller: description,
                      onChanged: (value) {
                        updateButtonsVisibility();
                      },
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      style: GoogleFonts.zeyada(color: Color.fromARGB(255, 0, 0, 0),fontSize: 24),  
                      
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      
                      decoration: InputDecoration(
                        counterStyle: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        
                      
                        hintText: "Write here",
                        labelStyle: GoogleFonts.zeyada(color: const Color.fromARGB(255, 77, 77, 77),fontSize: 24),
                        hintStyle: GoogleFonts.zeyada(color: const Color.fromARGB(255, 77, 77, 77),fontSize: 24),
                        border: InputBorder.none,
                      ),
                    ),
                    
                  ),
                Visibility(
                  visible:enable,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        ElevatedButton(
                        onPressed: () {
                            print("clickedd");
                            User? id = FirebaseAuth.instance.currentUser;
                            Map<String,dynamic> userTask = 
                            {
                              "title": title.text,
                              "description" : description.text,
                              "id": id!.uid
                            };


                            //FirebaseFirestore.instance.collection("Incomplete Tasks").add(userTask);
                            DatabaseServ database = DatabaseServ();
                            docId = database.addTask(userTask, id);
                            print("hereeeee" + docId);
                            Navigator.pop(context);
                        },
                        
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            
                          )),
                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255)),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          fixedSize: MaterialStateProperty.all(Size(screenWidth*0.43, 35)),
                          
                
                        ),
                        
                        child: Text('Add Task',
                        style: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.w700),),
                        
                      ),
                        SizedBox(width: 5,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                          
                            },
                            
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 115, 115, 115)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                
                              )),
                              shadowColor: MaterialStateProperty.all(Colors.black),
                              fixedSize: MaterialStateProperty.all(Size(screenWidth*0.43, 35)),
                                  
                            ),
                            child:Text(
                                    'Cancel',
                                    style: GoogleFonts.museoModerno(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                            
                          ),
                        ],
                      ),
                  ),
                )
              
            ],
          ),
        ),

      ),
    );
  }
}