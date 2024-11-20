import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:kyn_2/core/constants/constants.dart';
import 'package:kyn_2/core/failure.dart';
import 'package:kyn_2/core/providers/firebase_providers.dart';
import 'package:kyn_2/core/type_defs.dart';
import 'package:kyn_2/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Stream<UserModel> getUserData(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureEither<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userDoc = await getUserData(response.user!.uid).first;

      return right(userDoc);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? "An unknown error occurred."));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = UserModel(
        uid: response.user!.uid,
        name: name,
        email: email,
        profilePic: Constants.avatarDefault,
        isAuthenticated: true,
        karma: 0,
        banner: Constants.avatarDefault,
        userType: UserType.admin,
      );

      await creatingUserinDB(userModel);

      return right(userModel);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? "An unknown error occurred."));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future creatingUserinDB(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toMap());
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message ?? "An unknown error occurred."));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
  }
}
