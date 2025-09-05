import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/core/routes/page_route_name.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/utils/firebase_authentication_utils.dart';
import 'package:evently_app/core/widgets/custom_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(Assets.eventAppLogo, height: 185),
                SizedBox(height: 24),
                CustomTextFormField(
                  controller: _emailController,
                  validator: (String? value){
                    if(value==null || value.isEmpty){
                      return "Please enter your email";
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageIcon(
                      AssetImage(Assets.mailIcn),
                      color: ColorPallette.textFormFieldBorderColor,
                    ),
                  ),
                  hintText: "Email",
                  isPassword: false,
                ),
                SizedBox(height: 16),
                CustomTextFormField(
                  controller: _passwordController,
                  validator: (String? value){
                    if(value==null || value.isEmpty){
                      return "Please enter your password";
                    }
                    return null;
                  },
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ImageIcon(
                      AssetImage(Assets.passwordIcn),
                      color: ColorPallette.textFormFieldBorderColor,
                    ),
                  ),
                  hintText: "Password",
                  isPassword: true,
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorPallette.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorPallette.primaryColor,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                CustomButtonWidget(
                  onTap: () {
                    if(_formkey.currentState!.validate()){
                      EasyLoading.show();
                      FirebaseAuthenticationUtils.signInWithEmailAndPassword(
                          emailAddress: _emailController.text,
                          password: _passwordController.text).then((value) {
                            EasyLoading.dismiss();
                            if(value){
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  PageRouteName.layout,
                                  (route) => false);
                            }
                      });
                    }
                  },
                  child: Text("Login", style: theme.textTheme.bodyLarge),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),),
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context, PageRouteName.register);
                    },
                      child: Text("Create Account",style: theme.textTheme.bodyMedium?.copyWith(
                      color: ColorPallette.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorPallette.primaryColor,
                          decorationThickness: 1.5
                      ),),
                      )
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider(
                      color: ColorPallette.primaryColor,
                    )),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8)
                    ,child: Text("Or",style: theme.textTheme.bodyMedium?.copyWith(
                        color: ColorPallette.primaryColor
                      )),
                    ),
                    Expanded(child: Divider(
                      color: ColorPallette.primaryColor,
                    ))
                  ],
                ),
                CustomButtonWidget(
                  onTap: () {
                    FirebaseAuthenticationUtils.loginWithGoogle(context);
                  },
                  backgroundColor: Colors.white,
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
               Image.asset(Assets.googleIcn),
                        Text("Login With Google",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: ColorPallette.primaryColor
                          ),)
                      ],
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
