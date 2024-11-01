import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeNotifier with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class ParametrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false, // Cette ligne supprime l'étiquette "Debug"
            theme: themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Paramètres'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.brightness_6),
                    onPressed: () {
                      themeNotifier.toggleTheme();
                    },
                  ),
                ],
              ),
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    themeNotifier.toggleTheme();
                  },
                  child: Text('Basculer entre les modes jour et nuit'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Cette ligne supprime l'étiquette "Debug"
      home: ParametrePage(),
    );
  }
}
