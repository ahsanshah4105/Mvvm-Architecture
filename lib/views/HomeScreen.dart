import 'package:flutter/material.dart';
import 'package:mvvm_architecture/%20Models/Services/Api_Response.dart';
import 'package:mvvm_architecture/appStore/App_Store.dart';
import 'package:mvvm_architecture/routes/routesNames.dart';
import 'package:mvvm_architecture/utils/Colors.dart';
import 'package:mvvm_architecture/view_model/User_List_Provider.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  UserListProvider userListProvider = UserListProvider();

  @override
  void initState() {
    userListProvider.fetchUserList(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: darkBlue,
        title: Text('Home Screen',style: TextStyle(color: white),),
        actions: [
          IconButton(onPressed: (){
            AppStore().removeToke();
            Navigator.pushReplacementNamed(
              context,
              RouteName.logInScreen,
              arguments: {'title': 'Login'},
            );
          }, icon: Icon(Icons.logout, color: white,))
        ],
      ),
      body: ChangeNotifierProvider(create: (BuildContext context) => userListProvider,
      child: Consumer<UserListProvider>(builder: (context,value, _){
        switch(value.userList.status){

          case Status.loading:
            return Center(child: CircularProgressIndicator(color: darkBlue,),);
          case Status.error:
            return Center(
              child: Text(value.userList.message.toString()),
            );

          case Status.complete:
            return ListView.builder(
                itemCount: value.userList.data!.data!.length,
                  itemBuilder: (context, index){
                  final data = value.userList.data!.data![index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data.avatar.toString()),
                      ),
                      title: Text(data.firstName.toString()),
                      subtitle: Text(data.email.toString()),
                    ),
                  );
            });

          default:
        }
        return const SizedBox();
      },),),
    );
  }
}
