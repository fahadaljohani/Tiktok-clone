import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/view/widgets/textinput_field.dart';
import 'package:tiktok_clone2/view/screens/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TikTok',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                  color: buttonColor),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextinputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width - 20,
              child: TextinputField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                isObsecure: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: buttonColor,
              ),
              child: InkWell(
                onTap: () => authController.login(
                    _emailController.text, _passwordController.text),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don'\t have account ?  ",
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupScreen())),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
