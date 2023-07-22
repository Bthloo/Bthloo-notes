
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_screen.dart';
import '../providers/auth_provider.dart';
import '../register/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String routeName = 'splash-screen';

  void checkLoggedInUser(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context,listen: false);

    if (FirebaseAuth.instance.currentUser != null) {
      var user = await authProvider.getUserFromDataBase();
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        return;
      }
    }
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      checkLoggedInUser(context);
    });
    return Scaffold(
      backgroundColor: Color(0xff171717),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(width: 0),
                  borderRadius: BorderRadius.circular(20), //<-- SEE HERE
                ),
                child: Image.asset('assets/bnoteslogo.png'),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               // Icon(Icons.event_note),
                Text('Bthloo Notes',
                  style:TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 50,
                      fontWeight: FontWeight.w500
                  ) ,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}