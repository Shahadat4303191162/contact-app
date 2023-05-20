 import 'package:class11ddcontactapp/db/db_helper.dart';
import 'package:flutter/foundation.dart';

import '../model/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList=[];

  getAllContacts() async{
    contactList = await DbHelper.getAllContacts();
    notifyListeners();
  }

  getAllFavoriteContacts() async{
    contactList = await DbHelper.getAllFavoriteContacts();
    notifyListeners();
  }
  Future<ContactModel> getContactByid(int id) =>DbHelper.getContactByid(id);
  Future<bool>InsertContact(ContactModel contactModel) async{
    final rowId = await DbHelper.insertContact(contactModel);
    if(rowId >0){
      contactModel.id =rowId;
      contactList.add(contactModel);
      contactList.sort((c1,c2) => c1.name.compareTo(c2.name));
      notifyListeners();
      return true;
    }
    return false;
  }
  updateFavorite(int id,bool favorite,int index) async{
    final value = favorite ? 0:1;
    final rowId = await DbHelper.updateFavorite(id, value);
    if(rowId>0){
      contactList[index].isfavorite = !contactList[index].isfavorite;
      notifyListeners();
    }
  }
  deleteContact(int id)async{
    final deletedRowId = await DbHelper.deleteContact(id);
    if(deletedRowId>0){
      contactList.removeWhere((element) => element.id== id);
      notifyListeners();
    }
  }

}