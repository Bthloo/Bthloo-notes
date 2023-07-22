import 'package:flutter/material.dart';
import '../component/info_buttom_sheet.dart';
import '../settings/settings.dart';
import 'buttom_sheet.dart';
import 'notes_tab.dart';

class HomeScreen extends StatefulWidget {
static const String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                showinfoSheet();
              },
              icon: Icon(Icons.info_outline,color: Theme.of(context).primaryColor,))
        ],
        backgroundColor:const Color(0xff171717),
        elevation: 0,
        title: Text('Bthloo Notes',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape:const StadiumBorder(
            side: BorderSide(
                color: Color(0xffEDEDED),
                width: 3
            )
        ),
        onPressed: () {
          showAddTaskSheet();
        },
        child: const Icon(Icons.add,size: 30,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft:  Radius.circular(22),topRight:Radius.circular(20) ),
        child: BottomAppBar(
          color:  const Color(0xffEDEDED),
          height: 65,
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(

            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (index){

              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
               BottomNavigationBarItem(icon: Icon(Icons.list_outlined,),label: 'Notes'),
              BottomNavigationBarItem(icon: Icon(Icons.settings,),label: 'Settings'),
            ],

          ),
        ),
      ),
     body:tabs[selectedIndex],

    );
  }

List<Widget> tabs = [
  TodosListTab(),
  SettingsTab(),
];

void showAddTaskSheet(){
  showModalBottomSheet(
      isScrollControlled:true,
      context: context,
      builder: (BuildContext){
    return AddTaskButtomSheet();
  });

}

  void showinfoSheet(){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled:false,
        context: context,
        builder: (BuildContext){
          return InfoButtomSheet();
        });
  }
  }

