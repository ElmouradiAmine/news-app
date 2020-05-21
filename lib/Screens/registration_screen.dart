import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shapp/Screens/login_screen.dart';

import '../providers/auth_provider.dart';
import 'package:shapp/services/media_service.dart';

import 'package:shapp/services/db_service.dart';
import '../services/snackbar_service.dart';
import 'package:shapp/services/cloud_storage_service.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  State<StatefulWidget> createState() {
    return _RegistrationScreenState();
  }
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  double _deviceHeight;
  double _deviceWidth;

  GlobalKey<FormState> _formKey;
  AuthProvider _auth;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  String _name;
  String _email;
  String _password;
  File _image;
  String _confirmPassword;
  String _fourDigitPin;
  String _failSafeDigitPin;

  _RegistrationScreenState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: ChangeNotifierProvider<AuthProvider>.value(
              value: AuthProvider.instance, child: registrationPageUI()),
        ),
      ),
    );
  }

  Widget registrationPageUI() {
    return Builder(
      builder: (BuildContext _context) {
        SnackBarService.instance.buildContext = _context;
        _auth = Provider.of<AuthProvider>(_context);
        return Container(
          height: _deviceHeight * 1,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 25.0,
                ),
                _headingWidget(),
                _inputForm(),
                _registerButton(),
                _backToLoginPageButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _headingWidget() {
    return Container(
      height: _deviceHeight * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Let's get going!",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            "Please enter your details.",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.65,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: _imageSelectorWidget()),
            Expanded(flex: 1, child: _nameTextField()),
            Expanded(flex: 1, child: _emailTextField()),
            Expanded(flex: 1, child: _passwordTextField()),
            Expanded(flex: 1, child: _confirmPasswordTextField()),
            Expanded(flex: 1, child: _buildFourDigitPin()),
            Expanded(flex: 1, child: _buildFailSafePin()),
          ],
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          File _imageFile = await MediaService.instance.getImageFromLibrary();
          setState(() {
            _image = _imageFile;
          });
        },
        child: Container(
          height: _deviceHeight * 0.10,
          width: _deviceHeight * 0.10,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _image != null
                  ? FileImage(_image)
                  : NetworkImage(
                      "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input.length != 0 ? null : "Please enter a name";
      },
      onSaved: (_input) {
        setState(() {
          _name = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintText: "Name",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        if (_input.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_input)) {
          return 'Please enter a vaild email address';
        }
        return null;
      },
      onSaved: (_input) {
        setState(() {
          _email = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        hintText: "Email",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: _pass,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        if (_input.isEmpty) {
          return 'Please Enter Password';
        }
        if (_input.length <= 5) {
          return 'Password must over 6 character';
        }
        return null;
      },
      onSaved: (_input) {
        setState(() {
          _password = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: "Password",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _confirmPasswordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      controller: _confirmPass,
      keyboardType: TextInputType.visiblePassword,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        if (_input.isEmpty) {
          return 'Retype Password is Required';
        } else if (_input != _pass.text) {
          return 'Password are incorrect';
        }
        return null;
      },
      onSaved: (_input) {
        setState(() {
          _confirmPassword = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        icon: Icon(Icons.lock),
        hintText: "Re-Enter Password",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFourDigitPin() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.phone,
      style: TextStyle(color: Colors.white),
      maxLength: 4,
      validator: (_input) {
        int pin = int.tryParse(_input);
        if (pin == null) {
          return 'Pin is Required';
        }
        if (_input.length != 4) {
          return 'Please Enter 4 Digit Pin';
        }
        return null;
      },
      onSaved: (_input) {
        setState(() {
          _fourDigitPin = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Four Digit Pin",
        icon: Icon(Icons.fiber_pin),
        suffixIcon: IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.grey,
            ),
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: Text('Access Pin'),
                          content: Text(
                              'Access Pin allow you to access and manage your personal information and your contacts'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('ok'))
                          ]));
            }),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFailSafePin() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      keyboardType: TextInputType.phone,
      style: TextStyle(color: Colors.white),
      maxLength: 4,
      validator: (_input) {
        int pin = int.tryParse(_input);
        if (pin == null) {
          return 'Pin is Required';
        }
        if (_input.length != 4) {
          return 'Please Enter 4 Digit Pin';
        }
        return null;
      },
      onSaved: (_input) {
        setState(() {
          _failSafeDigitPin = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Failsafe Pin",
        icon: Icon(Icons.delete_forever),
        suffixIcon: IconButton(
            icon: Icon(
              Icons.info,
              color: Colors.grey,
            ),
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: Text('FailSafe Pin'),
                          content: Text(
                              'When someone forces you physically or mentally share or disclose your information and activity within the application including all you contact. Simply give them this code to completely delete all the data in the account. It is extremely important for you to remember this pin.'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('ok'))
                          ]));
            }),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return _auth.status != AuthStatus.Authenticating
        ? Container(
            height: _deviceHeight * 0.06,
            width: _deviceWidth,
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState.validate() && _image != null) {
                  _auth.registerUserWithEmailAndPassword(_email, _password,
                      (String _uid) async {
                    var _result = await CloudStorageService.instance
                        .uploadUserImage(_uid, _image);
                    var _imageURL = await _result.ref.getDownloadURL();
                    await DBService.instance.createUserInDB(_uid, _name, _email,
                        _imageURL, _fourDigitPin, _failSafeDigitPin);
                  });
                }
              },
              color: Colors.blue,
              child: Text(
                "Register",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }

  Widget _backToLoginPageButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).popUntil(ModalRoute.withName(LoginScreen.id));
      },
      child: Container(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: Icon(Icons.arrow_back, size: 40),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//
//import 'package:shapp/Components/RoundedButton.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:shapp/Screens/news_screen.dart';
//
//class RegistrationScreen extends StatefulWidget {
//  static const String id = 'registration_screen';
//  @override
//  _RegistrationScreenState createState() => _RegistrationScreenState();
//}
//
//class _RegistrationScreenState extends State<RegistrationScreen> {
//  final _auth = FirebaseAuth.instance;
//  String _name;
//  String _email;
//  String _password;
//  String _confirmPassword;
//  String _fourDigitPin;
//  String _failSafeDigitPin;
//
//  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//  final TextEditingController _pass = TextEditingController();
//  final TextEditingController _confirmPass = TextEditingController();
//
//  Widget _buildName() {
//    return TextFormField(
//      decoration: InputDecoration(labelText: 'Name', icon: Icon(Icons.people)),
//      maxLength: 15,
//      keyboardType: TextInputType.text,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Name is Required';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        _name = value;
//      },
//    );
//  }
//
//  Widget _buildEmail() {
//    return TextFormField(
//      decoration: InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
//      keyboardType: TextInputType.emailAddress,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Email is Required';
//        }
//
//        if (!RegExp(
//                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//            .hasMatch(value)) {
//          return 'Please enter a vaild email address';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        _email = value;
//      },
//    );
//  }
//
//  Widget _buildPassword() {
//    return TextFormField(
//      obscureText: true,
//      decoration:
//          InputDecoration(labelText: 'Password', icon: Icon(Icons.lock)),
//      keyboardType: TextInputType.visiblePassword,
//      controller: _pass,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Password is Required';
//        }
//        if (value.length != 6) {
//          return 'Minimum of 6 digiti require';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        _password = value;
//      },
//    );
//  }
//
//  Widget _buildConfirmPassword() {
//    return TextFormField(
//      obscureText: true,
//      decoration: InputDecoration(
//          labelText: 'Confirm Password', icon: Icon(Icons.lock)),
//      keyboardType: TextInputType.visiblePassword,
//      controller: _confirmPass,
//      validator: (String value) {
//        if (value.isEmpty) {
//          return 'Retype Password is Required';
//        } else if (value != _pass.text) {
//          return 'password are incorrect';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        _confirmPassword = value;
//      },
//    );
//  }
//
//  Widget _buildFourDigitPin() {
//    return TextFormField(
//      obscureText: true,
//      decoration: InputDecoration(
//        labelText: 'Access Pin',
//        icon: Icon(Icons.fiber_pin),
//        suffixIcon: IconButton(
//          icon: Icon(
//            Icons.info,
//            color: Colors.grey,
//          ),
//          onPressed: () {
//            return showDialog(
//                context: context,
//                builder: (context) => AlertDialog(
//                        title: Text('Access Pin'),
//                        content: Text(
//                            'Access Pin allow you to access and manage your personal information and your contacts'),
//                        actions: <Widget>[
//                          FlatButton(
//                              onPressed: () {
//                                Navigator.of(context).pop();
//                              },
//                              child: Text('ok'))
//                        ]));
//          },
//        ),
//      ),
//      maxLength: 4,
//      maxLengthEnforced: true,
//      keyboardType: TextInputType.phone,
//      validator: (String value) {
//        int pin = int.tryParse(value);
//        if (pin == null) {
//          return 'Pin is Required';
//        }
//        if (value.length != 4) {
//          return 'Please Enter 4 Digi Pin';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        _fourDigitPin = value;
//      },
//    );
//  }
//
//  Widget _buildFailSafePin() {
//    return TextFormField(
//      obscureText: true,
//      decoration: InputDecoration(
//        labelText: 'Failsafe Pin',
//        icon: Icon(Icons.delete_forever),
//        suffixIcon: IconButton(
//          icon: Icon(
//            Icons.info,
//            color: Colors.grey,
//          ),
//          onPressed: () {
//            return showDialog(
//                context: context,
//                builder: (context) => AlertDialog(
//                        title: Text('FailSafe Pin'),
//                        content: Text(
//                            'When someone forces you physically or mentially share or disclose your information and activity within the application including all you contact. Simply give them this code to completely delect all the data in the account. It is extremely important for you to remember this pin.'),
//                        actions: <Widget>[
//                          FlatButton(
//                              onPressed: () {
//                                Navigator.of(context).pop();
//                              },
//                              child: Text('ok'))
//                        ]));
//          },
//        ),
//      ),
//      maxLength: 4,
//      maxLengthEnforced: true,
//      keyboardType: TextInputType.phone,
//      validator: (String value) {
//        int failsafepin = int.tryParse(value);
//        if (failsafepin == null) {
//          return 'Failsafe Pin is Required';
//        }
//        if (value.length != 4) {
//          return 'Please Enter 4 Digi Pin';
//        }
//        return null;
//      },
//      onSaved: (String value) {
//        _failSafeDigitPin = value;
//      },
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Container(
//      margin: EdgeInsets.all(24),
//      child: ListView(
//        children: <Widget>[
//          Image.asset('images/Logo black.png'),
//          Text(
//            'Register an account',
//            textAlign: TextAlign.center,
//            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//          ),
//          Form(
//              key: _formKey,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                children: <Widget>[
//                  _buildName(),
//                  _buildEmail(),
//                  _buildPassword(),
//                  _buildConfirmPassword(),
//                  _buildFourDigitPin(),
//                  _buildFailSafePin(),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  RoundedButton(
//                    color: Colors.black54,
//                    title: 'REGISTRATER',
//                    onPressed: () async {
//                      if (!_formKey.currentState.validate()) {
//                        return;
//                      }
//
//                      _formKey.currentState.save();
//
//                      try {
//                        final newUser =
//                            await _auth.createUserWithEmailAndPassword(
//                                email: _email, password: _password);
//                        if (newUser != null) {
//                          Navigator.pushReplacementNamed(
//                              context, NewsScreen.id);
//                        }
//                      } catch (e) {
//                        print(e);
//                      }
//
//                      print(_name);
//                      print(_email);
//                      print(_password);
//                      print(_confirmPassword);
//                      print(_fourDigitPin);
//                      print(_failSafeDigitPin);
//                    },
//                  )
//                ],
//              )),
//        ],
//      ),
//    ));
//  }
//}
