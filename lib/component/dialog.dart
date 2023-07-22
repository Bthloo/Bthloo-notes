import 'package:flutter/material.dart';

class DialogUtilities{
  static void  ShowLoadingDialog(BuildContext context,String message){
     showDialog(context: context,
        builder: (BuildContext){
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10,),
            Text(message)
          ],
        ),
      );
        },
        barrierDismissible: false
    );
  }

  static void hideDialog(BuildContext context){
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context,String message,
      {String? posstiveActionName,
    VoidCallback? posstiveAction,
    String? nigaiveActionName,
    VoidCallback? nigaiveAction,
        bool dismissible = true
  }){
    List<Widget> actions =[];
    if(posstiveActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posstiveAction?.call();
      },
          child: Text(posstiveActionName)
      )
      );
    }
    if(nigaiveActionName != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        nigaiveAction?.call();
      },
          child: Text(nigaiveActionName)
      )
      );
    }
    showDialog(context: context,

        builder: (BuildContext){
          return AlertDialog(
            content:  Text(message),
            actions: actions,
          );
        },
    );
  }
}