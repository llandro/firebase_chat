import 'dart:io';
import 'package:firebasechat/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitAuthForm;
  final bool isLoading;
  AuthForm(
    this.submitAuthForm,
    this.isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var isLogin = true;
  String _userName = '';
  String _email = '';
  String _password = '';
  File _pickedImage;

  void _pickImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && !isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick an image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitAuthForm(
        _email,
        _password,
        _userName,
        _pickedImage,
        isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: isLogin ? 300 : 490,
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
                    if (!isLogin) UserImagePicker(_pickImage),
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
                        _password = val.trim();
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    widget.isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(
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
      ),
    );
  }
}
