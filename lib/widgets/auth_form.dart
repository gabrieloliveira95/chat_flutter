import 'package:chat_flutter/models/auth_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmmit;

  AuthForm(this.onSubmmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  void _subbmit() {
    bool isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      widget.onSubmmit(_authData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_authData.isSignUp)
                  TextFormField(
                    key: ValueKey('name'),
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) => _authData.name = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 4)
                        return 'Must Contain 4 ';
                      return null;
                    },
                  ),
                TextFormField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(labelText: 'Email'),
                  onChanged: (value) => _authData.email = value,
                  validator: (value) {
                    if (value == null || !value.contains('@'))
                      return 'Invalid Email';
                    return null;
                  },
                ),
                TextFormField(
                  key: ValueKey('pass'),
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Password'),
                  onChanged: (value) => _authData.password = value,
                  validator: (value) {
                    if (value == null || value.trim().length < 7)
                      return 'Password Must Contain 7 ';
                    return null;
                  },
                ),
                SizedBox(height: 12),
                RaisedButton(
                  child: Text(_authData.isLogin ? 'Login' : 'SignUp'),
                  onPressed: _subbmit,
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    _authData.isLogin ? 'Create Account' : 'Already Logged?',
                  ),
                  onPressed: () {
                    setState(() {
                      _authData.toogleMode();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
