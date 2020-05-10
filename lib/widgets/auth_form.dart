import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var isLogin = true;
  String _userName = '';
  String _email = '';
  String _password = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@'))
                        return 'Invalid email address';
                      return null;
                    },
                    onSaved: (val) {
                      _email = val.trim();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                  ),
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (val) {
                        if (val.isEmpty || val.trim().length < 3)
                          return 'Username is too short!';
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (val) {
                        _userName = val.trim();
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 7)
                        return 'Password must be at least 7 characters long';
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (val) {
                      _password = val;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  RaisedButton(
                    child: Text(isLogin ? 'Login' : 'Signup'),
                    onPressed: _trySubmit,
                  ),
                  FlatButton(
                    child: Text(isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
