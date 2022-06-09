import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constant.dart';
import 'package:tiktok_clone2/view/widgets/textinput_field.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  SignupScreen({Key? key}) : super(key: key);

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
              'Register',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(
                      'http://marijsalon.com/wp-content/uploads/2016/04/placeholder_male1.jpg'),
                ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    icon: const Icon(Icons.add_a_photo),
                    color: Colors.white,
                    onPressed: () => authController.pickImage(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextinputField(
                controller: _nameController,
                labelText: 'Name',
                icon: Icons.person,
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
                onTap: () => authController.createUser(
                    _nameController.text,
                    _emailController.text,
                    _passwordController.text,
                    authController.profileImage),
                child: const Center(
                  child: Text(
                    'Register',
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
                  "Already have account ?  ",
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Login',
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
