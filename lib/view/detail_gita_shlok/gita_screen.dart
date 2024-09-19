import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahityadesign/controller/audio_controller.dart';
import 'package:sahityadesign/controller/bookmark_provider.dart';
import 'package:sahityadesign/controller/settings_controller.dart';
import 'package:sahityadesign/view/bookmarkscreen.dart';
import '../../api_service/api_service.dart';
import '../../model/chapters_model.dart';
import '../../ui_helpers/custom_colors.dart';
import '../../utils/circle_container.dart';
import '../../utils/music_bar.dart';
import '../share_screen.dart';
import 'package:html/parser.dart' as html_parser;

class GitaScreen extends StatefulWidget {
  const GitaScreen(
      {super.key,
      this.myId,
      this.chapterName,
      this.chapterImage,
      this.chapterHindiName});

  final int? myId;
  final String? chapterName;
  final String? chapterHindiName;
  final String? chapterImage;

  @override
  State<GitaScreen> createState() => _GitaScreenState();
}

class _GitaScreenState extends State<GitaScreen> {
  bool isLoading = false;
  bool _showBookFormate = false;

  String _selectedChap = 'Chapter 1';
  String _selectedFont = 'OpenSans';
  String _selectedType = 'PlayNext';
  String _selectedLang = 'Hindi';

  double _textSize = 15.0;

  int? _currentPlayingIndex;
  final int _highlightedIndex = -1;

  late List<GlobalKey> itemKeys = [];
  late AudioPlayerManager audioManager = AudioPlayerManager();
  late SettingsProvider settingsProvider = SettingsProvider();
  late BookmarkProvider bookmarkProvider = BookmarkProvider();

  final List<String> _chapOptions = [
    'Chapter 1',
    'Chapter 2',
    'Chapter 3',
    'Chapter 5',
    'Chapter 6',
    'Chapter 7',
    'Chapter 8',
    'Chapter 9',
    'Chapter 10',
    'Chapter 11',
    'Chapter 12',
  ];

  final List<String> _fontOptions = [
    'OpenSans',
    'Inter',
    'Lato',
    'Roboto',
  ];

  final List<String> _typeOptions = [
    'PlayNext',
    'PlayClose',
    'PlayLoop',
  ];

  final List<String> _langOptions = [
    'Hindi',
    'Bangla',
    'Assamese',
    'Gujrati',
    'Marathi',
    'Punjabi',
    'Maithili',
    'Kannada',
    'Malayalam',
    'Tamil',
    'Telugu',
  ];

  List<Verse> chapterData = [];

