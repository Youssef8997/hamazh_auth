class UserModel {
  final String id;
  final String name;
  final String email;
  final String pass;
  final String bioMetric;
  final String phone;
  final String image;

  UserModel(
      {required this.id, required this.name, required this.email, required this.pass, required this.bioMetric, required this.phone, required this.image});

  factory UserModel.fromJson(Map<String, dynamic>json)=>
      UserModel(id: json["id"],
          name: json["name"],
          email: json["email"],
          pass: json["pass"],
          bioMetric: json["bioMetric"],
          phone: json["phone"],
          image: json["image"]);
  Map toMap()=>{
  "id":id,
  "name":name,
  "email":email,
  "pass":pass,
  "bioMetric":bioMetric,
  "phone":phone,
  "image":image,
  };
}

