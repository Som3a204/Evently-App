import 'package:evently_app/core/constants/assets.dart';
import 'package:evently_app/core/theme/color_pallette.dart';
import 'package:evently_app/core/widgets/custom_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Forget Password")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              Assets.forgetPasswordImg,
              height: mediaQuery.size.height * 0.38,
            ),
            SizedBox(height: 24.0),
            CustomTextFormField(
              hintText: "Email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ImageIcon(
                  AssetImage(Assets.mailIcn),
                  color: ColorPallette.textFormFieldBorderColor,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            CustomButtonWidget(
              backgroundColor: ColorPallette.primaryColor,
              child: Text(
                "Reset Password",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}