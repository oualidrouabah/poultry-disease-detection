import 'dart:convert';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String picture;
  final String phone;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.picture,
    required this.phone,
  });

  // Convert a UserModel object to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'picture': picture,
      'phone': phone,
    };
  }

  // Create a UserModel object from a map (e.g., Firestore document snapshot)
  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      picture: map['picture'],
      phone: map['phone'],
    );
  }

  // Convert a UserModel object to JSON string
  String toJson() => json.encode(toMap());

  @override
  String toString() => 'UserModel{uid: $uid, email: $email, name: $name, picture: $picture, phone: $phone}';
  
  String get userName => name;
  String get userEmail => email;
  String get userUid => uid;
  String get userPicture => picture;
  String get userPhone => phone;
  
  // Create a UserModel object from JSON string
  static UserModel fromJson(String source) => fromMap(json.decode(source));
  
  // Create a copy of UserModel with updated fields
  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? picture,
    String? phone,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      phone: phone ?? this.phone,
    );
  }
}
