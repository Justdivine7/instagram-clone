import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auths/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/utils/components/colors.dart';
import 'package:instagram_clone/utils/components/global_variables.dart';
import 'package:instagram_clone/utils/image_picker.dart';
import 'package:instagram_clone/utils/widgets/text_field_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize ?
            EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width/3,
          ):const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'asset/images/Instagram-logo-text.svg',
                colorFilter:
                    const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 64,
              ),
              const SizedBox(height: 64),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              'https://plus.unsplash.com/premium_photo-1732757787074-0f95bf19cf73?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8dXNlciUyMHByb2ZpbGUlMjBhdmF0YXJ8ZW58MHx8MHx8fDA%3D'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 60,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: primaryColor,
                        size: 24,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () async {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    String res = await AuthMethods().signUpUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        username: _usernameController.text.trim(),
                        bio: _bioController.text.trim(),
                        file: _image!);
                    print(res);
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registration successful'),
                      ),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Responsive(
                          webScreenLayout: WebScreenLayout(),
                          mobileScreenLayout: MobileScreenLayout(),
                        ),
                      ),
                    );
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Registration failed'),
                      ),
                    );
                    print(e);
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: blueColor),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : const Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              InkWell(
                onTap: () {
                  navigateToLogin();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text("Already have an account?"),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
    );
  }
}
