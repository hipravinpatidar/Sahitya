import 'dart:io' as io;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import '../model/shlokModel.dart';

enum ShuffleMode {
  playNext,
  playOnceAndClose,
  playOnLoop,
}

class AudioPlayerManager extends ChangeNotifier with WidgetsBindingObserver {
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _currentIndex = -1;
  bool _isPlaying = false;
  bool _isMusicBarVisible = false;

  Verse? _currentMusic;
  List<Verse> _playlist = [];

  Duration _duration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  ShuffleMode _shuffleMode = ShuffleMode.playNext;

  // Getters
  bool get isPlaying => _isPlaying;
  int get currentIndex => _currentIndex;
  Verse? get currentMusic => _currentMusic;
  bool get isMusicBarVisible => _isMusicBarVisible;
  Duration get duration => _duration;
  Duration get currentPosition => _currentPosition;
  ShuffleMode get shuffleMode => _shuffleMode;

  // Setters
  void setShuffleMode(ShuffleMode mode) {
    _shuffleMode = mode;
    notifyListeners();
  }

  void resetMusicBarVisibility() {
    _isMusicBarVisible = false;
  }

  void toggleMusicBarVisibility() {
    _isMusicBarVisible = !_isMusicBarVisible;
    notifyListeners();
  }

  void setPlaylist(List<Verse> playlist) {
    _playlist = playlist;
    _currentIndex = -1;
    notifyListeners();
  }


  Future<void> playMusic(
      Verse music,
      ) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final audioFile = io.File('${directory.path}/${music.verse}.mp3');

      if (await audioFile.existsSync()) {
        await _audioPlayer.setUrl('file://${audioFile.path}');
        _audioPlayer.play();
        _isMusicBarVisible = true;
        _currentMusic = music;
        _currentIndex = _playlist.indexOf(music);
        _isPlaying = true;
        _audioPlayer.durationStream.listen((duration) {
          _duration = duration ?? Duration.zero;
          notifyListeners();
        });

        _audioPlayer.positionStream.listen((position) {
          _currentPosition = position;
          notifyListeners();
        });

        _audioPlayer.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            switch (_shuffleMode) {
              case ShuffleMode.playNext:
                skipNext(); // Automatically skip to next
                break;
              case ShuffleMode.playOnceAndClose:
                pauseMusic();
                break;
              case ShuffleMode.playOnLoop:
                _audioPlayer.seek(Duration.zero);
                _audioPlayer.play();
                break;
            }
          }
        });

        await _updateNotification();
        notifyListeners();
      } else {
        // Handle the case when the audio file does not exist
        print("Audio file not found");
      }
    } catch (error) {
      print('Error playing music: $error');
    }
  }



  // Future<void> playMusic(
  //   Verse music,
  // ) async {
  //   try {
  //     await _audioPlayer.setUrl(music.verseData?.audioUrl ?? '');
  //     _audioPlayer.play();
  //     _isMusicBarVisible = true;
  //     _currentMusic = music;
  //     _currentIndex = _playlist.indexOf(music);
  //     _isPlaying = true;
  //     _audioPlayer.durationStream.listen((duration) {
  //       _duration = duration ?? Duration.zero;
  //       notifyListeners();
  //     });
  //
  //     _audioPlayer.positionStream.listen((position) {
  //       _currentPosition = position;
  //       notifyListeners();
  //     });
  //
  //     _audioPlayer.playerStateStream.listen((state) {
  //       if (state.processingState == ProcessingState.completed) {
  //         switch (_shuffleMode) {
  //           case ShuffleMode.playNext:
  //             skipNext(); // Automatically skip to next
  //             break;
  //           case ShuffleMode.playOnceAndClose:
  //             pauseMusic();
  //             break;
  //           case ShuffleMode.playOnLoop:
  //             _audioPlayer.seek(Duration.zero);
  //             _audioPlayer.play();
  //             break;
  //         }
  //       }
  //     });
  //
  //     await _updateNotification();
  //     notifyListeners();
  //   } catch (error) {
  //     print('Error playing music: $error');
  //   }
  // }


  void stopMusic(){
    _audioPlayer.stop();
    _isPlaying = false;
    _isMusicBarVisible = false;
    notifyListeners();

  }

  void togglePlayPause() async {
    if (_isPlaying) {
      pauseMusic();
    } else {
      if (_currentMusic != null) {
        _audioPlayer.play();
        _isPlaying = true;
        await _updateNotification();
        notifyListeners();
      }
    }
  }

  void pauseMusic() async {
    _audioPlayer.pause();
    _isPlaying = false;
    await _updateNotification();
    notifyListeners();
  }

  void skipNext() {
    if (_currentMusic != null) {
      int currentIndexInPlaylist = _playlist.indexOf(_currentMusic!);

      print(" My Current Music  Index Is ${_currentIndex}");

      if (currentIndexInPlaylist < _playlist.length - 1) {
        _currentIndex = currentIndexInPlaylist + 1;
      } else {
        _currentIndex = 0;
      }

      playMusic(_playlist[_currentIndex]);
    }
  }

  void skipPrevious({List<Verse>? fixedTabMusicList}) {
    List<Verse> playlist = fixedTabMusicList ?? _playlist;

    if (_currentMusic != null) {
      int currentIndexInPlaylist = playlist.indexOf(_currentMusic!);

      if (currentIndexInPlaylist > 0) {
        _currentIndex = currentIndexInPlaylist - 1;
      } else {
        _currentIndex = playlist.length - 1;
      }

      playMusic(playlist[_currentIndex]);
    }
  }

  void seekTo(Duration position) {
    _audioPlayer.seek(position);
    _currentPosition = position;
    notifyListeners();
  }

  Future<void> _updateNotification() async {
    // Add code for updating the notification with current music info
  }
}
