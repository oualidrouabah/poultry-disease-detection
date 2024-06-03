import 'dart:convert';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String accountType;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.accountType,
  });

  // Convert a UserModel object to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'accountType': accountType,
    };
  }

  // Create a UserModel object from a map (e.g., Firestore document snapshot)
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      accountType: map['accountType'],
    );
  }
  // Convert a UserModel object to JSON string
  String toJson() => json.encode(toMap());

  // Create a UserModel object from JSON string
  static UserModel fromJson(String source) => fromMap(json.decode(source));
}
