import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/animation_showcase/presentation/pages/home_page.dart';

void main() {
  runApp(const FlutterMotionLabApp());
}

class FlutterMotionLabApp extends StatelessWidget {
  const FlutterMotionLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Motion Lab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}
