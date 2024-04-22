import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee_database/database.dart';
import 'package:flutter/material.dart';
import 'package:employee_database/employee_form.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream? EmployeeStream;
  TextEditingController namecontroller= TextEditingController();
  TextEditingController agecontroller =  TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController emailcontroller =TextEditingController();
  TextEditingController phonecontroller =TextEditingController();
  
   getOnLoad()async{
    EmployeeStream =await DatabaseMethods().getEmployeeDetails();
    setState(() {});
   }
   @override
  void initState() {
    getOnLoad();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton( onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>EmployeeForm()));
      }, child:Icon(Icons.add ,color: Colors.orange,size: 35,) ,backgroundColor:Colors .blue,),
      appBar: AppBar(
        backgroundColor: Colors.white54,
        elevation: 0.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("Employee",
        style: TextStyle(color:Colors.blue  ,fontWeight: FontWeight.bold, fontSize: 25),
        ),
        Text("Details",
        style: TextStyle(color:Colors.orange  ,fontWeight: FontWeight.bold, fontSize: 25),
        ),
          ],),  
        centerTitle: true,
      ),
      body: Container(
      child: StreamBuilder(
      stream: EmployeeStream, 
      builder: (context,AsyncSnapshot snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        else if(snapshot.hasError){
          return const Center(child: Text("Error while fetching data"));
        }
        else if(snapshot.hasData) {
           return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot data= snapshot.data.docs[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                shadowColor: Colors.pink,
                elevation: 7,
                      child: Container(
                        child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(30))),
                    child:Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text("Name:"+data["Name"], style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18),),
                              const SizedBox(height: 4,),
                              Text("Email:"+data["Email"],style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18)),
                              const SizedBox(height: 4,),
                              Text("Phone:"+data["Phone"],style: const TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 18)),
                              const SizedBox(height: 4,),
                              Text("location:"+data["Location"],style: const TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 18)),
                              const SizedBox(height: 4,),
                              Text("Age:"+data["Age"],style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 18)),
                            ],
                          ),
                          const SizedBox(width: 5),
                           Column(
                             children: [
                               IconButton(onPressed: ()async{
                                   await DatabaseMethods(). deleteData(data["id"]).then((value) {
                                 Fluttertoast.showToast(
                  msg: "Employee details deleted",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
                  );
                                     
                                   });
                                  }, icon: const Icon(Icons.delete, size: 30,color: Colors.red,)),
                                  const SizedBox(height: 20,),
                                  IconButton(onPressed: ()
                                  {
                                    namecontroller.text=data["Name"];
                                    emailcontroller.text=data["Email"];
                                    phonecontroller.text=data["Phone"];
                                    locationcontroller.text=data["Location"];
                                    agecontroller.text=data["Age"];

                                    editEmployeeDetails("id");}, 
                                  icon: const Icon(Icons.edit,size: 30,color: Colors.green,))
                             ],
                           )
                        ], ),),),)],),),),);},);}
        else{
          return const Text("Database is empty");
        }} ),));}
  ///Edit dialog container
Future editEmployeeDetails(String id)=>showDialog(
  context: context,
   builder: (context) => AlertDialog(
    content: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child:SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:const  Icon(Icons.cancel,size: 40,color: Colors.black,)),
                     const SizedBox(width: 30,),
                          const Text("Edit",
                style: TextStyle(color:Colors.blue  ,fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const Text("Details",
                style: TextStyle(color:Colors.orange  ,fontWeight: FontWeight.bold, fontSize: 25),
                ),
   
                    ],
                  ),
                   Container(
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
                              decoration: const InputDecoration(border: InputBorder.none)
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
                            decoration:const  InputDecoration(border: InputBorder.none)
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
                              decoration: const InputDecoration(border: InputBorder.none)
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
                              decoration: const InputDecoration(border: InputBorder.none)
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
                              decoration: const InputDecoration(border: InputBorder.none)
                          ),),],
              ), ),),] ),)),
            Material(
              elevation: 4,
              borderRadius:BorderRadius.circular(15),
              shadowColor: Colors.blue,
              child: TextButton(onPressed: ()async{
                Map<String,dynamic>UpdateData={
                  "Name":namecontroller.text,
                  "Email":emailcontroller.text,
                  "Phone":phonecontroller.text,
                  "Location":locationcontroller.text,
                  "Age":agecontroller.text,
                  "id":id,

                };
                await DatabaseMethods().editEmployeeDetails(id, UpdateData).then((value) {
                  Navigator.pop(context);
                },);
              }, 
              child: const Text("Update",
              style:TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 25))))
             ,const SizedBox(height: 7,)
        ],
      ),)));

      }



