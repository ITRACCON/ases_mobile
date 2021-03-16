import 'package:ases/Widgets/authentication_form.dart';
import 'package:ases/Widgets/information_modal.dart';
import 'package:ases/repository/user_repository.dart';
import 'package:ases/screens/Login/bloc/login_bloc.dart';
import 'package:ases/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginBloc _loginBloc;

  bool passwordVisible = true;

  UserRepository get _userRepository => widget._userRepository;
  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure) {
        showDialog(
            context: context,
            builder: (context) {
              return ModalInformation(
                  title: "Ошибка", textContent: '${state.error}');
            });
      }
       if(state is LoginSuccess){
         Navigator.pop(context);
       }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Container(
          color: blue200,
          height: size.height * 0.75,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Вход",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: white100,
                        fontFamily: "DRONE",
                        fontSize: 42,
                        height: 1),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.03),
                    width: size.width,
                    child: Stack(alignment: Alignment.centerLeft, children: [
                      Column(
                        children: [
                          Input(
                            icon: Icon(
                              Icons.people_alt_outlined,
                              color: yellow100,
                            ),
                            hintText: "Email",
                            controller: _emailController,
                            obscureText: false,
                          ),
                          Input(
                            icon: Icon(Icons.lock_outline, color: yellow100),
                            hintText: "Password",
                            controller: _passwordController,
                            obscureText: true,
                          ),
                          Material(
                            color: white0,
                            child: Ink(
                              child: state is LoginLoading
                                  ? Container(
                                      padding: EdgeInsets.all(5),
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                yellow100),
                                      ))
                                  : TextButton(
                                      onPressed: _onLoginButtonPressed,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical:7),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: yellow100, borderRadius: BorderRadius.all(Radius.circular(25))),
                                          child: Row( 
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                        Text(
                                          "Войти",
                                          style: TextStyle(
                                              color: blue200,
                                              fontFamily: "DRONE",
                                              fontSize: 24,
                                              height: 1.3),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: blue200,
                                          size: size.width * 0.08,
                                        ),
                                      ])),
                                    ),
                              decoration: ShapeDecoration(
                                  color: blue100, shape: CircleBorder()),
                            ),
                          )
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _onLoginButtonPressed() {
    FocusScope.of(context).unfocus();
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return ModalInformation(title: "Ошибка", textContent: "Ошибка");
          });
    } else {
      _loginBloc.add(LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text));
    }
  }
}
