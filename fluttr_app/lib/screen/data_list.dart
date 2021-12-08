import 'package:flutter/material.dart';
import 'package:mpm/widgets/modeldata.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataList extends StatefulWidget {
  const DataList({ Key? key }) : super(key: key);

  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  Future<List<Employee>> _getEmployee() async{
    var empData=await http.get(Uri.parse('http://10.0.2.2:3000/list'));
    var jsonData=json.decode(empData.body);
    List<Employee> employees=[];
    for(var emp in jsonData[0])
    {
      Employee employee=Employee(name: emp['name'], address: emp['address']);
      employees.add(employee);
    }
    return employees;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Full DataBase",style: TextStyle(color: Colors.blue),),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: FutureBuilder(
            future: _getEmployee(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Container(
                  child: Center(child: Text("Loading..."),),
                );
              }else{
                return ListView.builder(
                  physics: const BouncingScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    return ListTile(

                      title:Text(snapshot.data[index].name),
                      subtitle:Text(snapshot.data[index].address),
                    );
                  },
                );
              }
            }
        ),

      ),

    );
  }
}
