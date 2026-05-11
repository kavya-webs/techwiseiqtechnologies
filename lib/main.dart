// TechWiseIQ — Application Entry Point
//
// Bootstraps the Flutter application with the custom dark theme
// and sets the home page as the initial route. The app is designed
// as a Flutter Web application for the TechWiseIQ IT company website.
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'theme/app_theme.dart';

/// Application entry point — launches the [TechWiseApp] widget tree.
void main() {
  runApp(const TechWiseApp());
}

/// Root widget for the TechWiseIQ application.
///
/// Configures [MaterialApp] with the custom dark theme from [AppTheme],
/// disables the debug banner, and sets [HomePage] as the landing page.
class TechWiseApp extends StatelessWidget {
  const TechWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // SEO-friendly title used by Flutter web in the browser tab
      title: 'TechWiseIQ Technologies | IT & AI Solutions Dubai',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomePage(),
    );
  }
}
