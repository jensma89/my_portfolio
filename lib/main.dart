// lib/main.dart
//
// App entry point. Manages theme mode (dark/light) and locale (en/de).
// Starts in dark mode, English.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/theme.dart';
import 'components/nav_bar.dart';
import 'home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  Locale _locale = const Locale('en');

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    });
  }

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'de'
          ? const Locale('en')
          : const Locale('de');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jens Mayer – Portfolio',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('de')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: _PortfolioShell(
        isDarkMode: _themeMode == ThemeMode.dark,
        locale: _locale,
        onThemeToggle: _toggleTheme,
        onLocaleToggle: _toggleLocale,
      ),
    );
  }
}

class _PortfolioShell extends StatelessWidget {
  const _PortfolioShell({
    required this.isDarkMode,
    required this.locale,
    required this.onThemeToggle,
    required this.onLocaleToggle,
  });

  final bool isDarkMode;
  final Locale locale;
  final VoidCallback onThemeToggle;
  final VoidCallback onLocaleToggle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioNavBar(
        isDarkMode: isDarkMode,
        locale: locale,
        onThemeToggle: onThemeToggle,
        onLocaleToggle: onLocaleToggle,
      ),
      body: HomePage(locale: locale),
    );
  }
}
