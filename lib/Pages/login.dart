// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickodo/Firebase/firbaseauth.dart';
import 'package:tickodo/Pages/signup.dart';
import 'package:toast_notification/ToasterController.dart';
import 'package:toast_notification/ToasterType.dart';
import 'package:toast_notification/toast_notification.dart';
import 'package:iconly/iconly.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {

  FirAuth auth = FirAuth();
  ToasterController toasterController = ToasterController();
  bool _isFocused = false;
  bool _isFocused2 = false;


  static bool isSignedIn = false;
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _focusNode1.addListener(() {
      setState(() {
        _isFocused = _focusNode1.hasFocus;
      });
    });
    _focusNode2.addListener(() {
      setState(() {
        _isFocused2 = _focusNode2.hasFocus;
      });
    });

    
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    
    _focusNode1.dispose();
    _focusNode2.dispose();
    
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    bool isSignedIn = false;
    bool pass  = false;
    var passCount = 0;


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scrollbar(
      child: Stack(
        children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Positioned(
                      child: Image.asset("lib/assets/Vector.png")),
                      
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          
                          Positioned(

                              child: Image.asset("lib/assets/Ellipse 1.png",scale: 1.1,alignment: Alignment.bottomLeft,)),
                        ],
                      ), 
                      
                    ],
                  ),
                  
       
          Container(height: screenHeight,color: const Color.fromARGB(255, 130, 130, 130).withOpacity(0.15),),
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left:20,right: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Image.asset("lib/assets/TickoDo.png"),
                    Text("TickoDo",
                    style: GoogleFonts.wendyOne(color: Colors.black,fontSize: 70),),
                    SizedBox(height: 5,),
                    TextField(
                    focusNode: _focusNode1,
                  controller: emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange),borderRadius: BorderRadius.circular(10)),
                    // Remove the border property
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange),borderRadius: BorderRadius.circular(10)),
                    labelText: "Email",
                    labelStyle: GoogleFonts.museoModerno(color: Color.fromARGB(255, 52, 52, 52),fontWeight: FontWeight.w700),
                    focusColor: Colors.orange,
                    suffixStyle: TextStyle(color: Colors.orange),
                    
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    suffixIcon: Icon(IconlyLight.message,
                     color: _isFocused ? Colors.orange : const Color.fromARGB(255, 0, 0, 0),),
                    // Adjust the content padding to make the text field thinner
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  ),
                ),
          
                SizedBox(height: 10),
          
                TextField(
                  obscureText: !pass,
                  controller: passController,
                  focusNode: _focusNode2,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange),borderRadius: BorderRadius.circular(10)),
                    // Remove the border property
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.orange),borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    labelStyle: GoogleFonts.museoModerno(color: Color.fromARGB(255, 52, 52, 52),fontWeight: FontWeight.w700),
                    focusColor: Colors.orange,
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    suffixStyle: TextStyle(color: Colors.orange),

                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                           
                            pass = !pass;
                                                      });
                        },
                        child: Icon(
                         pass ? IconlyLight.hide : IconlyLight.show,
                          color: _isFocused2 ? Colors.orange : const Color.fromARGB(255, 0, 0, 0),
                        ),
                    
                    //fillColor: const Color.fromARGB(255, 39, 39, 39),
                    // Adjust the content padding to make the text field thinner
                  ),
                ),
                ),
          
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            signIn();
                        
                          },
                          
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.orange),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              
                            )),
                            shadowColor: MaterialStateProperty.all(Colors.black),
                            fixedSize: MaterialStateProperty.all(Size(screenWidth*0.43, 35)),
                                
                          ),
                          child: isSignedIn
                              ? Toaster(
                                  data: "Successfully logged in",
                                  type: ToasterType.Check,
                                  controller: toasterController,
                                )
                              : Text(
                                  'Login',
                                  style: GoogleFonts.museoModerno(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                          
                        ),
                      SizedBox(width: 5,),
                      ElevatedButton(
                      onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
          
                      },
                      
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          
                        )),
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 92, 4, 244)),
                        shadowColor: MaterialStateProperty.all(Colors.black),
                        fixedSize: MaterialStateProperty.all(Size(screenWidth*0.43, 35)),
                        
              
                      ),
                      
                      child: Text('Sign Up',
                      style: GoogleFonts.museoModerno(color: Colors.white,fontWeight: FontWeight.w700),),
                      
                    ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text("Forgot Password?",style: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 60, 60, 60)),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void signIn() async{
    String email= emailController.text;
    String pass = passController.text;

    try {
      setState(() {
        isSignedIn = true;
      });
    }
    catch(e){}


    User? user = await auth.signInwithEmail(email, pass);

    if(user!=null){
      print("User successfully logged in!");
      setState(() {
        isSignedIn = true;

      });
      Navigator.pushNamed(context, "/home");
      

    }
    else{
      
      print("Email or Password is incorrect");
      
      Toaster(
        data: "Incorrect Email or Password",
        type: ToasterType.Error,
        controller: toasterController,);
      
  }
    }

  }

