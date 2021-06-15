import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextButton(
                child: Text('Dark Theme'),
                onPressed: () => _themeChanger.setTheme(ThemeData.dark())),
            TextButton(
                child: Text('Light Theme'),
                onPressed: () => _themeChanger.setTheme(ThemeData.light())),
          ],
        ),
      ),
    );
  }
}