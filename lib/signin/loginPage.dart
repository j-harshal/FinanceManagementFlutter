import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:khatabook/constants.dart';
import 'package:khatabook/signin/signup.dart';
import 'package:khatabook/signin/forgotPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:khatabook/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String id = 'login_screen';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  String email = '';
  String pass = '';
  Future<File> urlToFile(String imageUrl) async {
    Uri myUri = Uri.parse(imageUrl);
    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(myUri);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  UserCredential? userCredential;
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
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'images/social_media_banner_chatting_people_digital_devices_sketch_6849385.jpg',
                    ),
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
                    labelText: "Enter Password",
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                  onChanged: (value) {
                    pass = value;
                    print(pass);
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPage.id);
                  },
                  child: Text(
                    'Forgot Password ?     ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8.0),
                child: TextButton(
                  onPressed: () async {
                    try {
                      userCredential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: email, password: pass);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                    if (userCredential != null) {
                      Navigator.pushNamed(context, HomePage.id);
                    }
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  // color: Colours.orangyish,
                  // padding: EdgeInsetsDirectional.all(2.0),
                  // minWidth: 120.0,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    enableFeedback: false,
                    shape: CircleBorder(),
                    onPressed: () async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
  if (userCredential != null) {
    print(userCredential);
    email = googleUser!.email;
    if (email != null) { // Check if email is not null
      FirebaseFirestore.instance.collection('users').doc(email!).set({
        'name': googleUser.displayName,
        'email': email,
        'mobile': '',
      }).then((value) async {
        try {
          await FirebaseStorage.instance
              .ref('$email/profile.png')
              .putFile(await urlToFile("googleUser.photoUrl"));
        } on FirebaseException catch (err) {
          print(err);
        }
        print("User Added");
      });
      Navigator.pushNamed(context, HomePage.id);
    } else {
      print("Email is null");
    }
  }
},

                    child: SvgPicture.asset(
                      'images/google.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  // MaterialButton(
                  //   onPressed: () async {
                  //     final LoginResult result =
                  //     await FacebookAuth.instance.login();
                  //     final OAuthCredential credential =
                  //     FacebookAuthProvider.credential(
                  //         result.accessToken!.token);
                  //     userCredential = await FirebaseAuth.instance
                  //         .signInWithCredential(credential);
                  //     final userData =
                  //     await FacebookAuth.instance.getUserData();
                  //     if (userCredential != null) {
                  //       print(userCredential);
                  //       email = userData['email'];
                  //       FirebaseFirestore.instance
                  //           .collection('users')
                  //           .doc(email)
                  //           .set({
                  //         'name': userData['name'],
                  //         'email': email,
                  //         'mobile': '',
                  //       }).then((value) async {
                  //         try {
                  //           await FirebaseStorage.instance
                  //               .ref('$email/profile.png')
                  //               .putFile(await urlToFile(
                  //               userData['picture']['data']['url']));
                  //         } on FirebaseException catch (err) {
                  //           print(err);
                  //         }
                  //         print("User Added");
                  //       });
                  //       Navigator.pushNamed(context, HomePage.id);
                  //     }
                  //   },
                  //   shape: CircleBorder(),
                  //   child: SvgPicture.asset(
                  //     'images/fb.svg',
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                  // MaterialButton(
                  //   shape: CircleBorder(),
                  //   onPressed: () async {
                  //     final authResult = await twitterLogin.login();
                  //     final twitterAuthCredential =
                  //         TwitterAuthProvider.credential(
                  //       accessToken: authResult.authToken!,
                  //       secret: authResult.authTokenSecret!,
                  //     );
                  //     // Once signed in, return the UserCredential
                  //     userCredential = await FirebaseAuth.instance
                  //         .signInWithCredential(twitterAuthCredential);
                  //     if (userCredential != null) {
                  //       print(userCredential);
                  //       email = authResult.user!.email;
                  //       FirebaseFirestore.instance
                  //           .collection('users')
                  //           .doc(email)
                  //           .set({
                  //         'name': authResult.user!.name,
                  //         'email': email,
                  //         'mobile': '',
                  //       }).then((value) async {
                  //         try {
                  //           await FirebaseStorage.instance
                  //               .ref('$email/profile.png')
                  //               .putFile(await urlToFile(
                  //                   authResult.user!.thumbnailImage));
                  //         } on FirebaseException catch (err) {
                  //           print(err);
                  //         }
                  //         print("User Added");
                  //       });
                  //       Navigator.pushNamed(context, HomePage.id);
                  //     }
                  //   },
                  //   child: SvgPicture.asset(
                  //     'images/twitter.svg',
                  //     fit: BoxFit.fill,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Do not' 'have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignupPage.id);
                    },
                    child: Text(
                      'Sign Up Here!',
                      style: TextStyle(
                        color: Colours.orangyish,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colours.purplish),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
