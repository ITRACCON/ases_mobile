import 'dart:core';
import 'package:ases/repository/user_repository.dart';
import 'package:ases/screens/Login/login_page.dart';
import 'package:ases/screens/Registration/registration_page.dart';
import 'package:ases/style/colors.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  final UserRepository _userRepository;

  WelcomePage({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super();

  // Формирование виджета
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              bottom: 18,
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.3,
                margin: EdgeInsets.only(bottom: size.height * 0.03),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              )),
          Positioned(
            bottom: 9,
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.3,
              margin: EdgeInsets.only(bottom: size.height * 0.03),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
            ),
          ),
          Container(
            width: size.width * 0.8,
            height: size.height * 0.3,
            margin: EdgeInsets.only(bottom: size.height * 0.03),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("ASES", textAlign: TextAlign.center,
                          style: TextStyle(
                           fontSize: 42, fontFamily: "Drone"
                          )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage(userRepository: _userRepository)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.7,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          color: yellow100,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text("Войти",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, fontSize: 24, fontFamily: "Drone", height: 1.5
                          )),
                    )),
                     TextButton(
                    onPressed: () {
                       Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage(userRepository: _userRepository)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.7,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          color: blue100,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Text("Регистрация",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white, fontSize: 24, fontFamily: "Drone", height: 1.5
                          )),
                    ))
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(25))),
          )
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/bg_welcome.png"), fit: BoxFit.cover),
      ),
    ));
  }
}
