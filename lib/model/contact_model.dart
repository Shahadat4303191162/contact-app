const String tableContact='tbl_contact';
const String tableContactColId ='id';
const String tableContactColName ='name';
const String tableContactColNumber ='number';
const String tableContactColEmail ='email';
const String tableContactColAddress ='address';
const String tableContactColWebsite ='website';
const String tableContactColDob ='dob';
const String tableContactColGender ='gender';
const String tableContactColImage ='image';
const String tableContactColFav ='isfavorite';

class ContactModel {
  int? id;
  String name;
  String number;
  String? email;
  String? address;
  String? website;
  String? dob;
  String? gender;
  String? image;
  bool isfavorite;

  ContactModel(
      {
      this.id,
      required this.name,
      required this.number,
      this.email,
      this.address,
      this.website,
      this.dob,
      this.gender,
      this.image,
      this.isfavorite=false});

  Map<String,dynamic> toMap(){   //to Map holo ekta method ja map return konbe
    var map =<String,dynamic>{
      tableContactColName:name,
      tableContactColNumber:number,
      tableContactColEmail:email,
      tableContactColAddress:address,
      tableContactColWebsite:website,
      tableContactColDob:dob,
      tableContactColGender:gender,
      tableContactColImage:image,
      tableContactColFav:isfavorite?1:0,
      //sqflite kono bool value support kore na,tai bool value ke integer e convarte korbo.....(isfavorite?1:0) timary oparetor
    };
    if(id!=null){
      map[tableContactColId]= id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String,dynamic>map)=>ContactModel(
    id: map[tableContactColId],
    name: map[tableContactColName],
    number: map[tableContactColNumber],
    email: map[tableContactColEmail],
    address: map[tableContactColAddress],
    website: map[tableContactColWebsite],
    dob: map[tableContactColDob],
    gender: map[tableContactColGender],
    image: map[tableContactColImage],
    isfavorite: map[tableContactColFav]==1?true:false,
  );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, number: $number, email: $email, address: $address, website: $website, dob: $dob, gender: $gender, image: $image, isfavorite: $isfavorite}';
  }
}
