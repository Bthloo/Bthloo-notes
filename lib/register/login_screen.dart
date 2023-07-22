
import 'package:bnotes/database/my_database.dart';
import 'package:bnotes/providers/auth_provider.dart';
import 'package:bnotes/register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/custom_form_field.dart';
import '../component/dialog.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPassword = true;
  Icon closeEye = Icon(Icons.visibility);

  FirebaseAuth authService = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff171717),
        title: Text('Login',
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
                          suffix: IconButton(
                            onPressed: (){
                              setState(() {
                                showPassword();
                              });

                            },
                            icon: closeEye ,color: Color(0xffEDEDED)),
                          isPassword: isPassword,
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          hintText: 'Password',
                          validator: (text){
                            if(text == null || text.trim().isEmpty || text.length < 6){
                              return 'The Password Must at least 6 characters';
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
                                login();
                            },
                            child: const Text('Login',
                              style: TextStyle(
                                fontSize: 20,
                                color:Color(0xffEDEDED),
                              ),
                            )
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have an Account ? " ,
                               style: TextStyle(
                              color:Color(0xffEDEDED),
                        ),
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                                },
                                child: Text("Register")),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Forgot Your Password ? " ,
                              style: TextStyle(
                                color:Color(0xffEDEDED),
                              ),
                            ),
                            TextButton(
                                onPressed: (){
                                  resetPassword();
                                },
                                child: Text("Reset")),
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
  void resetPassword()async{
    if(formkey.currentState?.validate() == false) {
      return;
    }
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
    DialogUtilities.showMessage(context, 'Check Your Email',
        posstiveActionName: 'ok',
       posstiveAction: (){},
       dismissible: true
    );
  }
//basselalaa55@gmail.com
  //B@$$elalaa2452002
  void login()async{
    if(formkey.currentState?.validate() == false) {
      return;
    }
    DialogUtilities.ShowLoadingDialog(context, 'Loading...');
    try {
      var result = await authService.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      var user = await MyDataBase.readUser(result.user?.uid ?? "");
      DialogUtilities.hideDialog(context);
      if(user==null){
        // user is authenticated but not exists in the database
        DialogUtilities.showMessage(context, "error. can't find user in db",
            posstiveActionName: 'ok');
        return;
      } else if(authService.currentUser?.emailVerified == true) {
        // DialogUtilities.hideDialog(context);
        var authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.updateUser(user);
        DialogUtilities.showMessage(context, 'Successful Login',
            posstiveActionName: 'ok',
            posstiveAction: () {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }, dismissible: false
        );
      }
      else{
        DialogUtilities.showMessage(context, 'jjfjfjjf',
            posstiveActionName: 'ok',
            posstiveAction: () {

            }, dismissible: false
        );
      }
    }on FirebaseAuthException catch (e) {

      DialogUtilities.hideDialog(context);
      String errorMessage = 'Something Went Wrong';
      if (e.code == 'user-not-found') {
        String errorMessage = 'User-not-found.';
        DialogUtilities.showMessage(context, errorMessage,
          posstiveActionName: 'Try Again',
          posstiveAction: (){
            login();
          },
          nigaiveActionName: 'Cancel',

        );
      } else if (e.code == 'wrong-password') {
        String errorMessage = 'wrong-password.';
        DialogUtilities.showMessage(context, errorMessage, posstiveActionName: 'Try Again',
          posstiveAction: (){
            login();
          },
          nigaiveActionName: 'Cancel',
        );
      }
    } catch (e) {
      String errorMessage = 'Something Went Wrong';
      DialogUtilities.hideDialog(context);
      DialogUtilities.showMessage(context, errorMessage, posstiveActionName: 'Try Again',
        posstiveAction: (){
          login();
        },
        nigaiveActionName: 'Cancel',
      );
    }
  }

  void showPassword(){
    if(isPassword == true){
      setState(() {
        closeEye = Icon(Icons.visibility_off);
        isPassword = false;
      });

    } else {
      setState(() {
        closeEye = Icon(Icons.visibility);
        isPassword = true;
      });

    }
  }
}
