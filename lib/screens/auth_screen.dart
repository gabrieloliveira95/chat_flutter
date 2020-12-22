import 'package:chat_flutter/models/auth_data.dart';
import 'package:chat_flutter/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Future<void> _handleSubmmit(AuthData authData) async {
    setState(() {
      isLoading = true;
    });
    AuthResult authResult;
    try {
      if (authData.isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: authData.email.trim(),
          password: authData.password,
        );
        final userData = {
          'name': authData.name,
          'email': authData.email,
        };
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData(userData);
      }
    } on PlatformException catch (e) {
      final msg = e.message ?? 'Verify your Credentials';
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      print(msg);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      //body: AuthForm(_handleSubmmit),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                AuthForm(_handleSubmmit),
                if (isLoading)
                  Positioned.fill(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
