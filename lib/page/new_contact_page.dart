import 'dart:io';

import 'package:class11ddcontactapp/db/db_helper.dart';
import 'package:class11ddcontactapp/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddContactPage extends StatefulWidget {
  static const String routeName = '/newContact';    
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  final nameController=TextEditingController();
  final numController =TextEditingController();
  final emailController =TextEditingController();
  final addressController = TextEditingController();
  final webController = TextEditingController();
  String? _dob;
  String? _genderGroupValue;
  String? _imagePath;
  ImageSource _imageSource=ImageSource.camera;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final formkey = GlobalKey<FormState>();


  @override
  void dispose() {
    nameController.dispose();
    numController.dispose();
    emailController.dispose();
    addressController.dispose();
    webController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact page'),
        actions: [
          IconButton(onPressed: _saveContactInfo, icon: Icon(Icons.save_alt))
        ],
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person)
              ),
              validator: (value){
                if(value == null|| value.isEmpty){
                  return 'this field must not be empty';
                }
                if(value.length>20){
                  return'Name must be in 20 careacter';
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: numController,
              decoration: InputDecoration(
                labelText: 'Number',
                prefixIcon: Icon(Icons.phone)
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'this field must not be empty';
                }
                if(value.length>15){
                  return'Use valide number';
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined)
              ),
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'Please enter your email address.';
                }
                if(!emailRegex.hasMatch(value)){
                  return'Please enter a valid email address.';
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 10,),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.add_location),
              ),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: webController,
              decoration: InputDecoration(
                labelText: 'Website Name',
                prefixIcon: Icon(Icons.web)
              ),
            ),
            SizedBox(height: 10,),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: _selectedDate, child: Text('Select Date of Birth')),
                  Text(_dob==null?'no Date Selected':_dob!)
                ],
              ),
            ),
            SizedBox(height: 10,),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Gender'),
                  Radio<String>(
                      value: 'Male',
                      groupValue: _genderGroupValue,
                      onChanged: (value){
                        setState(() {
                          _genderGroupValue=value;
                        });
                      }),
                  Text('Male'),
                  Radio<String>(
                      value: 'Female',
                      groupValue: _genderGroupValue,
                      onChanged: (value){
                        setState(() {
                          _genderGroupValue=value;
                        });
                      }),
                  Text('Female')
                ],
              ),
            ),
            SizedBox(height: 10,),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: _imagePath==null?Image.asset(
                      'images/person.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,):
                    Image.file(File(_imagePath!,),
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            _imageSource=ImageSource.camera;
                            _getImage();
                          },
                          child: Text('Camera')),
                      SizedBox(width: 20,),
                      ElevatedButton(
                          onPressed: (){
                            _imageSource=ImageSource.gallery;
                          },
                          child: Text('Gallery')),
                    ],
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }

  void _saveContactInfo() async{
    if(formkey.currentState!.validate()){

      final contact = ContactModel(
        name: nameController.text,
        number: numController.text,
        email: emailController.text,
        address: addressController.text,
        website: webController.text,
        dob: _dob,
        gender: _genderGroupValue,
        image: _imagePath,

      );
      print(contact.toString());
      final rowId = await DbHelper.insertContact(contact);
      if(rowId>0){
        contact.id = rowId;
        Navigator.pop(context);
      }else{

      }
    }
  }

  void _selectedDate() async{
    final selectedDate= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now()
    );
    if(selectedDate !=null){
      setState(() {
        _dob=DateFormat('dd/MM/yyyy').format(selectedDate);

      });
    }
  }

  void _getImage() async {
    final selectedImage= await ImagePicker().pickImage(source: _imageSource);
    if(selectedImage!=null){
      setState(() {
        _imagePath=selectedImage.path;
      });
    }
  }
}


