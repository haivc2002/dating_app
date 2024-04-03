import 'package:dating/theme/theme_color.dart';
import 'package:flutter/material.dart';

import '../tool_widget_custom/input_widget_custom.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: InputWidgetCustom(labelText: 'Login', radius: 100, )),
    );
  }
}
