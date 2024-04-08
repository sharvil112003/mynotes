import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'An error occured',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
          ),
          content: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.amber, fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK',
                  style:
                      GoogleFonts.poppins(color: Colors.amber, fontSize: 15)),
            ),
          ],
        );
      });
}
