import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../MyApp.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);
  static bool isAuth = false;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool authorizedOrNot = false;
  String textInfo = "";

  Future<void> _authorizeNow() async {
    bool isAuthorized = false;
    try {
    if (!AuthScreen.isAuth) {
      try {
        isAuthorized = await _localAuthentication.authenticateWithBiometrics(
          localizedReason: "Please authenticate to complete your transaction",
          useErrorDialogs: true,
          stickyAuth: true,
        );
      } on PlatformException catch (e) {
        print(e);
        setState(() {
          textInfo = e.message;
        });
      }

      if (!mounted) return;

      setState(() {
        AuthScreen.isAuth = isAuthorized;
        debugPrint("auth screen");
        if (isAuthorized) {
          debugPrint("auth screen true");
          Navigator.pop(context);
          Navigator.pushNamed(context, MyApp.routeHome);
        }
      });
    } } catch( ex) {
      print(ex);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authorizeNow();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        height: 45,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 3, color: Colors.white70))),
      )),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("Authorization"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          iconSize: 32,
          onPressed: () {
            _showAlertDialog(
                context,
                'Attention',
                'Do you want to exit the app?',
                Icons.info_outline,
                Colors.orange);
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      child: Center(
        child: RichText(
          text: TextSpan(
            text: textInfo,
          ),
        ),
      ),
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
    );
  }

  _showAlertDialog(BuildContext context, String title, String content,
      [IconData iconData, Color color]) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      color: Colors.red,
      onPressed: () {
        SystemNavigator.pop();
      },
    );
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(fontSize: 18),
      ),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    ); // set up th// set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        children: <Widget>[
          Icon(iconData, size: 32, color: color),
          SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      content: Text(
        content,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      actions: [okButton, cancelButton],
    ); // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
