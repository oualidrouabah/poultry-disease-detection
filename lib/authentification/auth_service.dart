import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a UserModel object based on User
  UserModel? _userFromFirebaseUser(User? user, {String? name, String? accountType}) {
    if (user != null) {
      return UserModel(
        uid: user.uid,
        email: user.email!,
        name: name ?? 'user',
        accountType: accountType ?? 'vit',
      );
    }
    return null;
  }

  // Auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user == null) {
        return null;
      }
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      return _userFromFirebaseUser(user, name: userDoc['name'], accountType: userDoc['accountType']);
    });
  }

  // Register with email and password
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Create a new user document in Firestore
        UserModel userModel = UserModel(
          uid: user.uid,
          email: email,
          name: name,
          accountType: 'user', // Default account type
        );
        await _firestore.collection('users').doc(user.uid).set(userModel.toMap());

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.message}');
      return null;
    } catch (e) {
      log('Exception: $e');
      return null;
    }
    return null;
  }

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Get user data from Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        return _userFromFirebaseUser(user, name: userDoc['name'], accountType: userDoc['accountType']);
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.message}');
      return null;
    } catch (e) {
      log('Exception: $e');
      return null;
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.message}');
      return;
    } catch (e) {
      log('Exception: $e');
      return;
    }
  }
}
