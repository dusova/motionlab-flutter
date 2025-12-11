import 'package:flutter/material.dart';

import '../domain/animation_demo.dart';
import '../presentation/pages/duolingo_celebration_page.dart';
import '../presentation/pages/spotify_now_playing_page.dart';

class DemoAnimations {
  static final all = <AnimationDemo>[
    AnimationDemo(
      id: 'duolingo_celebration',
      title: 'Duolingo Kutlama Ekranı',
      description:
          'AnimatedBuilder ile ölçekleme, hafif sallanma ve glow efektiyle seviye tamamlama animasyonu.',
      tag: 'AnimatedBuilder • Custom',
      icon: Icons.emoji_events,
      builder: (context) => const DuolingoCelebrationPage(),
    ),
    AnimationDemo(
      id: 'spotify_now_playing',
      title: 'Spotify Now Playing',
      description:
          'Lottie ile equalizer tabanlı Now Playing ekranı. Yüksek seviyeli animasyon kontrolü.',
      tag: 'Lottie • Asset Based',
      icon: Icons.graphic_eq,
      builder: (context) => const SpotifyNowPlayingPage(),
    ),
  ];
}
