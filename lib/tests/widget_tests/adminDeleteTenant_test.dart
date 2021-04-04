import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:singhealth_app/Pages/adminAddTenant.dart';
import 'package:singhealth_app/Pages/adminHome.dart';
import 'package:singhealth_app/setup/signIn.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebaseAuthMocks.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';

class MockFirestore extends Mock implements FirebaseFirestore{}


void main() {

  dynamic data;
  final instance = MockFirestoreInstance();
  instance.collection("admin").doc("s8vuQ4OeYhOyAmLRK4o3ejXuMnG3").set({
    'email' : "admin@test.com",
    'id' : "s8vuQ4OeYhOyAmLRK4o3ejXuMnG3",
    'institution' : "CGH",
    'name' : "Admin",
  });

  instance.collection("admin").doc("s8vuQ4OeYhOyAmLRK4o3ejXuMnG3").get().then<dynamic>((DocumentSnapshot snapshot){
    data = snapshot.data();
  });

  final user = MockUser(isAnonymous: false,
      uid: "s8vuQ4OeYhOyAmLRK4o3ejXuMnG3",
      email: "admin@test.com",
      displayName: "Admin"
  );

  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  //test successful deletion of tenant


}