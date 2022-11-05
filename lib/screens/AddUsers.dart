import 'package:crud/providers/addUser_provider.dart';
import 'package:crud/screens/homepage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {

  final _myFormKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final namecontroller  = TextEditingController();

  late AddUserProvider _addUserProvider;
  late DatabaseReference dbRef;


  @override
  void initState(){
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');

  }


  @override
  Widget build(BuildContext context) {
    _addUserProvider = Provider.of<AddUserProvider>(context);
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
                        onChanged: _addUserProvider.validateName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          else if (value.isValidName){
                            return 'Please enter a valid name';
                          }

                        },
                        decoration: InputDecoration(
                            labelText:"Full Name",
                            errorText: _addUserProvider.name.error,
                            hintText: "Enter your full name",
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
                        onChanged: _addUserProvider.validateEmail,

                        validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter a valid email address'
                            : null,


                        decoration: InputDecoration(
                            errorText: _addUserProvider.email.error,
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
                          if (_myFormKey.currentState!.validate()) {
                            Map<String,String> Users = {
                              'name':namecontroller.text,
                              'email':emailcontroller.text
                            };
                            dbRef.push().set(Users);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => HomePage(),
                              ),
                            );
                          }

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