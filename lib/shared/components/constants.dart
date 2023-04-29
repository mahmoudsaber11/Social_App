import 'package:flutter/material.dart';
import 'package:social_app/shared/components/full_screen_widget.dart';
import 'package:social_app/shared/styles/themes.dart';

const hintTxtStyle = TextStyle(
  color: Color(0xFFffae19),
  fontFamily: 'OpenSans',
);

const lblStyle = TextStyle(
  color: Colors.orange,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final bxDecorationStyle = BoxDecoration(
  color: const Color(0xFF000000),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.orange,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

String? uId = '';
double intToDouble(int num) {
  double doubleNum = num.toDouble();
  return doubleNum;
}

Widget imagePreview(String? image) {
  return FullScreenWidget(
    child: Center(
      child: Image.network(
        "$image",
        fit: BoxFit.cover,
        width: double.infinity,
        alignment: AlignmentDirectional.topCenter,
      ),
    ),
  );
}

var themeMode = MyTheme.lightTheme;
const defaultColor = Color.fromRGBO(93, 63, 211, 1);
