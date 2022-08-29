import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatelessWidget {
  UserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Contact"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: Text(
                                'T',
                                style: TextStyle(
                                    fontSize: 90,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 95,),
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: TextButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                        'https://github.com/thwasim'));
                                  },
                                  child: Image.asset(
                                      'assets/download_prev_ui.png'))),
                          SizedBox(width: 10),
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            child: TextButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      'https://www.linkedin.com/in/thwasimaslam/'));
                                },
                                child: Image.asset(
                                    'assets/ink-removebg-preview.png')),
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: TextButton(
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      'mailto: fasilfasi9160@gmail.com'));
                                },
                                child: Image.asset(
                                    'assets/gmail-removebg-preview.png'),
                              )),
                        ],
                      ),
                      Divider(
                        height: 100,
                        color: Color.fromARGB(255, 255, 255, 255),
                        endIndent: 10,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Developed By :",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Thwasim Aslam K',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}