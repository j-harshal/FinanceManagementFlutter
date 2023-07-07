import 'package:flutter/material.dart';
import 'package:khatabook/constants.dart';
import 'package:khatabook/signin/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);
  static String id = 'forgot_screen';

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  String email = '';
  String pass = '';
  String password = '';
  bool isSame = false;
  bool compare({String pass = '', String password = ' '}) {
    if (pass == password) return true;
    return false;
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.close),
                      title: new Text('Re-enter the password'),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF3383CD),
                  Color(0xFF11249F),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60.0),
                bottomRight: Radius.circular(60.0),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                  child: Image.asset(
                    'images/social_media_banner_chatting_people_digital_devices_sketch_6849385.jpg',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 50.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email address",
                    hintText: "mtechviral@gmail.com",
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                  onChanged: (value) {
                    email = value;
                    print(email);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: TextField(
                  autofocus: true,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter New Password",
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                  minLines: 1,
                  onChanged: (value) {
                    pass = value;
                    print(pass);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 15.0,
                  right: 15.0,
                ),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Confirm New Password",
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                  minLines: 1,
                  onChanged: (value) {
                    password = value;
                    isSame = compare(pass: pass, password: password);
                  },
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8.0),
                child: TextButton(
                  onPressed: () async {
                    if (isSame) {
                      User? user = await auth.currentUser!;
                      user.updatePassword(password).then((value) {
                        print("Successfully changed password");
                      }).catchError((error) {
                        print("Password can't be changed" + error.toString());
                        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                      });
                      Navigator.pushNamed(context, LoginPage.id);
                    } else {
                      _showPicker(context);
                    }
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // color: Colours.orangyish,
                  // padding: EdgeInsetsDirectional.all(2.0),
                  // minWidth: 120.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
