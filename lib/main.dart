import 'package:class11ddcontactapp/page/contact_details_page.dart';
import 'package:class11ddcontactapp/page/contact_list_page.dart';
import 'package:class11ddcontactapp/page/new_contact_page.dart';
import 'package:class11ddcontactapp/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>ContactProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ContactList.routeName,
      routes: {
        ContactList.routeName:(context) => ContactList(),
        AddContactPage.routeName:(context) =>AddContactPage(),
        ContactDetailsPage.routeName:(context) =>ContactDetailsPage(),

      },
    );
  }
}


