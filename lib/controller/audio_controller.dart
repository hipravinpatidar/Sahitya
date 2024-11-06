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

  Future<void> playMusic(Verse music, int? chapterId) async {
    print("This method is working first");

    try {
      final directory = await getApplicationDocumentsDirectory();
      // Correct file path with chapterId
      final audioFile = io.File('${directory.path}/chapter_$chapterId${music.verse}.mp3');

      if (await audioFile.exists()) {
        // Update current music and isPlaying state immediately so the UI can reflect it
        _currentMusic = music;
        _currentIndex = _playlist.indexOf(music);
        _isPlaying = true;
        _isMusicBarVisible = true;
        notifyListeners();  // Update the UI now

        print("Starting to play music");

        // Play the audio using the file URL
        await _audioPlayer.setUrl('file://${audioFile.path}');
        await _audioPlayer.play();  // Ensure to await this for smooth transitions

        // Print updated state
        print("Play Music Is $_isPlaying");
        print("My Current Music Is $_currentMusic");

        // Listen for duration changes
        _audioPlayer.durationStream.listen((duration) {
          _duration = duration ?? Duration.zero;
          notifyListeners();
        });

        // Listen for position changes
        _audioPlayer.positionStream.listen((position) {
          _currentPosition = position;
          notifyListeners();
        });

        // Listen for player state changes (e.g., when the music finishes)
        _audioPlayer.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.completed) {
            // Song has completed playing, manage based on shuffle mode
            switch (_shuffleMode) {
              case ShuffleMode.playNext:
                skipNext(chapterId!); // Automatically skip to the next song
                break;
              case ShuffleMode.playOnceAndClose:
                pauseMusic();
                break;
              case ShuffleMode.playOnLoop:
                _audioPlayer.seek(Duration.zero);
                _audioPlayer.play(); // Play again from the start
                break;
            }
          }
          // Notify the listeners for any state changes
          notifyListeners();
        });

        // If using notifications for media control, update them here
        await _updateNotification();

      } else {
        // Handle the case where the audio file does not exist
        print("Audio file for verse ${music.verse} in chapter $chapterId not found");
      }
    } catch (error) {
      // Catch and print any errors
      print('Error playing music is : $error');
    }
  }

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

  void skipNext(int chapterId) {
    if (_currentMusic != null) {
      int currentIndexInPlaylist = _playlist.indexOf(_currentMusic!);

      print(" My Current Music  Index Is ${_currentIndex}");

      if (currentIndexInPlaylist < _playlist.length - 1) {
        _currentIndex = currentIndexInPlaylist + 1;
      } else {
        _currentIndex = 0;
      }

      playMusic(_playlist[_currentIndex],chapterId);
    }
  }

   skipPrevious({List<Verse>? fixedTabMusicList, required int chapterId}) {
    List<Verse> playlist = fixedTabMusicList ?? _playlist;

    if (_currentMusic != null) {
      int currentIndexInPlaylist = playlist.indexOf(_currentMusic!);

      if (currentIndexInPlaylist > 0) {
        _currentIndex = currentIndexInPlaylist - 1;
      } else {
        _currentIndex = playlist.length - 1;
      }

      playMusic(playlist[_currentIndex],chapterId);
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
