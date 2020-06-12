import 'package:flutter/material.dart';
import 'package:line_clone/api/firebase_auth.dart';
import 'package:provider/provider.dart';

// enum {
//   signIn,
//   signUp,
// }

class SignIn extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter auth'),
      ),
      body: Column(
        children: buildSignUpLayout(),
      ),
    );
  }

  List<Widget> buildSignUpLayout() {
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
      )
    ];
  }

  void submit() async {
    final _firebaseMethod = Provider.of<FirebaseMethods>(context, listen:false);
    await _firebaseMethod.createUser(_email, _password, _name);
  }
}