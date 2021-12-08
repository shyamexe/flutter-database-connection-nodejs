import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mpm/screen/add_user.dart';
import 'package:mpm/screen/data_list.dart';
import 'package:mpm/screen/search_user.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        onTap: (index){
          print('clicked tab $index+1');
          

        },
        items:const  [
           BottomNavigationBarItem(
            label: 'DataBase',
            icon: Icon(CupertinoIcons.doc_circle)),
            BottomNavigationBarItem(
            label: 'Serch',
            icon: Icon(CupertinoIcons.search_circle)),
            BottomNavigationBarItem(
            label: 'Add',
            icon: Icon(CupertinoIcons.add_circled)),

        ]), tabBuilder: (
          BuildContext context, int index) { 
            switch(index){
              case 0:
                return DataList(); 
              case 1:
                return SerchUser();
              default:
                
                return AddUser();
              
            }
           },
    );
  }
}