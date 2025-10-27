import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function(String, String, String, String) onRegister;
  final VoidCallback onNavigateToLogin;

  const RegisterPage({
    super.key,
    required this.onRegister,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  String role = 'reader';

  void _submit() {
    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak cocok!')),
      );
      return;
    }
    widget.onRegister(
      nameController.text,
      emailController.text,
      passwordController.text,
      role,
    );
  }

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
                        "Buat Akun Baru",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Bergabunglah dengan komunitas pecinta komik",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Input Nama
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Nama Lengkap",
                        prefixIcon: const Icon(Icons.person_outline),
                        hintText: "Masukkan nama lengkap",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

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
                    const SizedBox(height: 16),

                    // Konfirmasi Password
                    TextField(
                      controller: confirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Konfirmasi Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: "••••••••",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Pilihan Role
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Daftar Sebagai",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => role = 'reader'),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: role == 'reader'
                                    ? Colors.teal
                                    : Colors.teal.shade100,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: role == 'reader'
                                  ? Colors.teal.shade50
                                  : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'reader',
                                  // ignore: deprecated_member_use
                                  groupValue: role,
                                  activeColor: Colors.teal,
                                  // ignore: deprecated_member_use
                                  onChanged: (value) {
                                    setState(() => role = value!);
                                  },
                                ),
                                const Icon(Icons.menu_book,
                                    color: Colors.teal, size: 20),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Pembaca"),
                                      Text(
                                        "Baca dan nikmati komik favorit",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () => setState(() => role = 'author'),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: role == 'author'
                                    ? Colors.teal
                                    : Colors.teal.shade100,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: role == 'author'
                                  ? Colors.teal.shade50
                                  : Colors.transparent,
                            ),
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: 'author',
                                  // ignore: deprecated_member_use
                                  groupValue: role,
                                  activeColor: Colors.teal,
                                  // ignore: deprecated_member_use
                                  onChanged: (value) {
                                    setState(() => role = value!);
                                  },
                                ),
                                const Icon(Icons.auto_awesome,
                                    color: Colors.teal, size: 20),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Author"),
                                      Text(
                                        "Buat dan publikasikan komik",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Tombol Register
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _submit,
                      child: const Text("Daftar Sekarang"),
                    ),

                    const SizedBox(height: 24),

                    // Link ke Login
                    GestureDetector(
                      onTap: widget.onNavigateToLogin,
                      child: const Text.rich(
                        TextSpan(
                          text: "Sudah punya akun? ",
                          style: TextStyle(color: Colors.grey),
                          children: [
                            TextSpan(
                              text: "Masuk di sini",
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
