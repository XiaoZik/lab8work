import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab8work/uploadToFirebase.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String requiredCode = '1234';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (value) {
                  print(value);
                },
                onCompleted: (value) {
                  if (value == requiredCode) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadingImageToFirebaseStorage(),
                      ),
                    );
                  }
                }),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthenticatePage()),
                );
              },
              child: const Text('Click to go to fingerprint authenticator'),
            ),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThemePage()),
                );
              },
              child: const Text('Click to go change the theme'),
              style: TextButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthenticatePage extends StatelessWidget {
  final LocalAuthentication localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () async {
        bool weCanCheckBiometrics = await localAuth.canCheckBiometrics;
        if (weCanCheckBiometrics) {
          bool authenticated = await localAuth.authenticate(
            biometricOnly: true,
            localizedReason: "Authenticate to access the gallery.",
          );

          if (authenticated) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadingImageToFirebaseStorage(),
              ),
            );
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.fingerprint,
            size: 124.0,
          ),
          Text(
            "Touch to Login",
            style: GoogleFonts.passionOne(
              fontSize: 64.0,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    ));
  }
}

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return new Scaffold(
      appBar: AppBar(
        title: Text('Changing Themes'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  'Dark Theme',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () => _themeChanger.setTheme(ThemeData.dark())),
            SizedBox(
              height: 60,
            ),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text(
                  'Light Theme',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onPressed: () => _themeChanger.setTheme(ThemeData.light())),
          ],
        ),
      ),
    );
  }
}
