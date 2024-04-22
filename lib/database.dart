import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  //add
  Future addEmployeeDetails(
      Map<String, dynamic>employeeInfoMap, String id) async
  {return await FirebaseFirestore.instance
      .collection("Employee")
      .doc(id)
      .set(employeeInfoMap);
  }
  ///get
  Future <Stream<QuerySnapshot>>getEmployeeDetails()async{
   return await FirebaseFirestore.instance.collection("Employee").snapshots();

  }
  //delete
     Future deleteData(String id) async{
     return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();
  }
  ///update
Future editEmployeeDetails(String id,Map<String,dynamic>UpdateData)async{
  return await FirebaseFirestore.instance.collection("Employee").doc(id).update(UpdateData);

}
 
}