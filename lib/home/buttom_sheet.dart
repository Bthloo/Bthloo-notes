import 'package:bnotes/component/dialog.dart';
import 'package:bnotes/database/my_database.dart';
import 'package:bnotes/database/task.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../component/notes_field.dart';
import '../providers/auth_provider.dart';

class AddTaskButtomSheet extends StatefulWidget {

  @override
  State<AddTaskButtomSheet> createState() => AddTaskButtomSheetState();
}

class AddTaskButtomSheetState extends State<AddTaskButtomSheet> {

   var titleController = TextEditingController();

   var descriptionController = TextEditingController();
   var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: Container(
        color: const Color(0xff171717),
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text('Add Note',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffDA0037),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(side: BorderSide.none)
                      ),
                      onPressed: () {
                        addTask();
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.add)
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              SizedBox(
                child: NotesFormField(
                  expands: false,
                    maxline: 1,
                    hintText: 'Note Title',
                    controller: titleController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'Please Enter Note Title';
                      }
                      return null;
                    }),
              ),

             // SizedBox(height: 5,),
              const SizedBox(height: 10,),
              Expanded(
                flex: 9,
                child: NotesFormField(
                    hintText: 'Note Description',
                    controller: descriptionController,
                    validator: (text) {
                      if (text == null || text
                          .trim()
                          .isEmpty) {
                        return 'Please Enter Note Description';
                      }
                      return null;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

   void addTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialogUtilities.ShowLoadingDialog(context, 'Loading...');
    Task task = Task(
        title: titleController.text,
        desc: descriptionController.text
    );
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    await MyDataBase.addTask(authProvider.currentUser?.id ?? '', task);
    DialogUtilities.hideDialog(context);
    Fluttertoast.showToast(
        msg: "Note Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );

     }


  }
