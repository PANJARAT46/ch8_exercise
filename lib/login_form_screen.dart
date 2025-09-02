import 'package:flutter/material.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>(); //แก้buidของstate
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String _savedEmail = '';
  String _savedPassword = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ฟอร์มล็อกอิน')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // เพิ่มวิดเจ็ต Form
          key: _formKey, // กำหนด key
          child: Column(
            children: [
              Text('กรุณาป้อนข้อมูลเข้าระบบ:'),
              const SizedBox(height: 20), // ตัวเว้นวรรค
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'อีเมล',
                  hintText: 'you@example.com',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกอีเมล';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'กรุณากรอกอีเมลให้ถูฏต้อง';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedEmail = value;
                  }
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่าน',
                  hintText: 'ป้อนรหัสผ่านของคุณ',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาป้อนรหัสผ่านของคุณ';
                  }
                  if (value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    _savedPassword = value;
                  }
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ฟอร์มถูกต้อง! กำลังประมวลผลข้อมูล...'),
                      ),
                    );
                    print('_saveEmail: $_savedEmail');
                    print('_savedPassword: $_savedPassword');
                  } else {
                    print('ฟอร์มไม่ถูกต้อง');
                  }
                },

                child: const Text('ล็อกอิน'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}