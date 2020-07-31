import 'package:CgpaCalculator/data/moor_database.dart';
import 'package:CgpaCalculator/screens/homeScreen.dart';
import 'package:CgpaCalculator/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uid;

Future<void> main() async {
  // Using Shared Preferences to persist the logged in user into the device
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  uid = prefs.getString('uid');
  // ::Debug:: -- UID of logged-in User
  print("UID:" + uid.toString());
  runApp(MyAppSecond(uid));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  verifyLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fuid = prefs.getString('uid');
    return fuid;
  }

  @override
  Widget build(BuildContext context) {
    String val;
    verifyLogin().then(
      (value) {
        val = value;
      },
    );
    if (val != null) {
      print('Error In logout');
      return Provider<AppDatabase>(
        create: (context) => AppDatabase(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.black,
            accentColor: Colors.black,
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            body: HomeScreen(),
          ),
        ),
        dispose: (context, db) => db.close(),
      );
    } else {
      print('Successfull Logout');
      return Provider<AppDatabase>(
        create: (context) => AppDatabase(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.black,
            accentColor: Colors.black,
          ),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.white,
            body: LoginPage(),
          ),
        ),
        dispose: (context, db) => db.close(),
      );
    }
  }
}

class MyAppSecond extends StatefulWidget {
  final String uid;
  MyAppSecond(this.uid);
  @override
  _MyAppSecondState createState() => _MyAppSecondState();
}

class _MyAppSecondState extends State<MyAppSecond> {
  @override
  Widget build(BuildContext context) {
    return Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.black,
          accentColor: Colors.black,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          // UID of user stored in shared preferences
          // UID == null -- Connect to LoginPage
          // UID != null -- Connect to HomePage by persisting the user
          body: widget.uid != null ? HomeScreen() : LoginPage(),
        ),
      ),
      dispose: (context, db) => db.close(),
    );
  }
}
