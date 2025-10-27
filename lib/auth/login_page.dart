import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function(String, String) onLogin;
  final VoidCallback onNavigateToRegister;

  const LoginPage({
    super.key,
    required this.onLogin,
    required this.onNavigateToRegister,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFECFDF5), Colors.white, Color(0xFFE6FFFA)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shadowColor: Colors.teal.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.teal.shade100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Colors.green, Colors.teal],
                        ),
                      ),
                      child: const Icon(Icons.menu_book,
                          color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 16),

                    // Judul
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.green, Colors.teal],
                      ).createShader(bounds),
                      child: const Text(
                        "Selamat Datang Kembali",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Masuk untuk melanjutkan petualangan komik Anda",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Input Email
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: const Icon(Icons.mail_outline),
                        hintText: "nama@example.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Input Password
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "••••••••",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              activeColor: Colors.teal,
                              onChanged: (val) {
                                setState(() => rememberMe = val!);
                              },
                            ),
                            const Text("Ingat saya"),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Lupa password?",
                            style: TextStyle(color: Colors.teal),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Tombol Login
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        widget.onLogin(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: const Text("Masuk"),
                    ),
                    const SizedBox(height: 24),

                    // Demo Login Section
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Demo Login",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Demo Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              emailController.text = "pembaca@example.com";
                              passwordController.text = "demo123";
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.green.shade300),
                            ),
                            child: const Text("Pembaca"),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              emailController.text = "ahmad@example.com";
                              passwordController.text = "demo123";
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.teal.shade300),
                            ),
                            child: const Text("Author"),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: widget.onNavigateToRegister,
                      child: const Text.rich(
                        TextSpan(
                          text: "Belum punya akun? ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Daftar sekarang",
                              style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
