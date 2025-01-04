import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../config/constants.dart';
import '../models/user_model.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<UserModel?> registerWithEmail({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user details in Firestore
      final userDoc = _db.collection(AppConstants.usersCollection).doc(userCred.user!.uid);
      await userDoc.set({
        'email': email,
        'name': name,
        'role': role,
      });

      // Construct the user model
      final userModel = UserModel(
        uid: userCred.user!.uid,
        email: email,
        name: name,
        role: role,
      );
      return userModel;
    } on FirebaseAuthException catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }

  static Future<UserModel?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Fetch user details from Firestore
      DocumentSnapshot userSnap = await FirebaseFirestore.instance
          .collection(AppConstants.usersCollection)
          .doc(userCred.user!.uid)
          .get();

      if (userSnap.exists) {
        return UserModel.fromMap(
          userSnap.data() as Map<String, dynamic>,
          userSnap.id,
        );
      } else {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static User? get currentUser => _auth.currentUser;
}