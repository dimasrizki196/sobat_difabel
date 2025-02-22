import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../shared/shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isObscured = true;

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = await _authService.loginUser(email, password);
    if (user != null) {
      print('Login successful: ${user.email}');
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    'assets/logo.png',
                    height: 100, // Sesuaikan ukuran logo
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello!',
                    style: whiteTextStyle.copyWith(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Welcome to Sobat Difabel',
                    style: whiteTextStyle.copyWith(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // form login
            SizedBox(
              height:
                  MediaQuery.of(context).size.height, // Atur tinggi yang jelas
              child: Column(children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: blackTextStyle.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _emailController,
                          style: blackTextStyle,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(300),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                          ),
                          textAlign: TextAlign
                              .left, // Pastikan teks tetap ke kiri, tapi bisa geser
                          textInputAction: TextInputAction
                              .next, // Mempermudah navigasi ke input berikutnya
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _passwordController,
                          style: blackTextStyle,
                          obscureText: _isObscured,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured =
                                      !_isObscured; // Ubah state saat tombol ditekan
                                });
                              },
                            ),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('Forgot Password?'),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Expanded(child: Divider(thickness: 1)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Or sign in with",
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                            const Expanded(child: Divider(thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialButton(
                              imagePath: 'assets/apple.png',
                              onPressed: () {
                                print("Apple Sign-In UI clicked");
                              },
                            ),
                            const SizedBox(width: 20),
                            _socialButton(
                              imagePath: 'assets/google.png',
                              onPressed: () async {
                                final user =
                                    await _authService.signInWithGoogle();
                                if (user != null) {
                                  print(
                                      'Google Sign-In successful: ${user.email}');
                                  Navigator.pushReplacementNamed(
                                      context, '/dashboard');
                                } else {
                                  print('Google Sign-In failed');
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),

                        //copyright
                        const SizedBox(height: 25),
                        Center(
                          child: Text(
                            "© 2025 Sobat Difabel. All rights reserved.",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(
      {required String imagePath, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Image.asset(
          imagePath,
          height: 30,
        ),
      ),
    );
  }
}
