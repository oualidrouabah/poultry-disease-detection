import 'dart:developer';
import 'package:djaaja_siha/langage_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a UserModel object based on User
  UserModel? _userFromFirebaseUser(User? user, {String? name, String? picture, String? phone}) {
    if (user != null) {
      return UserModel(
        uid: user.uid,
        email: user.email!,
        name: name ?? '',
        picture: picture ?? '',
        phone: phone ?? '',
      );
    }
    return null;
  }

  // Auth change user stream
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().asyncMap((User? user) async {
      if (user == null) {
        return null;
      }
      try {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        return _userFromFirebaseUser(
          user, 
          name: userDoc['name'], 
          picture: userDoc['picture'], 
          phone: userDoc['phone']
        );
      } catch (e) {
        log('Error fetching user data: $e');
        return null;
      }
    });
  }

  // Register with email and password
  Future<UserModel?> createUserWithEmailAndPassword(String email, String password, String name, String picture, String phone) async {
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Create a new user document in Firestore
        UserModel userModel = UserModel(
          uid: user.uid,
          email: email,
          name: name,
          picture: picture,
          phone: phone,
        );
        await _firestore.collection('users').doc(user.uid).set(userModel.toMap());

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseCreateException: ${e.message}');
      return null;
    } catch (e) {
      log('Exception create: $e');
      return null;
    }
    return null;
  }

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      
      if (user != null) {
        // Get user data from Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        return _userFromFirebaseUser(
          user, 
          name: userDoc['name'], 
          picture: userDoc['picture'], 
          phone: userDoc['phone']
        );
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseSignInException: ${e.message}');
      return null;
    } catch (e) {
      log('Exception sign in: $e');
      return null;
    }
    return null;
  }

  // Sign in with Google
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In flow
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      final UserCredential result = await _firebaseAuth.signInWithPopup(googleProvider);
      final User? user = result.user;

      if (user != null) {
        // Check if user exists in Firestore, if not, create a new user
        final DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          // If user is new, create a new user document in Firestore
          final UserModel userModel = UserModel(
            uid: user.uid,
            email: user.email!,
            name: user.displayName ?? 'user',
            picture: user.photoURL ?? '',
            phone: '', // Default phone is empty
          );
          await _firestore.collection('users').doc(user.uid).set(userModel.toMap());
        }

        // Return UserModel
        return _userFromFirebaseUser(
          user, 
          name: user.displayName, 
          picture: user.photoURL, 
          phone: '' // Default phone is empty
        );
      }
    } on FirebaseAuthException catch (e) {
      log('FirebaseGoogleException: ${e.message}');
      return null;
    } catch (e) {
      log('Exception google: $e');
      return null;
    }
    return null;
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException: ${e.message}');
      return;
    } catch (e) {
      log('Exception: $e');
      return;
    }
  }

   // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      log('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      log('FirebaseResetPasswordException: ${e.message}');
    } catch (e) {
      log('Exception reset password: $e');
    }
  }
    // Change password
  Future<void> changePassword(context, String currentPassword, String newPassword) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        // Reauthenticate the user with the current password
        AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPassword);
        await user.reauthenticateWithCredential(credential);
        // Update the password
        await user.updatePassword(newPassword);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translation(context).changepasssucces)),
        );
      } on FirebaseAuthException catch (e) {
        log('FirebaseChangePasswordException: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translation(context).changepassfailed)),
        );
      } catch (e) {
        log('Exception change password: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(translation(context).changepassfailed)),
        );
      }
    } else {
      log('No user is currently signed in');
    }
  }
}
