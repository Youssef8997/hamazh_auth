import '../../utls/helper/crypto_helper.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: CryptoHelper().decrypt(inputString: json["name"]),
        email: CryptoHelper().decrypt(inputString: json["email"]),
        phone: CryptoHelper().decrypt(inputString: json["phone"]),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "name": CryptoHelper().encrypt(inputString: name),
        "email": CryptoHelper().encrypt(inputString: email),
        "phone": CryptoHelper().encrypt(inputString: phone),
      };
}
