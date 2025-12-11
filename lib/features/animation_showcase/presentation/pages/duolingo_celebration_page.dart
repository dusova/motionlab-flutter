import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DuolingoCelebrationPage extends StatefulWidget {
  const DuolingoCelebrationPage({super.key});

  @override
  State<DuolingoCelebrationPage> createState() =>
      _DuolingoCelebrationPageState();
}

class _DuolingoCelebrationPageState extends State<DuolingoCelebrationPage>
    with TickerProviderStateMixin {
  late final AnimationController _mainController;
  late final AnimationController _confettiController;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _scale = CurvedAnimation(parent: _mainController, curve: Curves.elasticOut);

    _rotation = Tween<double>(begin: -0.05, end: 0.05).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeInOut),
    );

    _mainController.forward();
    _confettiController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _replay() {
    HapticFeedback.mediumImpact();
    _mainController.reset();
    _confettiController.reset();
    _mainController.forward();
    _confettiController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF09090B),
        body: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.3),
                  radius: 1.5,
                  colors: [
                    const Color(0xFF58CC02).withOpacity(0.15),
                    const Color(0xFF09090B),
                  ],
                ),
              ),
            ),
            // Confetti particles
            ...List.generate(20, (index) {
              return _ConfettiParticle(
                controller: _confettiController,
                index: index,
              );
            }),
            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Top Bar
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded),
                          color: const Color(0xFF71717A),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Main Card
                  AnimatedBuilder(
                    animation: _mainController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotation.value,
                        child: Transform.scale(
                          scale: _scale.value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF18181B),
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: const Color(0xFF27272A)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF58CC02).withOpacity(0.2),
                            blurRadius: 60,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Trophy Icon
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF58CC02), Color(0xFF89E219)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF58CC02,
                                  ).withOpacity(0.4),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.emoji_events_rounded,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            'Seviye Tamamlandı!',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Bu dersi tamamladınız.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF71717A),
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // XP Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF58CC02).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFF58CC02).withOpacity(0.3),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.bolt_rounded,
                                  color: Color(0xFF58CC02),
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '+120 XP',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF58CC02),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Bottom Button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _replay,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF58CC02),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Animasyonu Tekrar Oynat',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfettiParticle extends StatelessWidget {
  final AnimationController controller;
  final int index;

  const _ConfettiParticle({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    final random = math.Random(index);
    final size = MediaQuery.of(context).size;

    final startX = random.nextDouble() * size.width;
    final endX = startX + (random.nextDouble() - 0.5) * 100;
    final startY = -50.0;
    final endY = size.height + 50;

    final colors = [
      const Color(0xFF58CC02),
      const Color(0xFFFFD700),
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
      const Color(0xFFAB47BC),
    ];

    final color = colors[index % colors.length];
    final delay = random.nextDouble() * 0.5;
    final particleSize = 6.0 + random.nextDouble() * 6;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final progress = ((controller.value - delay) / (1 - delay)).clamp(
          0.0,
          1.0,
        );
        final x = startX + (endX - startX) * progress;
        final y = startY + (endY - startY) * progress;
        final opacity = progress < 0.8 ? 1.0 : (1 - (progress - 0.8) / 0.2);
        final rotation = progress * math.pi * 4;

        return Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity,
            child: Transform.rotate(
              angle: rotation,
              child: Container(
                width: particleSize,
                height: particleSize,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
