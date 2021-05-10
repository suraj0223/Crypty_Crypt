import 'dart:async';
import 'dart:convert';

import 'package:crypt/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecryptScreen extends StatefulWidget {
  @override
  _DecryptScreenState createState() => _DecryptScreenState();
}

class _DecryptScreenState extends State<DecryptScreen> {
  String _decryptedString;

  Widget showCustomSnackbar({String text}) {
    return SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      backgroundColor: Theme.of(context).accentColor.withOpacity(0.8),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      content: Text('$text'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var source = Provider.of<Helper>(context, listen: false);

    return Column(
      children: [
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            primary: Colors.black45,
          ),
          onPressed: () {
            if (source.img64 == null || source.encryptedString == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  showCustomSnackbar(text: 'Encrypt image first!'));
            } else {
              source.aesDecrypt(source.img64);
              ScaffoldMessenger.of(context)
                  .showSnackBar(showCustomSnackbar(text: 'Decrypting...'));
              Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _decryptedString = source.decryptedString;
                });
              });
            }
          },
          child: Text('Decrypt Image'),
        ),
        SizedBox(height: 10),
        AnimatedContainer(
          duration: Duration(seconds: 3),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).accentColor,
              )),
          height: _decryptedString == null && source.decryptedString == null
              ? 45
              : MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          child: _decryptedString == null && source.decryptedString == null
              ? Center(child: Text('Decrypt to Show image'))
              : Image.memory(
                  base64Decode(source.decryptedString),
                  fit: BoxFit.contain,
                ),
        )
      ],
    );
  }
}
