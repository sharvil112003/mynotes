import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _emailcontroller;
  late final TextEditingController _passwordcontroller;

  @override
  void initState() {
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Register User',
            style: GoogleFonts.poppins(color: Colors.amber, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 85,
          ),
          Row(
            children: [
              const Icon(
                Icons.email,
                size: 30,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Enter your Email',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey,
                      )),
                  controller: _emailcontroller,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.password,
                color: Colors.grey,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: TextField(
                  autocorrect: false,
                  obscureText: true,
                  maxLength: 8,
                  maxLines: 1,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                      hintText: 'Enter your Password',
                      hintStyle: GoogleFonts.poppins(color: Colors.grey)),
                  controller: _passwordcontroller,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Center(
            child: SizedBox(
              height: 40,
              width: 160,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      backgroundColor: Colors.amber),
                  onPressed: () async {
                    final email = _emailcontroller.text;
                    final password = _passwordcontroller.text;

                    try {
                      final userCred = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email, password: password);
                      print(userCred);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('You have a weak password.');
                      } else if (e.code == 'email-already-in-use') {
                        print("Email is already in use.");
                      } else if (e.code == 'invalid-email') {
                        print('Invalid Email entered.');
                      }
                    }
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(color: Colors.black),
                  )),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login/', (route) => false);
              },
              child: Text(
                'Registered Already?  Log In',
                style: GoogleFonts.poppins(color: Colors.amber),
              ))
        ],
      ),
    );
  }
}
