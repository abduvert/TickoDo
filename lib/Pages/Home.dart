// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:tickodo/Firebase/firbaseauth.dart';
import 'package:tickodo/Pages/NewTask.dart';
import 'package:tickodo/Pages/completed.dart';
import 'package:tickodo/Pages/login.dart';
import 'package:tickodo/Pages/searchpage.dart';
import 'package:tickodo/Widgets/searched.dart';
import 'package:tickodo/Widgets/taskbox.dart';
import 'package:tickodo/database.dart';
import 'package:tickodo/main.dart';
import 'package:toast_notification/ToasterController.dart';
import 'package:toast_notification/ToasterType.dart';
import 'package:toast_notification/toast_notification.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  var def = Colors.orange;
  var result;
  var changed = Color.fromARGB(255, 244, 244, 244);
  bool activeTask = true;
  bool isOdd=true;
  var item;
  DatabaseServ database = DatabaseServ();
  Stream? taskStream;
  User? userId = FirebaseAuth.instance.currentUser;


  




  @override
  void initState() {
    // getontheLoad();
    super.initState();
    
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  // getontheLoad() async{
  //   print(userId.toString());
  //   taskStream = await DatabaseServ().getTask("Incomplete Tasks",userId!.uid);
  //   //User? id = FirebaseAuth.instance.currentUser;
  //   //userTasks = await database.getTask("Incomplete Tasks",id!);
  //   setState(() {
      
  //   }); 
  // }
 
  


  @override
  Widget build(BuildContext context) {

  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  final Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("Incomplete Tasks").snapshots();
  final Stream<QuerySnapshot> stream2 = FirebaseFirestore.instance.collection("Completed Tasks").snapshots();

  FirebaseAuth auth = FirebaseAuth.instance;
  ToasterController toasterController = ToasterController();

  bool isSigningOut = false;
  List<Map<String, dynamic>> userTasks;
  String title,description;
  bool updatePage = false;
  String centerTitle = 'Home';

  void updatedPage() {
    setState(() {
      updatePage = !(searchController.text.isEmpty);
    });
  }


  
  

Widget getTask(){
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        if(!snapshot.hasData)
        {
          return Center(child: CircularProgressIndicator());
        }

return Container(
  height: 250,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {
      Map<String, dynamic> dat = snapshot.data!.docs[index].data() as Map<String, dynamic>;
      
      if(dat!=null){
      String taskId = snapshot.data!.docs[index].id;
      print(taskId);

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TaskBox(
          title: dat['title'],
          description: dat['description'],
          isOdd: index.isOdd,
          id: taskId,
        ),
      );}
      else{return Container();}
    },
  ),
);

      }
    );

    

  }
