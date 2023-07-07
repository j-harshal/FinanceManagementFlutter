import 'package:khatabook/Person.dart';
import 'package:khatabook/infoconstants.dart';
import 'package:khatabook/my_header.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khatabook/constants.dart';
import 'personalData.dart';

class InfoScreen extends StatefulWidget {
  static String id = 'info_screen';
  final int index;
  InfoScreen({Key? key, required this.index}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _InfoScreenState(this.index);
  }
}

class _InfoScreenState extends State<InfoScreen> {
  int index;
  _InfoScreenState(this.index);
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

  List<data> p = personalData().persons;

  @override
  void initState() {
    super.initState();
    // _getUser();
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
              textTop: "Get to know",
              textBottom: "About Payments",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Payment Details",
                    style: kHeadingTextStyle,
                  ),
                  SizedBox(height: 20),
                  // ListView.builder(
                  //   itemCount: p.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return PaymentCard(
                  //       name: p[index].names,
                  //       time: p[index].times,
                  //       amount: p[index].amounts,
                  //     );
                  //   },
                  // ),
                  Column(
                    children: List.generate(
                      p.length,
                      (index) => PaymentCard(
                        name: p[index].names,
                        time: p[index].times,
                        amount: p[index].amounts,
                      ),
                    ).toList(),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(bottom: 20.0),
                        child: TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => CollegeScreen(
                            //         index: index,
                            //         pass: course
                            //             .courseBank[index - 1].colleges,
                            //       )),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Find Colleges Near Me',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // color: Colours.orangyish,
                          // padding: EdgeInsetsDirectional.all(2.0),
                        ),
                      ),
                    ],
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

class PaymentCard extends StatelessWidget {
  String? name;
  String? amount;
  String? time;
  PaymentCard({Key? key, this.name, this.amount, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 85),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey,
            border: Border.all(color: Colors.transparent),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: Image.asset('images/'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        time!,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        amount!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        name!,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.blueAccent.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
