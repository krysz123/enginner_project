import 'package:enginner_project/common/widgets/text_field/text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siema'),
      ),
      body: const SingleChildScrollView(
          child: Center(
        child: CustomTextField(
          hintText: 'siemano',
        ),
      )),
    );
  }
}
