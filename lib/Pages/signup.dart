import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickodo/Firebase/firbaseauth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirAuth auth = FirAuth();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController favController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    favController.dispose();
    super.dispose();
  }

  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    return RegExp(emailPattern).hasMatch(email);
  }

  bool isPasswordValid(String password) {
    String passwordPattern =
        r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    return RegExp(passwordPattern).hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "SIGN UP",
                  style: GoogleFonts.museoModerno(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Email",
                    labelStyle: GoogleFonts.museoModerno(
                        color: Color.fromARGB(255, 52, 52, 52),
                        fontWeight: FontWeight.w700),
                    focusColor: Colors.orange,
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Password",
                    labelStyle: GoogleFonts.museoModerno(
                        color: Color.fromARGB(255, 52, 52, 52),
                        fontWeight: FontWeight.w700),
                    focusColor: Colors.orange,
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: favController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                        borderRadius: BorderRadius.circular(10)),
                    labelText: "Favorite Color",
                    labelStyle: GoogleFonts.museoModerno(
                        color: Color.fromARGB(255, 52, 52, 52),
                        fontWeight: FontWeight.w700),
                    focusColor: Colors.orange,
                    filled: true,
                    fillColor: Color.fromARGB(255, 238, 238, 238),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : signUp,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    shadowColor:
                        MaterialStateProperty.all(Colors.black),
                    fixedSize: MaterialStateProperty.all(
                        Size(170, 35)),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text(
                          'Create Account',
                          style: GoogleFonts.museoModerno(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String pass = passController.text;

    User? user = await auth.signUpwithEmail(email, pass);

    setState(() {
      isLoading = false;
    });

    if (user != null) {
      print("User successfully");
    }
  }
}
