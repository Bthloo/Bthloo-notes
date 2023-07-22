import 'package:bnotes/database/my_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:bnotes/database/model/user.dart' as MyUser ;
import '../component/custom_form_field.dart';
import '../component/dialog.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
var formkey = GlobalKey<FormState>();

var nameController = TextEditingController();

var emailController = TextEditingController();

var passwordController = TextEditingController();

var passwordConfirmationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff171717),
        title: Text('Register',
          style: TextStyle(
              color: Theme.of(context).primaryColor
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Text('Bthloo Notes',
                    style:TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 50,
                        fontWeight: FontWeight.w500
                    ) ,),
                  SizedBox(height: 50,),
                  Form(
                    key: formkey,
                    child: Column(
                        mainAxisAlignment : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomFormField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          hintText: 'Full Name',
                          validator: (text){
                            if(text == null || text.trim().isEmpty){
                              return 'Please Enter Your Name';
                            }
                          },

                        ),
                        SizedBox(height: 20,),
                        CustomFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          hintText: 'Email',
                          validator: (text){
                            if(text == null || text.trim().isEmpty){
                              return 'please Enter Email Address';
                            }
                            var regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                            if(!regex.hasMatch(text)){
                              return 'please enter a valid email';
                            }

                          },
                        ),
                        SizedBox(height: 20,),
                        CustomFormField(
                          isPassword: true,
                          controller: passwordController,
                          hintText: 'Password',
                          validator: (text){
                            if(text == null || text.trim().isEmpty || text.length < 6){
                              return 'The Password Must at least 6 characters';
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        CustomFormField(
                          isPassword: true,
                          controller: passwordConfirmationController,
                          hintText: 'Password Confirmation',
                          validator: (text){
                            if(passwordController.text != text){
                              return "Password Doesn't Match";
                            }
                          },
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                          ),
                            onPressed: (){
                              register();
                            },
                            child: const Text('Register',
                              style: TextStyle(
                                  fontSize: 20,
                                color:Color(0xffEDEDED),
                              ),
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Allready Have an Account ? " ,
                              style: TextStyle(
                                color:Color(0xffEDEDED),
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                                },
                                child: Text("Login")),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FirebaseAuth authService = FirebaseAuth.instance;

  void register()async{
    if(formkey.currentState?.validate() == false){
      return;
    }
     DialogUtilities.ShowLoadingDialog(context, 'Loading...');
    try {

      var result = await authService.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      var myUser = MyUser.User(
          id: result.user?.uid,
          name: nameController.text,
          email: emailController.text
      );


      if(authService.currentUser?.emailVerified == false){
        await authService.currentUser?.sendEmailVerification();
        DialogUtilities.showMessage(context, 'Email Verification sent to your Email',
            posstiveActionName: 'ok',
            posstiveAction: (){
              Navigator.pushReplacementNamed(context,LoginScreen.routeName);
            },
            nigaiveActionName: 'Cancel',
            nigaiveAction: (){
              DialogUtilities.hideDialog(context);
            }
        );
      }

      await MyDataBase.addUser(myUser);

    }on FirebaseAuthException catch (e) {

      DialogUtilities.hideDialog(context);
      String errorMessage = 'Something Went Wrong';
      if (e.code == 'weak-password') {
        String errorMessage = 'The password provided is too weak.';
        DialogUtilities.showMessage(context, errorMessage,
            posstiveActionName: 'Try Again',
            posstiveAction: (){
              register();
        },
          nigaiveActionName: 'Cancel',

        );
      } else if (e.code == 'email-already-in-use') {
        String errorMessage = 'The account already exists for that email.';
        DialogUtilities.showMessage(context, errorMessage, posstiveActionName: 'Try Again',
          posstiveAction: (){
            register();
          },
          nigaiveActionName: 'Cancel',
         );
      }
    } catch (e) {
      String errorMessage = 'Something Went Wrong';
      DialogUtilities.hideDialog(context);
      DialogUtilities.showMessage(context, errorMessage, posstiveActionName: 'Try Again',
        posstiveAction: (){
          register();
        },
        nigaiveActionName: 'Cancel',
       );
    }
  }
}
