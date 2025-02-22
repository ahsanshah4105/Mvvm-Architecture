import 'package:flutter/material.dart';
import 'package:mvvm_architecture/utils/Colors.dart';
import 'package:mvvm_architecture/utils/Common_Toast.dart';
import 'package:mvvm_architecture/view_model/Login_Provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Map args;

  LoginScreen({super.key, required this.args});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String name = "";
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.args.containsKey('title')) {
      name = widget.args['title']; // Corrected name assignment
    }
  }

  @override
  Widget build(BuildContext context) {

    final logInProvider = Provider.of<LogInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: darkBlue,
        title: Text(name,style: TextStyle(color: white),),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
              hintText: "Enter Email"
            ),
          ),
          const SizedBox(height: 10,),
          TextFormField(
            controller: password,
            decoration: const InputDecoration(
                hintText: "Enter Password"
            ),
          ),
          const SizedBox(height: 30,),
          SizedBox(
            height: 50,width: double.infinity,
              child: ElevatedButton(onPressed: (){
                if(email.text.isEmpty){
                  CustomToast.show(context, "Please enter email");
                }
                else if(password.text.isEmpty){
                  CustomToast.show(context, "Please enter password");
                }
                else{
                  Map data = {
                    "email": email.text.toString(),
                    "password": password.text.toString()
                  };
                  logInProvider.userLogin(context, data);
                }

              },style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                foregroundColor: white
              ), child: logInProvider.isLoading?CircularProgressIndicator(color: white,): const Text('Login')),
          )
        ],
      ))
    );
  }
}
