import 'dart:io';

import 'package:class11ddcontactapp/model/contact_model.dart';
import 'package:class11ddcontactapp/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName ='/details';
  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late int id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details'),
      ),
      body: Center(
        child: Consumer<ContactProvider>(
          builder: (context, provider, _)=>FutureBuilder<ContactModel>(
            future: provider.getContactByid(id),
            builder: (context,snapshot){
              if(snapshot.hasData){
                final model = snapshot.data;
                return ListView(
                  children: [
                    model!.image== null? Image.asset('images/person.png',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,):
                    Image.file(File(model!.image!),
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,)    //ternary operator
                  ],
                );
              }
              if(snapshot.hasError){
                return const Text('Failed to fetch data');
              }
              return const CircularProgressIndicator();
            },
              ),
        ),
      ),
    );
  }
}