Widget getCompleted(){
    return StreamBuilder(
      stream: stream2,
      builder: (context, snapshot) {
        if(!snapshot.hasData)
        {
          return Center(child: CircularProgressIndicator());
        }

return Padding(
  padding: EdgeInsets.only(left: 20),
  child: Container(
    width: screenWidth-50,
    height: 470,
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> dat = snapshot.data!.docs[index].data() as Map<String, dynamic>;
        
        if(dat!=null){
        String taskId = snapshot.data!.docs[index].id;
        print(taskId);
  
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Completed(
            title: dat['title'],
            description: dat['description'],
            isOdd: index.isOdd,
            id: taskId,
          ),
        );}
        else{return Container();}
      },
    ),
  ),
);

      }
    );

    

  }

   Future<void> _signOut() async {
    setState(() {
    isSigningOut = true;
  });

  try {
    Toaster(
        data: "Successfully posted something",
        type: ToasterType.Check,
        controller: toasterController);
    await auth.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Home()),
    );
  } catch (e) {
    print("Error during sign out: $e");
    // Handle the error if needed
  } finally {
    setState(() {
      isSigningOut = false;
    });
  }
}


    return Scaffold(
      appBar: AppBar(
        title: Text(centerTitle,style: GoogleFonts.museoModerno(color: Colors.black),),
        actions: [IconButton(
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
                   
                    value: 'Select',
                    child: Text('Select', style: GoogleFonts.museoModerno(color: Color.fromARGB(255, 0, 0, 0))),
                  ),
                  PopupMenuItem<String>(
                    onTap: (){
                         _signOut();
                    },
                    value: 'Log out',
                    child: Text('Log out',style: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 138, 9, 0)),),
                  ),
                  
                ],
              );
            },
          ),],
      ),
     
      
      body: PopScope(
       canPop: false,
              onPopInvoked: (bool didPop) {
                if (didPop) {
                  return;
                }
              },
      
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
              padding: const EdgeInsets.only(left: 15,right:15, top: 15),
                
              child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                updatedPage();
                centerTitle = 'Search';
                  
                });
              },
              
              
              decoration: InputDecoration(
                
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange),borderRadius: BorderRadius.circular(10)),
                // Remove the border property
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange),borderRadius: BorderRadius.circular(10)),
                labelText: "Search",
                focusColor: Colors.orange,
                
                filled: true,
                suffix: Icon(IconlyLight.search),
                suffixStyle: TextStyle(color: Colors.orange),
                fillColor: Color.fromARGB(255, 244, 244, 244),
                // Adjust the content padding to make the text field thinner
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              ),
            ),
            
                ),
              SizedBox(height: 10,),
              
              if (searchController.text.isEmpty) Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                          onPressed: (){
                          //await getontheLoad();

                          setState(() {
                                  activeTask = true;
                                });
                            
                              },
                              
                          style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(activeTask?def:changed),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                                  
                          )),
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          fixedSize: MaterialStateProperty.all(Size(screenWidth*0.43, 35)),
                              
                        ),
                        child: Text('Tasks',
                        style: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 17),),
                              
                            ),
                            SizedBox(width: 3,),
                            ElevatedButton(
                              onPressed: () {
                              setState(() {
                                activeTask = false;
                              });
                            
                              },
                              
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(!activeTask?def:changed),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  
                                )),
                                shadowColor: MaterialStateProperty.all(Colors.black),
                                fixedSize: MaterialStateProperty.all(Size(screenWidth*0.43, 35)),
                                    
                              ),
                              child: Text('Completed',
                              style: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 17),),
                              
                            ),
                ],
              ),
              if(searchController.text.isNotEmpty)
                

                Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    FutureBuilder<List<DocumentSnapshot>>(
      future: DatabaseServ().searchTasks(searchController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No results found');
        } else {
          List<DocumentSnapshot> searchResults = snapshot.data!;

          return Column(
            children: [
              for (var result in searchResults)
                Searched(
                  isOdd: isOdd,
                  title: result['title'],
                  description: result['description'],
                  id: result.id, // 'id' is used for DocumentSnapshot's ID
                ),
            ],
          );
        }
      },
    ),
  ],
)

              else  
              activeTask?Padding(
                  padding: const EdgeInsets.only(left: 30,top: 130,bottom:10  ),
                  child: Text("My Tasks",style: GoogleFonts.zeyada(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w400),),
                ):
              Padding(
                  padding: const EdgeInsets.only(left: 30,top: 130,bottom:10  ),
                  child: Text("Completed",style: GoogleFonts.zeyada(color: Colors.black,fontSize: 40,fontWeight: FontWeight.w400),),
                )
                ,

           if(searchController.text.isEmpty)
           activeTask?getTask():getCompleted(),
        Visibility(
          visible: activeTask & (searchController.text.isEmpty),
          child: Align(
            alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth*0.9,
                height: 40,
                margin: EdgeInsets.only(top: 240), // Adjust the margin to control the distance from the bottom
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewTask(),
                      ),
                    );
                  },
          
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(const Color.fromARGB(255, 183, 142, 255)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    
                                  )),
                                  shadowColor: MaterialStateProperty.all(Colors.black),
                                  fixedSize: MaterialStateProperty.all(Size(screenWidth*0.43, 35)),
                  
                  ),
                  child: Text("New Task",style: GoogleFonts.museoModerno(fontSize: 20,fontWeight: FontWeight.w700,color: const Color.fromARGB(255, 255, 255, 255)),)),
          
                ),
              ),
        ),
          
        
        
              
            ],
          ),
        ),
      ), 
    


    );



    
  }


void createCollection() async{
    CollectionReference newCollection = FirebaseFirestore.instance.collection('Completed Tasks');

 
  await newCollection.add({
    'fuiekd2': 'value1',
    'field2': 'value2',
   
  });

  print('New collection and document added successfully!');
}

  

  
}