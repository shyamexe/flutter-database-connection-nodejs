import 'package:flutter/material.dart';
import 'package:mpm/widgets/modeldata.dart';

import 'package:http/http.dart' as http;


class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

Future<Employee?> createEmployee(String name, String address) async{
  const String apiUrl = "http://10.0.2.2:3000/add";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "name": name,
    "address": address
  });

  if(response.statusCode == 201){
    final String responseString = response.body;

    return employeeModelFromJson(responseString);
  }else{
    return null;
  }
}

class _AddUserState extends State<AddUser> {

  Employee? _empo;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Company to PmjDb'),
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[

            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Company name',
                icon: Icon(Icons.computer_rounded)
              ),
              controller: nameController,
            ),

            TextField(
              decoration: const InputDecoration(
                  hintText: 'Enter Company place',
                  icon: Icon(Icons.place)
              ),
              controller: addressController,
            ),


            const SizedBox(height: 50,),

            RaisedButton(
                child: const Text("Add to DB", style: TextStyle(color: Colors.red, fontSize: 16),),
              onPressed: () async{
                final String name = nameController.text;
                final String address = addressController.text;

                final Employee? empo = await createEmployee(name, address);

                setState(() {
                  _empo = empo;
                });

              },),


            _empo == null ? Container() :
            Text("The user ${_empo!.name}, ${_empo!.address}"),

          ],
        ),
      ),

    );
  }
}