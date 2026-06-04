import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../../features/exercise_session/application/session_state.dart';

/// Plays short cue sounds at timer phase transitions. Missing asset files are
/// swallowed so the app keeps working before real audio is added (see
/// assets/audio/README.md).
class AudioCues {
  final AudioPlayer _player = AudioPlayer(playerId: 'timer_cues');

  static const _assetForPhase = {
    TimerPhase.squeeze: 'audio/squeeze.mp3',
    TimerPhase.hold: 'audio/hold.mp3',
    TimerPhase.release: 'audio/release.mp3',
    TimerPhase.rest: 'audio/rest.mp3',
  };

  Future<void> playPhase(TimerPhase phase) async {
    final asset = _assetForPhase[phase];
    if (asset == null) return;
    await _safePlay(asset);
  }

  Future<void> playDone() => _safePlay('audio/done.mp3');

  Future<void> _safePlay(String asset) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(asset));
    } catch (e) {
      // Asset not bundled yet, or platform without audio — ignore.
      if (kDebugMode) debugPrint('AudioCues: could not play $asset ($e)');
    }
  }

  void dispose() => _player.dispose();
}
