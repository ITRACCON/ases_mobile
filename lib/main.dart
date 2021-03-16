import 'package:ases/bloc/authentication_bloc.dart';
import 'package:ases/screens/Home/home.dart';
import 'package:ases/screens/WelcomeScreen/welcome_page.dart';
import 'package:ases/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'repository/user_repository.dart';
import 'screens/SplashScreen/splash_page.dart';
import 'simple_bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  final userRepository = UserRepository();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white.withOpacity(0),
  ));

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));

}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASES',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: blue200,
          brightness: Brightness.light,
          fontFamily: 'DRONE'),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomeLayout();
          }
          if (state is AuthenticationUnauthenticated) {
            return WelcomePage(userRepository: userRepository);
          }
          return SplashPage();
        },
      ),
    );
  }
}
