import 'dart:developer';

import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/core/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthenticationUtils{
 static Future<bool> createUserWithEmailAndPassword({required emailAddress, required password})
 async{
   try {
     final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: emailAddress,
       password: password,
     );
     
     log(credential.user!.uid);

     SnackBarService.showSuccessMessage("Account Created Successfully");
     
     return Future.value(true);
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('The password provided is too weak.');
       SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
       SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
     }
     return Future.value(false);
   } catch (e) {
     SnackBarService.showErrorMessage( "Something went wrong");
     print(e);
     return Future.value(false);
   }
 }

 static Future<bool> signInWithEmailAndPassword(
 {required emailAddress, required password}
     ) async{
   try {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: emailAddress,
         password: password
     );
     SnackBarService.showSuccessMessage("Logged In Successfully");
     return Future.value(true);
   } on FirebaseAuthException catch (e) {

     log(e.code);
     if (e.code == 'user-not-found') {
       SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
       print('No user found for that email.');
     } else if (e.code == 'invalid-credential') {
       SnackBarService.showErrorMessage(e.message ?? "Something went wrong");
       print('Wrong password provided for that user.');
     }
     return Future.value(false);
   }
   catch(e){
     print(e);
     SnackBarService.showErrorMessage("Something went wrong");
     return Future.value(false);
   }
 }
 static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
 static Future<UserCredential?> signInWithGoogle() async {
   try{
     await _googleSignIn.initialize(
       serverClientId: dotenv.env['SERVER_CLIENT_ID']
     );

     final GoogleSignInAccount result = await _googleSignIn.authenticate();
     final googleAuth = result.authentication;
     final credentials = GoogleAuthProvider.credential(
       idToken: googleAuth.idToken
     );
     return await FirebaseAuth.instance.signInWithCredential(credentials);
   }
   catch (e){
     print("Google sign-in error $e");
     return null;
   }
 }

 static Future<void> loginWithGoogle(BuildContext context) async{
   try{
     await signInWithGoogle();
     SnackBarService.showSuccessMessage("Logged In Successfully");
     Navigator.of(context).pushNamed(PageRouteName.layout);
   }
   catch (e){
     SnackBarService.showErrorMessage(e.toString());
   }
 }
}