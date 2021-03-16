import 'package:flutter/material.dart';

class ModalInformation extends StatelessWidget {
  final String textContent;
  final String title;

  ModalInformation({this.textContent, this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          height: 220, // дорожные знаки у кнопки "Закрыть" в модалке о предупреждении более 7 действий
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
              ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        textContent,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: Text(
                     "Зарыть",
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
