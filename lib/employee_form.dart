import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import 'database.dart';
class EmployeeForm extends StatefulWidget {
  EmployeeForm({super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
  
}

class _EmployeeFormState extends State<EmployeeForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroller= TextEditingController();
  TextEditingController agecontroller =  TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController emailcontroller =TextEditingController();
  TextEditingController phonecontroller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Employee",
              style:TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25)),
            Text("Form",
                style:TextStyle(color: Colors.orange, fontWeight: FontWeight.bold , fontSize: 25)),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin:const EdgeInsets.fromLTRB(5, 20, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Name:",
                    style:TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25)
                    
                ),
                const SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(border: Border.all() ,borderRadius:BorderRadius.circular(15) ),
                  child: TextFormField(
                    controller: namecontroller,
                      decoration: const InputDecoration(border: InputBorder.none),
                       validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                  ),
                ),
                const SizedBox(height: 5),
                const Text("Age:",
                    style:TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25)
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(border: Border.all(),borderRadius:BorderRadius.circular(15) ),
                  child: TextField(
                    controller: agecontroller,
                    
                    decoration:const  InputDecoration(border: InputBorder.none),
                 
                  ),
                ),
                const SizedBox(height: 5),
                const Text("Location:",
                    style:TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25)
                ),
                const SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(border: Border.all() ,borderRadius:BorderRadius.circular(15)),
                  child: TextFormField(
                    controller: locationcontroller,
                      decoration: const InputDecoration(border: InputBorder.none),
                       validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
                  ),
                ),
                const SizedBox(height: 5),
                const Text("Email:" ,
                    style:TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25)
                ),
               const  SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(border: Border.all(),borderRadius:BorderRadius.circular(15) ),
                  child: TextFormField(
                    controller: emailcontroller,
                      decoration: const InputDecoration(border: InputBorder.none),
                       validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                  ),
                ),
                const SizedBox(height: 5),
                    
                const Text("Phone:",
                    style:TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 25)
                ),
                Container(
                  decoration: BoxDecoration(border: Border.all(),borderRadius:BorderRadius.circular(15) ),
                  child: TextFormField(
                    controller: phonecontroller,
                      decoration: const InputDecoration(border: InputBorder.none),
                       validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone';
                  }
                  return null;
                },
                  ),
                ),
                const SizedBox(height: 5),
                Center(child:ElevatedButton(
                  onPressed: () async{
                     if (_formKey.currentState!.validate()) {
                       String id= randomAlphaNumeric(10);
                  Map<String, dynamic>employeeInfoMap={
                    "Name":namecontroller.text,
                    "Age":agecontroller.text,
                    "Location":locationcontroller.text,
                    "Email":emailcontroller.text,
                    "Phone":phonecontroller.text,
                    "id":id
                  } ;
                  await DatabaseMethods().addEmployeeDetails(employeeInfoMap,id).then((value) => {
                  Fluttertoast.showToast(
                  msg: "Employee added successfull",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
                  )
                  });
                     }
                 
                    
                    
                }, child:const  Text("Add",
                    style:TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 25)
                )))
              ],
            ),
          ),
        ),
      ),
    )
    ;
  }
}
