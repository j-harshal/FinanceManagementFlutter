import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:khatabook/signin/loginPage.dart';
import 'package:khatabook/constants.dart';

class WelcomePage extends StatelessWidget {
  static String id = 'welcome_screen';
  @override
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
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 100.0,
                      bottom: 16.0,
                    ),
                    child: Carousel(
                      images: [
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'images/cartoon-people-talk-bubble-speech-social-media-cartoon-people-bubble-speech-social-media-vector-illustration-man-talk-149162447.jpg',
                          ),
                        ),
                        Image.asset(
                          'images/social_media_banner_chatting_people_digital_devices_sketch_6849385.jpg',
                        ),
                        Image.asset(
                          'images/images-2.jpg',
                        ),
                      ],
                      autoplay: true,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 6.0,
                      dotSpacing: 15.0,
                      dotIncreasedColor: Colours.orangyish,
                      dotColor: Colours.orangyish,
                      borderRadius: false,
                      dotBgColor: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Welcome! User',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Your personalized passbook in your hand ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
                Text(
                  'Khatabook 2.0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    shape: CircleBorder(),
                    child: SvgPicture.asset(
                      'images/next.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
