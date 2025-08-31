import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/utils/firebase_authentication_utils.dart';
import 'package:evently_app/core/widgets/custom_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(Assets.eventAppLogo, height: 185),
                SizedBox(height: 24.0),
                CustomTextFormField(
                  controller: _nameController,
                  hintText: "Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageIcon(
                      AssetImage(Assets.userIcn),
                      color: ColorPallette.textFormFieldBorderColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: "Email",
                  validator: (value) {
                    final emailRegExp = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageIcon(
                      AssetImage(Assets.mailIcn),
                      color: ColorPallette.textFormFieldBorderColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: "Password",
                  isPassword: true,
                  validator: (value) {
                    final passwordRegExp = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                    );
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (!passwordRegExp.hasMatch(value)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageIcon(
                      AssetImage(Assets.passwordIcn),
                      color: ColorPallette.textFormFieldBorderColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                CustomTextFormField(
                  hintText: "Re-Password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ImageIcon(
                      AssetImage(Assets.passwordIcn),
                      color: ColorPallette.textFormFieldBorderColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                CustomButtonWidget(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show();
                      FirebaseAuthenticationUtils.createUserWithEmailAndPassword(
                        emailAddress: _emailController.text,
                        password: _passwordController.text,
                      ).then((value) {
                        EasyLoading.dismiss();
                        if (value) {
                          Navigator.pop(context);
                        }
                      });
                    }
                  },
                  child: Text(
                    "Create Account",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Already Have Account ? ",
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: ColorPallette.generalTextColor,
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: ColorPallette.primaryColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorPallette.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}