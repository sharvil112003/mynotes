import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
            'User Login',
            style: GoogleFonts.poppins(color: Colors.amber, fontSize: 25),
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
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      await showErrorDialog(context, 'User not found.');
                    } else if (e.code == 'wrong-password') {
                      await showErrorDialog(context, 'Wrong credentials.');
                    } else
                      showErrorDialog(context, 'Error: ${e.code}');
                  } catch (e) {
                    await showErrorDialog(context, e.toString());
                  }
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: Text(
              'Not registered yet ? Register Here',
              style: GoogleFonts.poppins(color: Colors.amber),
            ),
          )
        ],
      ),
    );
  }
}
