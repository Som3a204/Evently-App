import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/widgets/custom_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(Assets.eventAppLogo, height: 185),
            SizedBox(height: 24),
            CustomTextFormField(
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
              onTap: () {},
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
                Text("Create Account",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: ColorPallette.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: ColorPallette.primaryColor,
                    decorationThickness: 1.5
                  ),)
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
                ))
          ],
        ),
      ),
    );
  }
}
