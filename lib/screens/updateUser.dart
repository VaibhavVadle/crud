import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdateUsers extends StatefulWidget {
  const UpdateUsers({Key? key,required this.UserKey}) : super(key: key);

  final String UserKey;

  @override
  State<UpdateUsers> createState() => _UpdateUsersState();
}

class _UpdateUsersState extends State<UpdateUsers> {

  final _FormKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final namecontroller  = TextEditingController();

  late DatabaseReference dbRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Users');
    getUserData();
  }

  void getUserData() async{
    DataSnapshot snapshot = await dbRef.child(widget.UserKey).get();

    Map Users = snapshot.value as Map;

    namecontroller.text = Users['name'];
    emailcontroller.text = Users['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              key: _FormKey,
              child:Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(


                        labelText: "Name",
                        hintText: "Enter your name",
                      ),

                      controller: namecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      decoration: InputDecoration(


                        labelText: "Email",
                        hintText: "Enter your Email address",
                      ),

                      controller: emailcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email address';
                        }
                        return null;
                      },

                    ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Map<String,String> Users = {
                          'name':namecontroller.text,
                          'email':emailcontroller.text
                        };
                        dbRef.child(widget.UserKey).update(Users)
                        .then((value) => {
                          Navigator.pop(context)
                        });
                      },
                      child: Text('Save',style: TextStyle(fontSize: 16),)
                  )


                ],
              )
          ),
        ),

      ),
    );
  }
}
