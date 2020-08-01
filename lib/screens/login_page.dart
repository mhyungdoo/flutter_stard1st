//로그인 페이지

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatelessWidget {


  static final String id = 'login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('STARD',
              style: TextStyle(fontSize: 60.0, color: Colors.cyan, fontWeight: FontWeight.bold,),

            ),

            Padding(
              padding: EdgeInsets.all(50.0),
            ),

            SignInButton(
                Buttons.Google, onPressed: () async {

                FirebaseAuth auth = FirebaseAuth.instance;
                GoogleSignIn googleSignIn = GoogleSignIn();
                GoogleSignInAccount account = await googleSignIn.signIn();
                GoogleSignInAuthentication authentication = await account.authentication;
                AuthCredential credential = GoogleAuthProvider.getCredential( idToken: authentication.idToken, accessToken: authentication.accessToken);
                AuthResult authResult = await auth.signInWithCredential(credential);
                FirebaseUser user = authResult.user;

           },



            )


          ],
        ),
      ),

    );
  }
}
