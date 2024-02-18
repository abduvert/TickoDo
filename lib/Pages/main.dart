import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tickodo/Pages/Home.dart';
import 'package:tickodo/Pages/login.dart';
import 'package:tickodo/Pages/searchpage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBEF-sSfpcIkf4E_id_xl0zOAdUCKvg1jo", 
        appId: "1:827829485756:web:5fa949eeb1358f413490b9", 
        messagingSenderId: "827829485756", 
        projectId: "to-do-firebase-e4e42"
        )
        );
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
      '/home': (context) => HomePage(),
      },
      theme: ThemeData.light(),
      home: Home(),
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Get Started",style: GoogleFonts.museoModerno(color: const Color.fromARGB(255, 0, 0, 0)),textAlign: TextAlign.center,),
        backgroundColor:const Color.fromARGB(255, 130, 130, 130).withOpacity(0.15),),
      body: Login(),
    );
  }
}
