
import 'package:ases/model/user_model.dart';
import 'package:ases/routes/routes.dart';
import 'package:ases/simple_bloc_observer.dart';
import 'package:ases/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'matchesPage/index.dart';

class HomeLayout extends StatelessWidget {
  final User user;
  final firebaseMessaging;
  HomeLayout({this.user, this.firebaseMessaging});
  @override
  Widget build(BuildContext context) {
    
    Bloc.observer = SimpleBlocObserver();
    return MaterialApp(
      home: MatchesPage(user: user),
      theme: ThemeData(
           scaffoldBackgroundColor: blue100,
          primaryColor: blue200,
          brightness: Brightness.dark,
          fontFamily: 'DRONE'),
      routes: {
        Routes.home: (context) => MatchesPage(user: user),
      },
    );
  }
}