  Future<void> getChapters() async {
    print(" My Data ${widget.myId}");
    setState(() {
      isLoading = true;
    });
    try {
      final ApiService apiService = ApiService();
      final res = await apiService.getChapters(
          "https://mahakal.rizrv.in/api/v1/sahitya/bhagvad-geeta?chapter=${widget.myId}");

      if (res != null) {
        final jsonString = jsonEncode(res); // Convert res to a JSON string
        final chaptersModel = chaptersModelFromJson(jsonString);

        setState(() {
          // Assuming you want to get verses from the first chapter
          if (chaptersModel.data!.isNotEmpty) {
            chapterData = chaptersModel.data![0].verses!;
            audioManager.setPlaylist(chapterData);
          } else {
            chapterData = []; // Handle case where there are no chapters
          }
          isLoading = false;
        });

        print("Verse length is ${chapterData.length}");
      } else {
        print('No data received');
      }
    } catch (e) {
      print("Error is ${e}");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    audioManager = Provider.of<AudioPlayerManager>(context);
  }

  @override
  void initState() {
    super.initState();
    //  Initialize AudioPlayerManager
    audioManager = Provider.of<AudioPlayerManager>(context, listen: false);

    // Listen for changes in current index
    audioManager.addListener(() {
      if (audioManager.currentIndex != _currentPlayingIndex) {
        print("My Audio Current Index is ${audioManager.currentIndex}");
        setState(() {
          _currentPlayingIndex = audioManager.currentIndex;
          print("$_currentPlayingIndex");
        });
      }
    });

    getChapters();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Music Listein Type
  void _updateType(String value) {
    switch (value) {
      case 'PlayNext':
        return audioManager.setShuffleMode(ShuffleMode.playNext);
      case 'PlayClose':
        return audioManager.setShuffleMode(ShuffleMode.playOnceAndClose);
      case 'PlayLoop':
        return audioManager.setShuffleMode(ShuffleMode.playOnLoop);
      default:
        throw ArgumentError('Invalid shuffle mode');
    }
  }

  void _updateLang(String value) {
    setState(() {
      _selectedLang = value;
    });
  }

  void myText(double size) {
    setState(() {
      _textSize = size;
    });
  }

  // Book Formate
  onBookFormate() {
    setState(() {
      _showBookFormate = !_showBookFormate;
    });
  }

  // Bottom Sheet for customize
  void _showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: CustomColors.clrwhite,
      context: context,
      builder: (context) {
        var screenHeight = MediaQuery.of(context).size.height;
        var screenWidth = MediaQuery.of(context).size.width;
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return SizedBox(
            height: screenHeight * 0.8,
            child: Column(
              children: [
                // Fonts Styles
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Icon(
                        Icons.text_rotation_none_outlined,
                        size: screenWidth * 0.06,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      Text(
                        "Font type",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Roboto',
                            color: CustomColors.clrblack),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: DropdownButton<String>(
                          iconEnabledColor: CustomColors.clrblack,
                          value: _selectedFont,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFont = newValue ?? '';
                            });
                            settingsProvider.updateFont(_selectedFont);
                          },
                          items: _fontOptions.map((String font) {
                            return DropdownMenuItem<String>(
                              value: font,
                              child: Text(
                                font,
                                style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    color: CustomColors.clrblack),
                              ),
                            );
                          }).toList(),

                          // remove the default elevation
                          dropdownColor: Colors
                              .white, // change the dropdown background color
                          borderRadius: BorderRadius.circular(
                              5), // make the dropdown button rounded
                          alignment:
                              Alignment.center, // center the dropdown button
                          underline: Container(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Slider(Increase Size)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Icon(
                        Icons.text_fields_rounded,
                        size: screenWidth * 0.06,
                        color: CustomColors.clrblack,
                      ),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      Text(
                        "Font size",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Roboto',
                            color: CustomColors.clrblack),
                      ),
                      const Spacer(),
                      Consumer<SettingsProvider>(
                        builder: (BuildContext context, settingsProvider,
                            Widget? child) {
                          return Slider(
                            value: settingsProvider.fontSize,
                            min: 12,
                            max: 25,
                            divisions: 12,
                            label: '${settingsProvider.fontSize.round()}',
                            onChanged: (double value) {
                              settingsProvider.updateFontSize(value);
                            },
                            activeColor: Colors.orange,
                            thumbColor: Colors.orange,
                            inactiveColor: Colors.black,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Light & Dark
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.lightbulb_outline,
                        size: screenWidth * 0.06,
                        color: CustomColors.clrblack,
                      ),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      Text(
                        "Light & Dark",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: CustomColors.clrblack,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Consumer<SettingsProvider>(
                        builder: (BuildContext context, settingsProvider,
                            Widget? child) {
                          return GestureDetector(
                            onTap: () {
                              settingsProvider.onClickIt();
                            },
                            //onTap: ,
                            child: Container(
                              width: screenWidth * 0.2,
                              height: screenWidth * 0.09,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: settingsProvider.isOn
                                    ? Colors.orange
                                    : CustomColors
                                        .clrblack, // <--- swapped colors
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: settingsProvider.isOn
                                            ? Colors.white
                                            : CustomColors
                                                .clrblack, // <--- swapped colors
                                      ),
                                      child: Center(
                                        child: Text(
                                          settingsProvider.isOn ? 'ON' : 'OFF',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            color: settingsProvider.isOn
                                                ? Colors.orange
                                                : Colors
                                                    .white, // <--- swapped colors
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.07,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: settingsProvider.isOn
                                          ? Colors.orange
                                          : CustomColors
                                              .clrblack, // <--- swapped colors
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),

                // Themes
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.color_lens_outlined,
                        size: screenWidth * 0.06,
                        color: CustomColors.clrblack,
                      ),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      Text(
                        "Themes",
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: CustomColors.clrblack,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Consumer<SettingsProvider>(
                        builder: (BuildContext context, settingsProvider,
                            Widget? child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CircleContainer(
                                color: Colors.yellow,
                                onTap: () {
                                  settingsProvider
                                      .changeTextColor(Colors.yellow);
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              CircleContainer(
                                color: Colors.white,
                                onTap: () {
                                  settingsProvider
                                      .changeTextColor(Colors.white);
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              CircleContainer(
                                color: Colors.orange,
                                onTap: () {
                                  settingsProvider
                                      .changeTextColor(Colors.orange);
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              CircleContainer(
                                color: Colors.tealAccent,
                                onTap: () {
                                  settingsProvider
                                      .changeTextColor(Colors.tealAccent);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        width: screenWidth * 0.04,
                      ),
                    ],
                  ),
                ),

                const Divider(),

                // Select language
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language,
                        size: screenWidth * 0.06,
                        color: Colors.black,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        "Select Language",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Roboto',
                            color: CustomColors.clrblack),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Consumer<SettingsProvider>(
                          builder: (BuildContext context, settingsProvider,
                              Widget? child) {
                            return DropdownButton<String>(
                              iconEnabledColor: CustomColors.clrblack,
                              value: _selectedLang,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedLang = newValue ?? '';
                                });
                                _updateLang(_selectedLang);
                              },
                              items: _langOptions.map((String font) {
                                return DropdownMenuItem<String>(
                                  value: font,
                                  child: Text(
                                    font,
                                    style: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        color: CustomColors.clrblack),
                                  ),
                                );
                              }).toList(),

                              // remove the default elevation
                              dropdownColor: Colors
                                  .white, // change the dropdown background color
                              borderRadius: BorderRadius.circular(
                                  5), // make the dropdown button rounded
                              alignment: Alignment
                                  .center, // center the dropdown button
                              underline: Container(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Translation Hindi
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Icon(Icons.menu_book_sharp,
                          color: CustomColors.clrblack,
                          size: screenWidth * 0.06),
                      SizedBox(width: screenWidth * 0.02),
                      Text("Translation",
                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: CustomColors.clrblack,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Consumer<SettingsProvider>(
                        builder: (BuildContext context, settingsProvider,
                            Widget? child) {
                          return GestureDetector(
                            onTap: () {
                              settingsProvider.updateHindiText();
                            },
                            child: Container(
                              width: screenWidth * 0.12,
                              height: screenWidth * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                color: settingsProvider.showHindiText
                                    ? Colors.orange
                                    : CustomColors.clrblack,
                              ),
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    left: settingsProvider.showHindiText
                                        ? screenWidth * 0.06
                                        : 0,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenWidth * 0.002),
                                      child: Container(
                                        width: screenWidth * 0.05,
                                        height: screenWidth * 0.05,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),

                // Translitration  English
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Icon(Icons.menu_book,
                          color: CustomColors.clrblack,
                          size: screenWidth * 0.06),
                      SizedBox(width: screenWidth * 0.02),
                      Text("Translitration",
                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: CustomColors.clrblack,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Consumer<SettingsProvider>(
                        builder: (BuildContext context, settingsProvider,
                            Widget? child) {
                          return GestureDetector(
                            onTap: () {
                              settingsProvider.updateEnglishText();
                            },
                            child: Container(
                              width: screenWidth * 0.12,
                              height: screenWidth * 0.06,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                                color: settingsProvider.showEnglishText
                                    ? Colors.orange
                                    : CustomColors.clrblack,
                              ),
                              child: Stack(
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    left: settingsProvider.showEnglishText
                                        ? screenWidth * 0.06
                                        : 0,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenWidth * 0.002),
                                      child: Container(
                                        width: screenWidth * 0.05,
                                        height: screenWidth * 0.05,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),

                // Book Foramate
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Icon(Icons.book_outlined,
                          color: CustomColors.clrblack,
                          size: screenWidth * 0.06),
                      SizedBox(width: screenWidth * 0.02),
                      Text("Book Formate",
                          style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: CustomColors.clrblack,
                              fontWeight: FontWeight.w600)),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {});
                          onBookFormate();
                        },
                        child: Container(
                          width: screenWidth * 0.12,
                          height: screenWidth * 0.06,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                            color: _showBookFormate
                                ? Colors.orange
                                : CustomColors.clrblack,
                          ),
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                left: _showBookFormate ? screenWidth * 0.06 : 0,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenWidth * 0.002),
                                  child: Container(
                                    width: screenWidth * 0.05,
                                    height: screenWidth * 0.05,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.05,
                      )
                    ],
                  ),
                ),

                // Select audio Type
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.03),
                  child: Row(
                    children: [
                      Icon(
                        Icons.audiotrack,
                        size: screenWidth * 0.06,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: screenWidth * 0.03,
                      ),
                      Text(
                        "Select audio Type",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04,
                            fontFamily: 'Roboto',
                            color: CustomColors.clrblack),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: DropdownButton<String>(
                          iconEnabledColor: CustomColors.clrblack,
                          value: _selectedType,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedType = newValue ?? '';
                            });
                            _updateType(newValue!);
                          },
                          items: _typeOptions.map((String font) {
                            return DropdownMenuItem<String>(
                              value: font,
                              child: Text(
                                font,
                                style: TextStyle(
                                    fontSize: screenWidth * 0.05,
                                    color: CustomColors.clrblack,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 1,
                              ),
                            );
                          }).toList(),

                          // remove the default elevation
                          dropdownColor: Colors
                              .white, // change the dropdown background color
                          borderRadius: BorderRadius.circular(
                              5), // make the dropdown button rounded
                          alignment:
                              Alignment.center, // center the dropdown button
                          underline: Container(),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(),
              ],
            ),
          );
        });
      },
    );
  }

  // Bottom Sheet for read hindi
  void _showTranslationBottomSheet(
      BuildContext context,
      String hindiDescription,
      int audioIndex,
      String englishDescription,
      String image) {
    String parsedLyrics = html_parser.parse(hindiDescription).body?.text ?? '';

    showModalBottomSheet(
      backgroundColor: CustomColors.clrwhite,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight = MediaQuery.of(context).size.height;

        return Stack(
          children: [
            SizedBox(
              height: screenHeight * 0.8,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenWidth * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        height: screenWidth * 0.03,
                      ),
                      Text(
                        parsedLyrics,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: _textSize, color: CustomColors.clrblack),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: screenWidth * 1.5,
                  right: screenWidth * 0.05,
                  left: screenWidth * 0.05),
              child: Row(
                children: [
                  SizedBox(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.9,
                    child: Slider(
                      value: _textSize,
                      min: 15,
                      max: 25,
                      divisions: 15,
                      label: '${_textSize.round()}',
                      onChanged: (double value) {
                        setState(() {
                          _textSize = value;
                        });
                        myText(value);
                      },
                      activeColor: CustomColors.clrorange,
                      thumbColor: CustomColors.clrblack,
                      inactiveColor: CustomColors.clrblack,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Dialog Box
  void showmeDialog(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: CustomColors.clrwhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bhagwat Geeta',
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.clrblack),
                ),
                SizedBox(height: screenWidth * 0.02),
                DropdownButton<String>(
                  //  iconDisabledColor: Colors.red,
                  iconEnabledColor: CustomColors.clrblack,
                  dropdownColor: CustomColors.clrwhite,
                  borderRadius: BorderRadius.circular(5),
                  value: _selectedChap,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedChap = newValue ?? '';
                    });
                  },
                  items: _chapOptions.map((String chap) {
                    return DropdownMenuItem<String>(
                      value: chap,
                      child: Text(
                        chap,
                        style: const TextStyle(color: CustomColors.clrblack),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: screenWidth * 0.04),
                Text(
                  'Shlok',
                  style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: CustomColors.clrblack),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Enter between 1 - 4',
                  style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: CustomColors.clrblack),
                ),
                SizedBox(height: screenWidth * 0.02),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: CustomColors.clrblack),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter Shlok Number',
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.clrggreytxt,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          color: CustomColors.clrblack,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CupertinoColors.activeBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'GO',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Consumer<SettingsProvider>(
      builder: (BuildContext context, settingsProvider, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: settingsProvider.isOn ? ThemeData.dark() : ThemeData.light(),
          home: SafeArea(
              child: Scaffold(
            body: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: CustomColors.clrblack,
                    backgroundColor: Colors.white,
                  ))
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        backgroundColor: settingsProvider.isOn
                            ? CustomColors.clrblack
                            : CustomColors.clrorange,
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back,
                              color: CustomColors.clrwhite,
                              size: screenWidth * 0.06),
                        ),
                        title: Text("Sahitya",
                            style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Roboto',
                                color: CustomColors.clrwhite)),
                        actions: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.08),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BookMark(),
                                        ));
                                  },
                                  child: Icon(
                                    Icons.bookmark,
                                    color: CustomColors.clrwhite,
                                    size: screenWidth * 0.06,
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _showBottomSheet();
                                  },
                                  child: Icon(
                                    Icons.settings,
                                    color: CustomColors.clrwhite,
                                    size: screenWidth * 0.06,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SliverAppBar(
                        backgroundColor: settingsProvider.isOn
                            ? CustomColors.clrwhite
                            : CustomColors.clrfavblue,
                        shadowColor: Colors.black,
                        toolbarHeight: _showBookFormate
                            ? screenWidth * 0.13
                            : screenWidth * 0.2,
                        automaticallyImplyLeading: false,
                        pinned: true,
                        flexibleSpace: _showBookFormate
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Hanuman Chalisa",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: settingsProvider.isOn
                                          ? CustomColors.clrblack
                                          : CustomColors.clrorange),
                                ),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.03),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: CustomColors.clrwhite,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: settingsProvider.isOn
                                                ? Colors.orangeAccent
                                                : CustomColors.clrbrown,
                                            width: screenWidth * 0.002,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Chapter',
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.03,
                                                  color: CustomColors.clrblack,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "${widget.myId}",
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  fontWeight: FontWeight.w700,
                                                  color: CustomColors.clrblack),
                                            ),
                                          ],
                                        ),
                                        // ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showmeDialog(context);
                                        },
                                        child: Container(
                                          width: screenWidth * 0.6,
                                          height: screenWidth * 0.2,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/image/frame.png"),
                                                  fit: BoxFit.cover)),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.08,
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: screenWidth * 0.05,
                                                ),
                                                SizedBox(
                                                    width: screenWidth * 0.3,
                                                    child: Text(
                                                      '${widget.chapterName}',
                                                      style: TextStyle(
                                                          fontSize:
                                                              screenWidth *
                                                                  0.04,
                                                          color: CustomColors
                                                              .clrblack,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      maxLines: 1,
                                                    )),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  size: screenWidth * 0.05,
                                                  color: CustomColors.clrblack,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: CustomColors.clrwhite,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: settingsProvider.isOn
                                                ? Colors.orangeAccent
                                                : CustomColors.clrbrown,
                                            width: screenWidth * 0.002,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Verse',
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.03,
                                                  color: CustomColors.clrblack,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '${chapterData.length}',
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  fontWeight: FontWeight.bold,
                                                  color: CustomColors.clrblack),
                                            ),
                                          ],
                                        ),
                                        //  ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            if (_showBookFormate)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.03,
                                    horizontal: screenWidth * 0.05),
                                child: Text(
                                  "In Progress",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Devanagari',
                                      color: settingsProvider.isOn
                                          ? settingsProvider.textColor
                                          : CustomColors.clrblack),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: chapterData.length,
                                itemBuilder: (context, index) {
                                  final verse = chapterData[index];
                                  final verseData = verse.verseData?.verseData;

                                  String displayedText = '';
                                  switch (_selectedLang) {
                                    case 'Hindi':
                                      displayedText = verseData?.hindi ?? '';
                                      break;
                                    case 'Bangla':
                                      displayedText = verseData?.bangla ?? '';
                                      break;
                                    case 'Assamese':
                                      displayedText = verseData?.assamese ?? '';
                                      break;
                                    case 'Gujrati':
                                      displayedText = verseData?.gujrati ?? '';
                                      break;
                                    case 'Marathi':
                                      displayedText = verseData?.marathi ?? '';
                                      break;
                                    case 'Punjabi':
                                      displayedText = verseData?.punjabi ?? '';
                                      break;
                                    case 'Maithili':
                                      displayedText = verseData?.maithili ?? '';
                                      break;
                                    case 'Kannada':
                                      displayedText = verseData?.kannada ?? '';
                                      break;
                                    case 'Malayalam':
                                      displayedText =
                                          verseData?.malayalam ?? '';
                                      break;
                                    case 'Tamil':
                                      displayedText = verseData?.tamil ?? '';
                                      break;
                                    case 'Telugu':
                                      displayedText = verseData?.telugu ?? '';
                                      break;
                                    default:
                                      displayedText =
                                          'Language not supported'; // Default message
                                      break;
                                  }

                                  return Column(
                                    children: [
                                      Container(
                                        color: _highlightedIndex == index
                                            ? Colors.cyanAccent.withOpacity(
                                                0.2) // Highlight color
                                            : settingsProvider.isOn
                                                ? CustomColors.clrblack
                                                : CustomColors.clrskin,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenWidth * 0.04,
                                              horizontal: screenWidth * 0.03),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: settingsProvider
                                                                .isOn
                                                            ? CustomColors
                                                                .clrwhite
                                                            : CustomColors
                                                                .clrblack,
                                                        width: 0.9)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                    "${chapterData[index].verse}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            screenWidth * 0.04),
                                                  ),
                                                ),
                                              ),
                                              Consumer<SettingsProvider>(
                                                builder: (BuildContext context,
                                                    settingsProvider,
                                                    Widget? child) {
                                                  return Text(
                                                    "${chapterData[index].verseData?.verseData?.sanskrit}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize:
                                                            settingsProvider
                                                                .fontSize,
                                                        color: settingsProvider
                                                                .isOn
                                                            ? settingsProvider
                                                                .textColor
                                                            : CustomColors
                                                                .clrblack,
                                                        fontFamily:
                                                            settingsProvider
                                                                .selectedFont),
                                                  );
                                                },
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          screenWidth * 0.05,
                                                      vertical:
                                                          screenWidth * 0.05),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                DialogRoute(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          ShareScreen(
                                                                    gitaShlok: chapterData[index]
                                                                            .verseData
                                                                            ?.verseData!
                                                                            .sanskrit ??
                                                                        '',
                                                                    shlokMeaning: chapterData[index]
                                                                            .verseData
                                                                            ?.verseData!
                                                                            .hindi ??
                                                                        '',
                                                                    detailsModel:
                                                                        chapterData[
                                                                            index],
                                                                    chapterName:
                                                                        widget
                                                                            .chapterHindiName,
                                                                    verseSerial:
                                                                        chapterData[index]
                                                                            .verse,
                                                                  ),
                                                                ));
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .share_outlined,
                                                            color: settingsProvider
                                                                    .isOn
                                                                ? CustomColors
                                                                    .clrwhite
                                                                : CustomColors
                                                                    .clrbrown,
                                                            size: screenWidth *
                                                                0.07,
                                                          )),
                                                      SizedBox(
                                                        width:
                                                            screenWidth * 0.03,
                                                      ),
                                                      Consumer<
                                                          BookmarkProvider>(
                                                        builder: (BuildContext
                                                                context,
                                                            bookmarkProvider,
                                                            Widget? child) {
                                                          final isBookmarked = bookmarkProvider
                                                              .bookMarkedShlokes
                                                              .any((bookmarked) =>
                                                                  bookmarked
                                                                      .verseData
                                                                      ?.audioUrl ==
                                                                  chapterData[
                                                                          index]
                                                                      .verseData
                                                                      ?.audioUrl);

                                                          return GestureDetector(
                                                            onTap: () {
                                                              bookmarkProvider
                                                                  .toggleBookmark(
                                                                      chapterData[
                                                                          index]);
                                                            },
                                                            child: Icon(
                                                              isBookmarked
                                                                  ? Icons
                                                                      .bookmark
                                                                  : Icons
                                                                      .bookmark_border,
                                                              color: settingsProvider
                                                                      .isOn
                                                                  ? CustomColors
                                                                      .clrwhite
                                                                  : CustomColors
                                                                      .clrbrown,
                                                              size:
                                                                  screenWidth *
                                                                      0.07,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    screenHeight *
                                                                        0.08),
                                                        child: Consumer<
                                                            AudioPlayerManager>(
                                                          builder: (BuildContext
                                                                  context,
                                                              audioManager,
                                                              Widget? child) {
                                                            return GestureDetector(
                                                                onTap: () {
                                                                  _showTranslationBottomSheet(
                                                                      context,
                                                                      chapterData[index]
                                                                              .hiDescription ??
                                                                          '',
                                                                      index,
                                                                      chapterData[index]
                                                                              .description ??
                                                                          '',
                                                                      widget.chapterImage ??
                                                                          '');
                                                                },
                                                                child: Text(
                                                                  "भावार्थ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red,
                                                                      fontSize:
                                                                          screenWidth *
                                                                              0.05),
                                                                ));
                                                          },
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Consumer<
                                                          AudioPlayerManager>(
                                                        builder: (BuildContext
                                                                context,
                                                            audioController,
                                                            Widget? child) {
                                                          bool
                                                              isCurrentSongPlaying =
                                                              audioController
                                                                      .isPlaying &&
                                                                  audioController
                                                                          .currentMusic ==
                                                                      chapterData[
                                                                          index];

                                                          return IconButton(
                                                            onPressed: () {
                                                              if (isCurrentSongPlaying) {
                                                                // Pause the current song
                                                                audioController
                                                                    .togglePlayPause();
                                                              } else {
                                                                if (audioController
                                                                        .currentMusic ==
                                                                    chapterData[
                                                                        index]) {
                                                                  // Resume the current song
                                                                  audioController
                                                                      .togglePlayPause();
                                                                } else {
                                                                  // Play the selected song
                                                                  audioController
                                                                      .playMusic(
                                                                          chapterData[
                                                                              index]);

                                                                  print(
                                                                      "Song clicked and played");
                                                                }
                                                              }

                                                              // Debugging: Print current state for verification
                                                              print(
                                                                  'isPlaying: ${audioController.isPlaying}');
                                                              print(
                                                                  'currentMusic: ${audioController.currentMusic}');
                                                            },
                                                            icon: Icon(
                                                              // Determine icon based on the state of the current song
                                                              isCurrentSongPlaying
                                                                  ? Icons
                                                                      .pause_circle
                                                                  : Icons
                                                                      .play_circle,
                                                              size:
                                                                  screenWidth *
                                                                      0.1,
                                                              color: settingsProvider
                                                                      .isOn
                                                                  ? CustomColors
                                                                      .clrwhite
                                                                  : CustomColors
                                                                      .clrbrown,
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  )
                                                  //   },
                                                  // )
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.02,
                                            vertical: screenWidth * 0.002),
                                        child: Consumer<SettingsProvider>(
                                          builder: (BuildContext context,
                                              settingsProvider, Widget? child) {
                                            return Column(
                                              children: [
                                                Visibility(
                                                  visible: settingsProvider
                                                      .showHindiText,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        displayedText,
                                                        // "${settingsProvider.displayedText}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize:
                                                                settingsProvider
                                                                    .fontSize,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Roboto',
                                                            color: Colors.blue),
                                                      ),
                                                      Container(
                                                        height:
                                                            screenWidth * 0.03,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: settingsProvider
                                                      .showEnglishText,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        chapterData[index]
                                                                .verseData!
                                                                .verseData
                                                                ?.english ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize:
                                                                settingsProvider
                                                                    .fontSize,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Roboto'),
                                                      ),
                                                      Divider(
                                                        color:
                                                            settingsProvider
                                                                    .isOn
                                                                ? CustomColors
                                                                    .clrorange
                                                                : CustomColors
                                                                    .clrblack,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                  //   },
                                  // );
                                },
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
               bottomNavigationBar: Consumer<AudioPlayerManager>(
               builder: (context, musicManager, child) {
                if (musicManager.isMusicBarVisible) {
                  return MusicBar(chapterHindiName: widget.chapterHindiName,verseSerial: chapterData[0].verse,chapterNumber: widget.myId,);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          )),
        );
      },
    );
  }
}
