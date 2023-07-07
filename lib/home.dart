import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:khatabook/constants.dart';
import 'package:khatabook/infoscreen.dart';
import 'package:khatabook/my_header.dart';
import 'infoconstants.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id = 'home_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = ScrollController();
  double offset = 0;
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "images/3855345.png",
              textTop: "Hello",
              textBottom: user!.displayName,
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Transactions",
                    style: MyTheme.kHeadingTextStyle,
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        PreventCard(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoScreen(
                                      index: 1,
                                    )),
                              );
                            },
                            title: 'Shopping',
                            text:
                            '',image: '',),
                        SizedBox(height: 15),
                        PreventCard(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoScreen(
                                      index: 2,
                                    )),
                              );
                            },
                            title: 'Bills',
                            text:
                            'Pay your Electricity bills, water bill, your every bill payment here!',
                            image: 'images/dance.jpg'),
                        SizedBox(height: 15),
                        PreventCard(
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoScreen(
                                      index: 3,
                                    )),
                              );
                            },
                            title: 'Cabs',
                            text:
                            'Now book your cabs, trains, bus just here!',
                            image: 'images/music.jpg'),
                        SizedBox(height: 15),
                        PreventCard(
                          title: 'Restaraunts',
                          text:
                          'From booking seats in Restaurants to ordering food at comfort of your couch , everything you need is Khatabook ',
                          image: 'images/sports.jpg',
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoScreen(
                                    index: 4,
                                  )),
                            );
                          },
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  dynamic onPress;
  PreventCard({
    Key? key,
    required this.image,
    required this.title,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 126,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                height: 136,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.purple.shade50,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 8),
                      blurRadius: 24,
                      color: kShadowColor,
                    ),
                  ],
                ),
              ),
              Image.asset(image),
              Positioned(
                left: 155,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: 136,
                  width: MediaQuery.of(context).size.width - 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        title,
                        style: kTitleTextstyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          text,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
