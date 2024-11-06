import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:share_plus/share_plus.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../ui_helpers/custom_colors.dart';

class BhawarthScreen extends StatefulWidget {
  final String? musicLyrics;
  final String? musicName;

  BhawarthScreen({
    super.key, this.musicLyrics, this.musicName,
  });

  @override
  State<BhawarthScreen> createState() => _BhawarthScreenState();
}

class _BhawarthScreenState extends State<BhawarthScreen> {
  int _currentIndex = 0;
  bool _isBlackBackground = false;
  double _textScaleFactor = 1.0;
  final double _scaleIncrement = 0.1;
  bool _isAutoScrolling = false;
  double _scrollSpeed = 2.0;
  late Timer _scrollTimer;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // Method to share content
  void _shareContent() {
    String contentToShare = widget.musicLyrics?? '';
    Share.share(contentToShare, subject: 'Check out this blog!');
  }

  // Method to show a SnackBar and copy content to clipboard
  void _showCopyMessage() {
    String parsedText = html_parser.parse(widget.musicLyrics ?? '').body?.text ?? '';
    Clipboard.setData(ClipboardData(text: parsedText)); // Copy parsed text to clipboard

    const snackBar = SnackBar(
      content: Text('Content copied!'),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _toggleAutoScroll() {
    setState(() {
      _isAutoScrolling = !_isAutoScrolling;

      if (_isAutoScrolling) {
        _scrollTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if (_scrollController.position.pixels <
              _scrollController.position.maxScrollExtent) {
            _scrollController.animateTo(
              _scrollController.position.pixels + _scrollSpeed,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          } else {
            _scrollController.jumpTo(0);
          }
        });
      } else {
        _scrollTimer.cancel();
      }
    });
  }

  void _onBottomNavTap(int index) {
    if (index != 5) {
      if (_isAutoScrolling) {
        _toggleAutoScroll();
      }
    }

    setState(() {
      _currentIndex = index;

      if (index == 0) {
        _isBlackBackground = !_isBlackBackground;
      } else if (index == 1) {
        _textScaleFactor += _scaleIncrement;
      } else if (index == 2) {
        _textScaleFactor -= _scaleIncrement;
        if (_textScaleFactor < 0.1) {
          _textScaleFactor = 0.1;
        }
      } else if (index == 3) {
        _shareContent();
      } else if (index == 4) {
        _showCopyMessage();
      } else if (index == 5) {
        _toggleAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String parsedText = html_parser.parse(widget.musicLyrics ?? '').body?.text ?? '';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white.withOpacity(0.2),
        title: Text(
          widget.musicName ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.orange,
            fontSize: screenWidth * 0.05,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black87, size: screenWidth * 0.07),
        ),

      ),
      backgroundColor: _isBlackBackground ? Colors.black : Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: SingleChildScrollView(
            controller: _scrollController,
            child:
            Column(
              children: [

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Text(
                          parsedText,
                          textAlign: TextAlign.center,
                          // languageProvider. ? parsedText : '',
                          style: TextStyle(
                            color: _isBlackBackground ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth * 0.04 * _textScaleFactor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
      bottomNavigationBar:

      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_currentIndex == 5)

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    "Adjust Scroll Speed",
                    style: TextStyle(
                        color: _isBlackBackground ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  Slider(
                    value: _scrollSpeed,
                    activeColor: Colors.brown,
                    inactiveColor: Colors.black.withOpacity(0.5),
                    min: 1.0,
                    max: 10.0,
                    divisions: 10,
                    label: _scrollSpeed.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _scrollSpeed = value;
                      });
                    },
                  ),
                ],
              ),
            ),

          BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: CustomColors.clrorange,
            onTap: _onBottomNavTap,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.sunny, color: Colors.black),
                label: 'Theme',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_increase_outlined, color: Colors.black),
                label: 'Zoom In',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.text_decrease, color: Colors.black),
                label: 'Zoom Out',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.share_outlined, color: Colors.black),
                label: 'Share',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.save, color: Colors.black),
                label: 'Copy',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.slideshow, color: Colors.black),
                label: 'Slide',
              ),
            ],
          ),
        ],
      ),
    );
  }
}