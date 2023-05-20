import 'package:class11ddcontactapp/auth_prefs.dart';
import 'package:class11ddcontactapp/page/contact_list_page.dart';
import 'package:class11ddcontactapp/page/login_page.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher_page';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LancherPageState();
}

class _LancherPageState extends State<LauncherPage> {
  @override
  void initState() {
    getLoginStatus().then((value) {
      if(value){
        Navigator.pushReplacementNamed(context, ContactList.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
