import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:crypt/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EncryptScreen extends StatefulWidget {
  @override
  _EncryptScreenState createState() => _EncryptScreenState();
}

class _EncryptScreenState extends State<EncryptScreen> {
  File _image;
  String _img64;

  Future getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var bytes = await pickedFile.readAsBytes();

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _img64 = base64Encode(bytes);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget customTextButton({Function onclick, String text}) {
    return OutlinedButton(
      child: Text(text),
      onPressed: onclick,
      style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: Colors.black45,
      ),
    );
  }

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
    var help = Provider.of<Helper>(context, listen: true);
    if (_image != null) help.setImage(_image, _img64);

    return Column(
      children: [
        SizedBox(height: 20),
        AnimatedContainer(
          duration: Duration(seconds: 3),
          height: help.image == null
              ? 45
              : MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: Theme.of(context).accentColor,
            ),
          ),
          child: Center(
            child: help.image == null
                ? Text('No image selected.')
                : Image.file(help.image),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              customTextButton(
                text: 'Load Image',
                onclick: getImage,
              ),
              customTextButton(
                text: 'Encrypt Image',
                onclick: () {
                  if (help.image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        showCustomSnackbar(text: 'Load image to encrypt'));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        showCustomSnackbar(text: 'Encrypting...'));

                    Provider.of<Helper>(context, listen: false)
                        .aesEncrypt(help.img64);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
