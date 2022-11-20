// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../../manager/auth_manager.dart';

import '../share/dialog.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        await context.read<AuthManager>().login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await context.read<AuthManager>().register(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } catch (error) {
      showErrorDialog(
        context,
        (error is HttpException)
            ? error.toString()
            : 'Authentication failed');
    }

    _isSubmitting.value = false;
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        height: _authMode == AuthMode.signup ? 400 : 340,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signup ? 400 : 340),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildEmailField(),
                _buildPasswordField(),
                if (_authMode == AuthMode.signup) _buildPasswordConfirmField(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  constraints: BoxConstraints.loose(Size(double.infinity, 30)),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 18, color: Color(0xFFCB067C)),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isSubmitting,
                  builder: (context, isSubmitting, child) {
                    if (isSubmitting) {
                      return const CircularProgressIndicator();
                    }
                    return _buildSubmitButton();
                  },
                ),
                _buildAuthModeSwitchButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        textStyle: TextStyle(
          color: Theme.of(context).primaryTextTheme.headline1?.color,
          fontSize: 18,
        ),
      ),
      child: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      enabled: _authMode == AuthMode.signup,
      decoration: const InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Password is too short!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      child:Text('${_authMode == AuthMode.login ? 'sign up' : 'Login'} an account.'),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'E-Mail'),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Invalid email!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }
}
