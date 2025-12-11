import 'package:flutter/material.dart';

class AnimationDemo {
  final String id;
  final String title;
  final String description;
  final String tag;
  final IconData icon;
  final WidgetBuilder builder;

  const AnimationDemo({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.icon,
    required this.builder,
  });
}
