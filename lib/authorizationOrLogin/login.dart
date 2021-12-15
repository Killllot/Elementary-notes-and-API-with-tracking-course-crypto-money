import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myNotes/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void initState() {
    super.initState();
    initFirebase();
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Align(
          child: Text(
            'Notes',
            style: TextStyle(
                fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );
    }

    Widget _input(Icon icon, String text, TextEditingController controller, bool flagVisibilityContent) {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: flagVisibilityContent,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30),
              hintText: text,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white),
                  child: icon,
                ),
              )),
        ),
      );
    }

    Widget _button(String text, void func()) {
      return ElevatedButton(
        onPressed: () {
          func();
        },
        child: Text(text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
      );
    }

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _input(
                    Icon(Icons.email), "Email", _emailController, false)),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: _input(
                  Icon(Icons.lock_open), "Password", _passwordController, true),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    void buttonLogin() {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) {
        return;
      }

      Future user =  _authService.signInEmailPassword(_email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can't SigIn you!Please chek your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Navigator.pushNamed(context, '/Main');
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void buttonRegistration() {
      _email = _emailController.text;
      _password = _passwordController.text;

      if (_email.isEmpty || _password.isEmpty) {
        return;
      }

      Future user = _authService.registerEmailPassword(_email.trim(), _password.trim());
      if (user == null) {
        Fluttertoast.showToast(
            msg: "Can't SigIn you!Please chek your email/password",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Navigator.pushNamed(context, '/Main');
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            _logo(),
            (showLogin
                ? Column(
                    children: <Widget>[
                      _form('Login', buttonLogin),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                            child: Text('Not registered? Register',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onTap: () {
                              setState(() {
                                showLogin = false;
                              });
                            }),
                      )
                    ],
                  )
                : Column(
                    children: <Widget>[
                      _form('Register', buttonRegistration),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onTap: () {
                              setState(() {
                                showLogin = true;
                              });
                            }),
                      )
                    ],
                  ))
          ],
        ));
  }
}


/*

return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[

          _logo(),
          (showLogin? Column(
            children:<Widget> [
              _form('Login', buttonLogin),
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Text('Not registered? Register',
                        style: TextStyle( fontSize: 20, color: Colors.white)),
                    onTap:(){
                      setState((){
                        showLogin =false;
                      });
                    }
                ),
              )
            ],
          )
              :Column(
            children:<Widget> [
              _form('Register', buttonRegistration),
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                    child: Text('Login',
                        style: TextStyle( fontSize: 20, color: Colors.white)),
                    onTap:(){
                      setState((){
                        showLogin= true;
                      });
                    }
                ),
              )

            ],
          ))
        ],
      )
    );

 */
