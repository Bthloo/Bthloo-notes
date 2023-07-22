// import 'package:flutter/material.dart';
//
// class NotesTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//     );
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/task_item.dart';
import '../database/my_database.dart';
import '../database/task.dart';
import '../providers/auth_provider.dart';

class TodosListTab extends StatefulWidget {
  @override
  State<TodosListTab> createState() => _TodosListTabState();
}

class _TodosListTabState extends State<TodosListTab> {

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    return Container(
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot<Task>>(
                stream: MyDataBase.getTasksRealTimeUpdate(

                    authProvider.currentUser?.id ?? ""),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // finished
                  var tasksList =
                  snapshot.data?.docs.map((doc) => doc.data()).toList();
                  if (tasksList?.isEmpty == true) {
                    return Center(
                      child: Text("You don't have any Notes yet",
                      style: TextStyle(
                        color: Color(0xffEDEDED),
                        fontSize: 20
                      ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return TaskItem(tasksList![index]);
                    },
                    itemCount: tasksList?.length ?? 0,
                  );
                },
              ))
        ],
      ),
    );
  }
}
