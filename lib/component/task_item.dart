import 'package:bnotes/component/dialog.dart';
import 'package:bnotes/home/edit_notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../database/my_database.dart';
import '../database/task.dart';
import '../providers/auth_provider.dart';
class TaskItem extends StatefulWidget {

  Task task;
  TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .25,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed:(buildContext){
                deleteTask();
              },
              icon: Icons.delete,
              backgroundColor: Color(0xffDA0037),
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft:  Radius.circular(18),
              ),

            )
          ],
        ),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, EditNote.routeName,arguments: widget.task);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xffEDEDED), borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Theme.of(context).primaryColor),
                  width: 8,
                  height: 70,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.task.title}',
                          style: TextStyle(
                              fontSize: 18, color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 18,),
                        Text('${widget.task.desc}',
                        maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTask(){
    DialogUtilities.showMessage(context, 'Do you want to delete this Note?',
        posstiveActionName: 'Yes',
        posstiveAction: (){
          deleteTaskFromDataBase();
        },
        nigaiveActionName: 'Cancel',
    );
  }
  void deleteTaskFromDataBase()async{
    var authProvider = Provider.of<AuthProvider>(context,listen: false);
    try{
      await MyDataBase.deleteTask(authProvider.currentUser?.id??"",
          widget.task.id??"");
      Fluttertoast.showToast(
          msg: "Note deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }catch(e){
      DialogUtilities.showMessage(context, 'something went wrong,'
          '${e.toString()}',);
    }
  }
}