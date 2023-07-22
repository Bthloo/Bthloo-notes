import 'package:bnotes/database/my_database.dart';
import 'package:bnotes/database/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/notes_field.dart';
import '../providers/auth_provider.dart';

class EditNote extends StatefulWidget {
  static const String routeName = 'edit';
  static var formKey = GlobalKey<FormState>();

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();
  late Task task;

@override
  void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     task = ModalRoute.of(context)!.settings.arguments as Task;
    titleController.text = task.title!;
    descriptionController.text =task.desc!;
  });

  }
  @override
  Widget build(BuildContext context) {
    var editProvider = Provider.of<AuthProvider>(context);



    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xff171717),
        elevation: 0,
        title: Text('Edit Note',
        style: TextStyle(
          fontSize: 25,
          color: Theme.of(context).primaryColor
        ),
        ),
        actions: [
          IconButton(onPressed: (){
            if(EditNote.formKey.currentState?.validate()== true){
              task.title = titleController.text;
              task.desc = descriptionController.text;
              MyDataBase.editNote(editProvider.currentUser?.id ?? "", task);
              MyDataBase.getTasksRealTimeUpdate(editProvider.currentUser?.id ?? "");
              MyDataBase.getTasks(editProvider.currentUser?.id ?? "");
            }
          },
              icon: Icon(Icons.done_outlined,color: Theme.of(context).primaryColor,size: 30,))
        ],
      ),
      body: Container(
        color: Color(0xff171717),
        padding: EdgeInsets.all(12),
        child: Form(
          key: EditNote.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [

              SizedBox(
                child: NotesFormField(
                  expands: false,
                    maxline: 1,
                    hintText: null,
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
              SizedBox(height: 10,),

              Expanded(
                flex: 9,
                child: SizedBox(
                  child: NotesFormField(
                      hintText: null,
                      controller:descriptionController,
                      validator: (text) {
                        if (text == null || text
                            .trim()
                            .isEmpty) {
                          return 'Please Enter Note Description';
                        }
                        return null;
                      }),
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}
