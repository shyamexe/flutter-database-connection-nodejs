import 'dart:convert';

Employee employeeModelFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeModelToJson(Employee data) => json.encode(data.toJson());


class Employee {
    Employee({
        required this.name,
        required this.address,
    });

    String name;
    String address;

    factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
    };
}
