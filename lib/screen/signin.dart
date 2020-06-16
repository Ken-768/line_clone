import 'package:flutter/material.dart';
import 'package:line_clone/api/firebase_auth.dart';
import 'package:provider/provider.dart';

enum AuthFormType {
  signIn,
  signUp,
}

class SignIn extends StatefulWidget {
  final AuthFormType authFormType;

  SignIn({Key key, @required this.authFormType}) : super(key:key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthFormType authFormType;

  _SignInState({this.authFormType});

  final formKey = GlobalKey<FormState>();

  String _email, _password, _name;
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    nameController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    super.initState();
  }

  void switchState(String state) {
    formKey.currentState.reset();
    if (state == 'signup') {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    }
  }

  void moveToSignup() {
    formKey.currentState.reset();
    setState(() {
      authFormType = AuthFormType.signUp;
    });
  }

  void moveToSignin() {
    formKey.currentState.reset();
    setState(() {
      authFormType = AuthFormType.signIn;
    });
  }

   bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter auth'),
      ),
      body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: buildSignUpLayout(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildSignUpLayout() {
    if (authFormType == AuthFormType.signUp) {
      return <Widget>[
        TextFormField(
          controller: nameController,
          onSaved: (value) => _name = value,
        ),
        TextFormField(
          controller: emailController,
          onSaved: (value) => _email = value,
        ),
        TextFormField(
          controller: passwordController,
          onSaved: (value) => _password = value,
        ),
        RaisedButton(
          child: Text(
            'アカウント作成',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onPressed: submit,
        ),
        FlatButton(
          child: Text(
            "ログイン",
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          onPressed: moveToSignin,
        ),
      ];
    } else {
      return <Widget> [
        TextFormField(
          controller: emailController,
          onSaved: (value) => _email = value,
        ),
        TextFormField(
          controller: passwordController,
          onSaved: (value) => _password = value,
        ),
        RaisedButton(
          child: Text(
            'アカウント作成',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onPressed: submit,
        ),
        FlatButton(
          child: Text(
            "アカウント作成",
            style: TextStyle(fontSize: 20.0, color: Colors.blue),
          ),
          onPressed: moveToSignup,
        ),
      ];
    }
  }


  void submit() async {
    if(validate()) {
      try {
        final auth = Provider.of<FirebaseMethods>(context, listen: false);
        switch (authFormType) {
          case AuthFormType.signIn:
            String id = await auth.signInWithEmailAndPassword(_email, _password);
            print("ID: $id");
            Navigator.of(context).pushReplacementNamed('/home');
          break;
          case AuthFormType.signUp:
            String id = await auth.createUser(_email, _password, _name);
            print("ID: $id");
            Navigator.of(context).pushReplacementNamed('/home');
          break;
        }
      } catch(e) {
        print('Error: $e');
      }
    }
  }
}