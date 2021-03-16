import 'package:ases/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Input extends StatelessWidget {
  final _inputController;
  final _hintText;
  final _icon;
  final _obscureText;
  final _suffixIcon;
  final _validator;

  Input({controller, hintText, icon, obscureText, suffixIcon, validator})
      : _inputController = controller,
        _hintText = hintText,
        _icon = icon,
        _obscureText = obscureText,
        _suffixIcon = suffixIcon,
        _validator = validator;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
         style: TextStyle(color: white100, fontFamily: "DRONE", fontSize: 18, height: 1.3),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: white100, fontFamily: "DRONE", fontSize: 18, height: 1.3),
          hintText: _hintText,
          contentPadding: EdgeInsets.fromLTRB(size.width * 0.1,
              size.height * 0.01, size.width * 0.1, size.height * 0.042),
          prefixIcon: Padding(
            padding: EdgeInsets.all(0.0),
            child: _icon,
          ),
          enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(color: yellow100),
            borderRadius:
                BorderRadius.all(Radius.circular(20)),
          ),
          focusedBorder: OutlineInputBorder(
             borderSide: BorderSide(color: yellow100),
            borderRadius:
                BorderRadius.all(Radius.circular(20)),
          ),
          errorBorder:OutlineInputBorder(
             borderSide: BorderSide(color: yellow100),
            borderRadius:
                BorderRadius.all(Radius.circular(20)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: yellow100),
            borderRadius:
                BorderRadius.all(Radius.circular(20)),
          ),
          filled: true,
          fillColor: blue100,
          suffixIcon: _suffixIcon,
        ),
        controller: _inputController,
        keyboardType: TextInputType.text,
        obscureText: _obscureText,
        validator: _validator,
      ),
    );
  }
}
