import 'package:bnotes/database/my_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/task.dart';
import '../providers/auth_provider.dart';
import '../register/login_screen.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffEDEDED),
                radius: 80,
                  child: Icon(
                    Icons.person,
                    size: 150,
                    color: Theme.of(context).primaryColor,)),
              SizedBox(height: 30,),
              Text(userProvider.currentUser?.name ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 60,
                color: Color(0xffEDEDED)
              ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ID : ",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffEDEDED)
                    ),
                  ),
                  SelectableText(
                    userProvider.currentUser?.id ?? "",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffEDEDED)
                      ),
                    ),

                ],
              ),
              SizedBox(height: 30,),
            //  Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextButton.icon(
                      onPressed: (){
                        userProvider.logout();
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName,
                                (route) => false);
                      },
                      icon:  Text('Logout',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xffEDEDED)
                          ),),
                      label:  Icon(Icons.logout,size: 40,),
                      ),

                ],
              ),
              TextButton(onPressed: ()async{
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: userProvider.currentUser?.email ?? '');
              }, child: Text('Change Password'))
            ],
          ),
      ),
    );
  }
}
