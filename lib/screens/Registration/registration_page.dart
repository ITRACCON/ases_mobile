import 'dart:core';
import 'package:ases/bloc/authentication_bloc.dart';
import 'package:ases/repository/user_repository.dart';
import 'package:ases/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Registration_form.dart';
import 'bloc/registration_bloc.dart';

class RegistrationPage extends StatelessWidget {
  final UserRepository _userRepository;

  RegistrationPage({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super();
  // Формирование виджета
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: white0,
          automaticallyImplyLeading: true,
        ),
        body: BlocProvider(
            create: (context) {
              return RegistrationBloc(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
                userRepository: _userRepository,
              );
            },
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,
                          width: size.width,
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/bg_welcome.png"),
                                  fit: BoxFit.cover)),
                        ),
                        RegistrationForm(userRepository: _userRepository)
                      ],
                    )
                  ],
                ))));
  }
}
