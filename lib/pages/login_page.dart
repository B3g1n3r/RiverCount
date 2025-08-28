import 'package:bytelogik_assessment/pages/counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/auth_provider.dart';
import 'signup_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String error = '';
  bool loading = false;

  void showSnackBar(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Welcome Back',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  TextField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Material(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: loading
                            ? null
                            : () async {
                                setState(() {
                                  error = '';
                                  loading = true;
                                });

                                final username = usernameController.text.trim();
                                final password = passwordController.text.trim();

                                if (username.isEmpty || password.isEmpty) {
                                  setState(() {
                                    error =
                                        'Username and password are required';
                                    loading = false;
                                  });
                                  return;
                                }
                                await login(username, password, ref);

                                setState(() {
                                  loading = false;
                                });

                                if (ref.read(authProvider) != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const CounterPage()),
                                  );
                                } else {
                                  setState(() {
                                    error = 'Invalid username or password';
                                  });
                                  showSnackBar(error, error: true);
                                }
                              },
                        child: Center(
                          child: loading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  if (error != '') ...[
                    const SizedBox(height: 12),
                    Text(error, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Don\'t have an account?",
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: "Signup here",
                              style: TextStyle(color: Colors.blueAccent))
                        ])),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
