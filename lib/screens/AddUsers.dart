import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {

  final _myFormKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final namecontroller  = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState(){
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Users'),
        centerTitle: true,
      ),
        body:Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _myFormKey,
                child:Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(

                        controller: namecontroller,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            labelText:"Name",
                            hintText: "Enter your name",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,),
                              borderRadius : BorderRadius.circular(5.0),
                            )

                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                      child: TextFormField(

                        controller: emailcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText:"Email",
                            hintText: "Enter your Email address",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,),
                              borderRadius : BorderRadius.circular(5.0),
                            )

                        ),

                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){
                          Map<String,String> Users = {
                            'name':namecontroller.text,
                            'email':emailcontroller.text
                          };
                          dbRef.push().set(Users);
                        },
                        child: Text('Submit',style: TextStyle(fontSize: 16),)
                    )
                    

                  ],
                )
            ),
          ),

        )
    );
  }
}