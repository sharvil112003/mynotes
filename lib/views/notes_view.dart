import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Page',
          style: GoogleFonts.poppins(color: Colors.amber),
        ),
        backgroundColor: Colors.white.withOpacity(0.1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        actions: [
          PopupMenuButton<MenuAction>(
            iconColor: Colors.amber,
            color: Colors.white.withOpacity(0.05),
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  print(shouldLogOut);
                  if (shouldLogOut != null && shouldLogOut) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout,
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.poppins(color: Colors.amber),
                    ))
              ];
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: const Column(children: []),
    );
  }
}

Future<bool?> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text(
          'Are you sure you want to sign out? ',
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Log out',
                  style: GoogleFonts.poppins(
                      color: Colors.red, fontWeight: FontWeight.bold))),
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(
                    color: Colors.blue, fontWeight: FontWeight.bold),
              ))
        ],
      );
    },
  );
}
