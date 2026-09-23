import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class SoundService {
  SoundService._();
  static final SoundService instance = SoundService._();

  final AudioPlayer _bellPlayer = AudioPlayer();
  final AudioPlayer _shankhPlayer = AudioPlayer();
  final AudioPlayer _japaPlayer = AudioPlayer();

  Uint8List? _shankhBytes;
  Uint8List? _bellBytes;
  Uint8List? _japaBytes;

  Future<void> preload() async {
    try {
      final b1 = await rootBundle.load('assets/audio/shankh.mp3');
      _shankhBytes = b1.buffer.asUint8List(b1.offsetInBytes, b1.lengthInBytes);
    } catch (_) {
      try {
        final b1 = await rootBundle.load('assets/audio/shankh.wav');
        _shankhBytes = b1.buffer.asUint8List(b1.offsetInBytes, b1.lengthInBytes);
      } catch (_) {}
    }
    try {
      final b2 = await rootBundle.load('assets/audio/temple_bell.wav');
      _bellBytes = b2.buffer.asUint8List(b2.offsetInBytes, b2.lengthInBytes);
    } catch (_) {}
    try {
      final b3 = await rootBundle.load('assets/audio/japa_bead.wav');
      _japaBytes = b3.buffer.asUint8List(b3.offsetInBytes, b3.lengthInBytes);
    } catch (_) {}
  }

  Future<void> playTempleBell() async {
    try {
      HapticFeedback.heavyImpact();
      try {
        await _bellPlayer.stop();
      } catch (_) {}
      await _bellPlayer.setVolume(1.0);
      await _bellPlayer.setReleaseMode(ReleaseMode.stop);

      if (_bellBytes != null) {
        await _bellPlayer.play(BytesSource(_bellBytes!));
      } else {
        try {
          final data = await rootBundle.load('assets/audio/temple_bell.wav');
          _bellBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          await _bellPlayer.play(BytesSource(_bellBytes!));
        } catch (_) {
          await _bellPlayer.play(AssetSource('audio/temple_bell.wav'));
        }
      }
    } catch (e) {
      debugPrint('Error playing bell: $e');
    }
  }

  Future<void> playShankh() async {
    try {
      HapticFeedback.heavyImpact();
      try {
        await _shankhPlayer.stop();
      } catch (_) {}
      await _shankhPlayer.setVolume(1.0);
      await _shankhPlayer.setReleaseMode(ReleaseMode.stop);

      if (_shankhBytes != null) {
        await _shankhPlayer.play(BytesSource(_shankhBytes!));
      } else {
        try {
          final data = await rootBundle.load('assets/audio/shankh.mp3');
          _shankhBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          await _shankhPlayer.play(BytesSource(_shankhBytes!));
        } catch (_) {
          try {
            await _shankhPlayer.play(AssetSource('audio/shankh.mp3'));
          } catch (_) {
            await _shankhPlayer.play(AssetSource('audio/shankh.wav'));
          }
        }
      }
    } catch (e) {
      debugPrint('Error playing shankh: $e');
    }
  }

  Future<void> playJapaBead() async {
    try {
      HapticFeedback.mediumImpact();
      try {
        await _japaPlayer.stop();
      } catch (_) {}
      await _japaPlayer.setVolume(0.9);
      await _japaPlayer.setReleaseMode(ReleaseMode.stop);

      if (_japaBytes != null) {
        await _japaPlayer.play(BytesSource(_japaBytes!));
      } else {
        try {
          final data = await rootBundle.load('assets/audio/japa_bead.wav');
          _japaBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
          await _japaPlayer.play(BytesSource(_japaBytes!));
        } catch (_) {
          await _japaPlayer.play(AssetSource('audio/japa_bead.wav'));
        }
      }
    } catch (e) {
      debugPrint('Error playing japa bead: $e');
    }
  }

  void dispose() {
    _bellPlayer.dispose();
    _shankhPlayer.dispose();
    _japaPlayer.dispose();
  }
}
