import 'package:class11ddcontactapp/auth_prefs.dart';
import 'package:class11ddcontactapp/page/login_page.dart';
import 'package:class11ddcontactapp/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_details_page.dart';
import 'new_contact_page.dart';

class ContactList extends StatefulWidget {
  static const String routeName = 'contactListPage';
  const ContactList({Key? key}) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  int selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context)=>[
                PopupMenuItem(
                  onTap: (){
                    setLoginStatus(false).then((value) =>
                        Navigator.pushReplacementNamed(
                            context, LoginPage.routeName));
                  },
                  child: const Text('Logout'),
                )
              ])
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        child: Consumer<ContactProvider>(
          builder: (context,provider,_)=> BottomNavigationBar(
            currentIndex: selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: (value){
              setState(() {
                selectedIndex = value;
              });
              if(selectedIndex==0){
                provider.getAllContacts();
              }else if(selectedIndex==1){
                provider.getAllFavoriteContacts();
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'All Contacts'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites')
            ],
          ),
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context,provider,_)=>ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context,index){
            final contact = provider.contactList[index];
            return Dismissible(
              key: ValueKey(contact.id),
              direction: DismissDirection.endToStart,
              confirmDismiss: _showConfirmationDialog,
              onDismissed: (direction){
                provider.deleteContact(contact.id!);
              },
              background: Container(
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete,size: 40,),
              ),
              child: ListTile(
                onTap: ()=> Navigator
                    .pushNamed(
                    context, ContactDetailsPage.routeName,arguments: contact.id),
                title: Text(contact.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                trailing: IconButton(
                  icon: Icon(contact.isfavorite?Icons.favorite : Icons.favorite_border),
                  onPressed: (){
                    provider.updateFavorite(contact.id!, contact.isfavorite, index);

                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AddContactPage.routeName);
        },
        child: Icon(Icons.add),
        tooltip: 'Add new Contact',
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Contact'),
          content: const Text('Are you sure to delete this contac'),
          actions: [
            TextButton(
                onPressed: ()=> Navigator.pop(context,false),
                child: Text('NO'),),
            TextButton(
                onPressed: ()=>Navigator.pop(context,true),
                child: Text('Yes'))
          ],
    ));
  }
}
