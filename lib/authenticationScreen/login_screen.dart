import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xsbdating/authenticationScreen/registration_screen.dart';
import 'package:xsbdating/controllers/authentication_controller.dart';
import 'package:xsbdating/widgets/custom_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool showProgressBar = false;

  var authController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              "images/xlogo.png",
              width: 300,
            ),
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Login now to find your best Match!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            //email field
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: emailTextEditingController,
                labelText: "Email",
                iconData: Icons.email_outlined,
                isObscure: false,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //password field
            SizedBox(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              child: CustomTextFieldWidget(
                editingController: passwordTextEditingController,
                labelText: "Password",
                iconData: Icons.lock_outline,
                isObscure: true,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //login button
            Container(
              width: MediaQuery.of(context).size.width - 36,
              height: 55,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: InkWell(
                onTap: () async {
                  if (emailTextEditingController.text.trim().isNotEmpty &&
                      passwordTextEditingController.text.trim().isNotEmpty) {
                    setState(() {
                      showProgressBar = true;
                    });
                    await authController.loginUser(
                      emailTextEditingController.text.trim(),
                      passwordTextEditingController.text.trim(),
                    );
                    setState(() {
                      showProgressBar = false;
                    });
                  } else {
                    Get.snackbar(
                      "Email or Password Missing",
                      "Email and pssword filed should not be empty.",
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            //create account
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const RegistrationScreen());
                  },
                  child: const Text(
                    "Create here",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 24,
            ),

            showProgressBar == true
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
