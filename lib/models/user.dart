import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String type;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;

  UserModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.address,
      this.uid,
      this.email,
      this.type,
      this.password});

  factory UserModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    if (data == null) {
      return null;
    } else {
      return UserModel(
          uid: doc.id,
          firstName: doc['fname'],
          address: doc['address'],
          phoneNumber: doc['phone'],
          lastName: doc['lname'],
          email: doc['email'],
          type: doc['type']);
    }
  }
}
