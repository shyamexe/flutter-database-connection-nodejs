import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mpm/screen/search_page.dart';
import 'dart:convert';
import 'package:mpm/widgets/modeldata.dart';



class SerchUser extends StatefulWidget {
   SerchUser({Key? key}) : super(key: key);

  @override
  _SerchUserState createState() => _SerchUserState();
}

class _SerchUserState extends State<SerchUser> {

  List<Employee> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('sr DB',style: TextStyle(color: Colors.blue),),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search,color: Colors.blue,),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx)=> SearchPage(posts: _posts,)
              ));
            },
          )
        ],
      ),

      body: FutureBuilder(
        future: _getData(),
        builder: (ctx,snapshot){
          if(snapshot.connectionState ==  ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemBuilder: (ctx,i){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(_posts[i].name.toString()),
                    subtitle: Text(_posts[i].address.toString()),
                  ),
                  const Divider(height: 0,)
                ],
              );
            },
            
            itemCount: _posts.length,
          );
        },
      ),
    );
  }

  Future<void> _getData() async{
    var url = 'http://10.0.2.2:3000/list';
    http.get(Uri.parse(url)).then((data){
      return json.decode(data.body);
    }).then((data){
      for(var json in data[0]){
        _posts.add(Employee.fromJson(json));
      }
    }).catchError((e){
      print(e);
    });
  }
}