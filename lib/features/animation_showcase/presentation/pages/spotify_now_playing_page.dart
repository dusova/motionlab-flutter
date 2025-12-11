import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

class SpotifyNowPlayingPage extends StatefulWidget {
  const SpotifyNowPlayingPage({super.key});

  @override
  State<SpotifyNowPlayingPage> createState() => _SpotifyNowPlayingPageState();
}

class _SpotifyNowPlayingPageState extends State<SpotifyNowPlayingPage>
    with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  late final AnimationController _pulseController;
  late final AudioPlayer _audioPlayer;

  bool _isLoading = true;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  static const List<Map<String, String>> _playlist = [
    {
      'title': 'We Could Be the Same',
      'artist': 'maNga',
      'asset': 'assets/audio/song1.mp3',
    },
    {
      'title': 'Everyway That I Can',
      'artist': 'Sertab Erener',
      'asset': 'assets/audio/song2.mp3',
    },
    {
      'title': 'Düm Tek Tek',
      'artist': 'Hadise',
      'asset': 'assets/audio/song3.mp3',
    },
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null && mounted) {
        setState(() => _duration = duration);
      }
    });

    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() => _position = position);
      }
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        if (state.playing) {
          _lottieController.repeat();
          _isLoading = false;
        } else {
          _lottieController.stop();
        }
        setState(() {});
      }
    });

    await _loadCurrentSong();
  }

  Future<void> _loadCurrentSong() async {
    setState(() {
      _isLoading = true;
      _duration = Duration.zero;
      _position = Duration.zero;
    });
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAsset(_playlist[_currentIndex]['asset']!);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Muzik yukleme hatasi: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _togglePlay() {
    HapticFeedback.lightImpact();
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void _playNext() {
    HapticFeedback.lightImpact();
    _currentIndex = (_currentIndex + 1) % _playlist.length;
    _loadCurrentSong();
  }

  void _playPrevious() {
    HapticFeedback.lightImpact();
    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    _loadCurrentSong();
  }

  void _seekTo(double value) {
    final position = Duration(
      milliseconds: (value * _duration.inMilliseconds).toInt(),
    );
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    _pulseController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _audioPlayer.playing;
    final progress = _duration.inMilliseconds > 0
        ? _position.inMilliseconds / _duration.inMilliseconds
        : 0.0;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF09090B),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.5),
                      radius: 1.2 + (_pulseController.value * 0.1),
                      colors: [
                        const Color(0xFF1DB954).withOpacity(0.15),
                        const Color(0xFF09090B),
                      ],
                    ),
                  ),
                );
              },
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          iconSize: 32,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            const Text(
                              'SU ANDA CALINIYOR',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF71717A),
                                letterSpacing: 1.5,
                              ),
                            ),
                            const Text(
                              '"Eurovision Türkiye Şarkıları 🇹🇷"',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF71717A),
                                letterSpacing: 1.5,
                              ),
                            ),
                            if (_isLoading)
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF1DB954),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_horiz_rounded),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: isPlaying
                            ? 1.0 + (_pulseController.value * 0.02)
                            : 1.0,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF1DB954,
                            ).withOpacity(isPlaying ? 0.4 : 0.2),
                            blurRadius: isPlaying ? 80 : 40,
                            spreadRadius: isPlaying ? 15 : 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF1DB954),
                                    Color(0xFF191414),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                            Center(
                              child: Icon(
                                isPlaying
                                    ? Icons.music_note_rounded
                                    : Icons.music_off_rounded,
                                size: 80,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        Text(
                          _playlist[_currentIndex]['title']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_playlist[_currentIndex]['artist']} • Şarkı ${_currentIndex + 1}/${_playlist.length}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF71717A),
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 80,
                          child: Lottie.asset(
                            'assets/animations/equalizer.json',
                            controller: _lottieController,
                            fit: BoxFit.contain,
                            onLoaded: (composition) {
                              _lottieController.duration = composition.duration;
                              if (_audioPlayer.playing) {
                                _lottieController.repeat();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 4,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 14,
                            ),
                            activeTrackColor: const Color(0xFF1DB954),
                            inactiveTrackColor: const Color(0xFF27272A),
                            thumbColor: Colors.white,
                            overlayColor: Colors.white.withOpacity(0.1),
                          ),
                          child: Slider(
                            value: progress.clamp(0.0, 1.0),
                            onChanged: _seekTo,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(_position),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF71717A),
                                ),
                              ),
                              Text(
                                _formatDuration(_duration),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF71717A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shuffle_rounded),
                          color: const Color(0xFF71717A),
                          iconSize: 24,
                        ),
                        IconButton(
                          onPressed: _playPrevious,
                          icon: const Icon(Icons.skip_previous_rounded),
                          color: Colors.white,
                          iconSize: 36,
                        ),
                        GestureDetector(
                          onTap: _togglePlay,
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(36),
                            ),
                            child: _isLoading
                                ? const Center(
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    isPlaying
                                        ? Icons.pause_rounded
                                        : Icons.play_arrow_rounded,
                                    color: Colors.black,
                                    size: 36,
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: _playNext,
                          icon: const Icon(Icons.skip_next_rounded),
                          color: Colors.white,
                          iconSize: 36,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.repeat_rounded),
                          color: const Color(0xFF71717A),
                          iconSize: 24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final mins = duration.inMinutes.toString();
    final secs = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }
}
