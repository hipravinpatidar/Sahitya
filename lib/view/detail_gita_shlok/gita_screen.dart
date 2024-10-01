import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sahityadesign/controller/audio_controller.dart';
import 'package:sahityadesign/controller/bookmark_provider.dart';
import 'package:sahityadesign/controller/settings_controller.dart';
import 'package:sahityadesign/view/bookmarkscreen.dart';
import 'package:sahityadesign/view/gitastatic.dart';
import '../../api_service/api_service.dart';
import '../../model/shlokModel.dart';
import '../../ui_helpers/custom_colors.dart';
import '../../utils/circle_container.dart';
import '../../utils/music_bar.dart';
import '../share_screen.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;

class GitaScreen extends StatefulWidget {
  int? verseCount;
  GitaScreen(
      {super.key,
      this.myId,
      this.chapterName,
      this.chapterImage,
      this.chapterHindiName,required this.verseCount});

  final int? myId;
  final String? chapterName;
  final String? chapterHindiName;
  final String? chapterImage;


  @override
  State<GitaScreen> createState() => _GitaScreenState();
}

class _GitaScreenState extends State<GitaScreen> {
  bool isLoading = false;
  bool _hasInternet = false;
  bool _showBookFormate = false;

  String _selectedChap = 'Chapter 1';
  String _selectedFont = 'OpenSans';
  String _selectedType = 'PlayNext';
  String _selectedLang = 'Hindi';

  double _textSize = 15.0;

  int? _currentPlayingIndex;
  int _verse = 1;
  final int _highlightedIndex = -1;

  late List<GlobalKey> itemKeys = [];
  late AudioPlayerManager audioManager = AudioPlayerManager();
  late SettingsProvider settingsProvider = SettingsProvider();
  late BookmarkProvider bookmarkProvider = BookmarkProvider();

  ScrollController _scrollController = ScrollController();

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
    // Prevent multiple calls if already loading
    if (isLoading) return;

    // Check if all verses are already loaded
    if (widget.verseCount! == chapterData.length) return;

    setState(() {
      isLoading = true;
    });

    try {
      final ApiService apiService = ApiService();
      List<Verse> tempData = [];

      // Fetch verses in small batches
      for (int i = 1; i < (_verse > 4 ? 5 : 10); i++) {
        final res = await apiService.getChapters(
          "https://mahakal.rizrv.in/api/v1/sahitya/bhagvad-geeta?chapter=${widget.myId}&verse=$_verse",
        );

        if (res != null) {
          final jsonString = jsonEncode(res);
          final chaptersModel = ShlokModelFromJson(jsonString);

          if (chaptersModel.data!.isNotEmpty) {
            final newVerse = chaptersModel.data![0].verses![0];

            // Avoid duplicating verses in chapterData
            if (!chapterData.contains(newVerse)) {
              tempData.add(newVerse); // Add to temporary data

              setState(() {
                chapterData.add(newVerse); // Add to UI data
              });

              _verse++; // Increment the verse count

              // Save the data after fetching
              await saveDataLocally(chapterData, widget.myId);
            }
          } else {
            print('No chapters data available');
            break;
          }
        } else {
          print('No data received');
          break;
        }
      }

      // Update the playlist after fetching the data
      audioManager.setPlaylist(chapterData);

      // Check if the fetched data is incomplete (fetched verses < total verses)
      if (chapterData.length < widget.verseCount!) {
        print("Incomplete data, removing saved file.");
        await deleteLocalData(widget.myId);
      }

      setState(() {
        isLoading = false;
      });

    } catch (e) {
      print("Error fetching data for chapter ${widget.myId}: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveDataLocally(List<Verse> data, int? chapterId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final chapterFile = File('${directory.path}/chapter_$chapterId.json'); // Save each chapter in a separate file

      // Convert data to JSON and write to the file
      String jsonData = jsonEncode(data.map((e) => e.toJson()).toList());
      await chapterFile.writeAsString(jsonData);
      print("Data for chapter $chapterId saved locally");

      // Save audio files for each verse
      for (var verse in data) {
        if (verse.verseData?.audioUrl != null) {
          final audioFile = File('${directory.path}/chapter_$chapterId${verse.verse}.mp3');
          if (!await audioFile.exists()) {
            final response = await http.get(Uri.parse(verse.verseData!.audioUrl!));
            await audioFile.writeAsBytes(response.bodyBytes);
            print("Audio for verse ${verse.verse} in chapter $chapterId saved locally");
          }
          verse.verseData!.audioUrl = '${directory.path}/chapter_$chapterId${verse.verse}.mp3';
        }
      }

    } catch (e) {
      print("Error saving data locally for chapter $chapterId: $e");
    }
  }

// Check for internet connectivity and handle accordingly
  Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    // If no network at all (neither mobile data nor Wi-Fi)
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    // Try pinging a well-known server (like Google) to check actual internet access
    try {
      final result = await http.get(Uri.parse('https://google.com')).timeout(
        Duration(seconds: 5),
      );

      if (result.statusCode == 200) {
        return true; // Internet is working
      } else {
        return false; // Connected to network, but no internet access
      }
    } catch (e) {
      return false; // No internet access
    }
  }

  Future<void> loadChaptersFromLocal(int? chapterId) async {
    print("Loading data for chapter $chapterId from local storage");

    try {
      final directory = await getApplicationDocumentsDirectory();
      final chapterFile = File('${directory.path}/chapter_$chapterId.json'); // Load the specific chapter file

      // Check if the file exists
      if (await chapterFile.exists()) {
        final jsonString = await chapterFile.readAsString();
        final List<dynamic> jsonData = jsonDecode(jsonString);

        setState(() {
          chapterData = jsonData.map((item) => Verse.fromJson(item)).toList();
          audioManager.setPlaylist(chapterData);
        });
        print("Data for chapter $chapterId loaded from local file");
      } else {
        print("Local file for chapter $chapterId does not exist");
      }
    } catch (e) {
      print("Error loading data for chapter $chapterId from local file: $e");
    }
  }

  Future<void> deleteLocalData(int? chapterId) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final chapterFile = File('${directory.path}/chapter_$chapterId.json');

      // Check if the file exists
      if (await chapterFile.exists()) {
        await chapterFile.delete();
        print("Incomplete data for chapter $chapterId deleted locally.");
      }
    } catch (e) {
      print("Error deleting local data for chapter $chapterId: $e");
    }
  }






  Future<void> checkLocalData(int chapterId) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/chapter_$chapterId.json');

    // Check if the file exists
    if (await file.exists()) {
      // Load the chapter data from local storage
      final jsonString = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Check if the data is incomplete
      if (jsonData.length < widget.verseCount!) {
        print("Incomplete data found, deleting and refetching from first verse.");
        await deleteLocalData(chapterId); // Delete incomplete data

        // Check internet connection before refetching
        if (await isConnected()) {
          await loadChaptersFromAPI(chapterId); // Fetch new data from the first verse
        } else {
          handleNoInternet(); // Handle no internet case
        }
      } else {
        // If the data is complete, load from local storage
        await loadChaptersFromLocal(chapterId);
      }
    } else {
      // No local data, so fetch from the API only if connected
      if (await isConnected()) {
        await loadChaptersFromAPI(chapterId);
      } else {
        handleNoInternet(); // Handle no internet case
      }
    }
  }

  void handleNoInternet() {
    print("No Internet Connection");
    _hasInternet = true; // Example flag to manage connection state

    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GitaStatic(isToast: _hasInternet)),
      );
    });
  }

  // Future<bool> isConnected() async {
  //   var connectivityResult = await Connectivity().checkConnectivity();
  //
  //   // If no network at all (neither mobile data nor Wi-Fi)
  //   if (connectivityResult == ConnectivityResult.none) {
  //     return false;
  //   }
  //
  //   // Try pinging a well-known server (like Google) to check actual internet access
  //   try {
  //     final result = await http.get(Uri.parse('https://google.com')).timeout(
  //       Duration(seconds: 5),
  //     );
  //
  //     if (result.statusCode == 200) {
  //       return true; // Internet is working
  //     } else {
  //       return false; // Connected to network, but no internet access
  //     }
  //   } catch (e) {
  //     return false; // No internet access
  //   }
  // }

  Future<void> loadChaptersFromAPI(int chapterId) async {
    _verse = 1; // Reset the verse count to start from the first verse
    await getChapters(); // Fetch chapters
  }

  // Future<void> deleteLocalData(int? chapterId) async {
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final chapterFile = File('${directory.path}/chapter_$chapterId.json');
  //
  //     // Check if the file exists
  //     if (await chapterFile.exists()) {
  //       await chapterFile.delete();
  //       print("Incomplete data for chapter $chapterId deleted locally.");
  //     }
  //   } catch (e) {
  //     print("Error deleting local data for chapter $chapterId: $e");
  //   }
  // }

  Future<void> fetchChapters() async {
    int chapterId = widget.myId ?? 1; // Default to chapter 1 if no chapterId is provided
    await checkLocalData(chapterId); // Check and load or delete incomplete data
  }

  // Future<void> getChapters() async {
  //   // Prevent multiple calls if already loading
  //   if (isLoading) return;
  //
  //   // Check if all verses are already loaded
  //   if (widget.verseCount! == chapterData.length) return;
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   try {
  //     final ApiService apiService = ApiService();
  //     List<Verse> tempData = [];
  //
  //     // Fetch verses in small batches
  //     for (int i = 1; i < (_verse > 4 ? 5 : 10); i++) {
  //       final res = await apiService.getChapters(
  //         "https://mahakal.rizrv.in/api/v1/sahitya/bhagvad-geeta?chapter=${widget.myId}&verse=$_verse",
  //       );
  //
  //       if (res != null) {
  //         final jsonString = jsonEncode(res);
  //         final chaptersModel = ShlokModelFromJson(jsonString);
  //
  //         if (chaptersModel.data!.isNotEmpty) {
  //           final newVerse = chaptersModel.data![0].verses![0];
  //
  //           if (!chapterData.contains(newVerse)) {
  //             tempData.add(newVerse); // Add to temporary data
  //
  //             setState(() {
  //               chapterData.add(newVerse);
  //             });
  //
  //             _verse++; // Increment the verse count
  //
  //             // Save data temporarily after fetching
  //             await saveDataLocally(chapterData, widget.myId);
  //           }
  //         } else {
  //           print('No chapters data available');
  //           break;
  //         }
  //       } else {
  //         print('No data received');
  //         break;
  //       }
  //     }
  //
  //     // If the user didn't scroll through all verses, clear incomplete data
  //     if (chapterData.length < widget.verseCount!) {
  //       print("Incomplete data, removing saved file.");
  //       await deleteLocalData(widget.myId);
  //     }
  //
  //     setState(() {
  //       isLoading = false;
  //     });
  //
  //   } catch (e) {
  //     print("Error fetching data for chapter ${widget.myId}: $e");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // Future<void> saveDataLocally(List<Verse> data, int? chapterId) async {
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final chapterFile = File('${directory.path}/chapter_$chapterId.json'); // Save each chapter in a separate file
  //
  //     // Convert data to JSON and write to the file
  //     String jsonData = jsonEncode(data.map((e) => e.toJson()).toList());
  //     await chapterFile.writeAsString(jsonData);
  //     print("Data for chapter $chapterId saved locally");
  //
  //     // Saving audio files for each verse
  //     for (var verse in data) {
  //       if (verse.verseData?.audioUrl != null) {
  //         final audioFile = File('${directory.path}/chapter_$chapterId${verse.verse}.mp3');
  //         if (!await audioFile.exists()) {
  //           final response = await http.get(Uri.parse(verse.verseData!.audioUrl!));
  //           await audioFile.writeAsBytes(response.bodyBytes);
  //           print("Audio for verse ${verse.verse} in chapter $chapterId saved locally");
  //         }
  //         verse.verseData!.audioUrl = '${directory.path}/chapter_$chapterId${verse.verse}.mp3';
  //       }
  //     }
  //   } catch (e) {
  //     print("Error saving data locally for chapter $chapterId: $e");
  //   }
  // }

  Future<void> checkInternet() async {
    _hasInternet = !(await isConnected()); // Invert the value of isConnected()
    print("${_hasInternet}");
    setState(() {}); // Update the UI with the new value
  }

  // Future<void> loadChaptersFromLocal(int? chapterId) async {
  //   print("Loading data for chapter $chapterId from local storage");
  //
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     final chapterFile = File('${directory.path}/chapter_$chapterId.json'); // Load the specific chapter file
  //
  //     // Check if the file exists
  //     if (await chapterFile.exists()) {
  //       final jsonString = await chapterFile.readAsString();
  //       final List<dynamic> jsonData = jsonDecode(jsonString);
  //
  //       setState(() {
  //         chapterData = jsonData.map((item) => Verse.fromJson(item)).toList();
  //         audioManager.setPlaylist(chapterData);
  //       });
  //       print("Data for chapter $chapterId loaded from local file");
  //     } else {
  //       print("Local file for chapter $chapterId does not exist");
  //     }
  //   } catch (e) {
  //     print("Error loading data for chapter $chapterId from local file: $e");
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    audioManager = Provider.of<AudioPlayerManager>(context);
  }

  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    //  Initialize AudioPlayerManager
    audioManager = Provider.of<AudioPlayerManager>(context, listen: false);
    // Listen for changes in current index
    _listener = () {
      if (audioManager.currentIndex != _currentPlayingIndex) {
        print("My Audio Current Index is ${audioManager.currentIndex}");
        if (mounted) {
          setState(() {
            _currentPlayingIndex = audioManager.currentIndex;
            print("$_currentPlayingIndex");
          });
        }
      }
    };
    audioManager.addListener(_listener);
   // getChapters();
    fetchChapters();
    checkInternet();
  }

  @override
  void dispose() {
    audioManager.removeListener(_listener);
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
  void _showTranslationBottomSheet(BuildContext context, String hindiDescription, int audioIndex, String englishDescription, String image) {
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
               body:


               // NotificationListener<ScrollNotification>(
               //   onNotification: (notification) {
               //     if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
               //       if (widget.verseCount! > chapterData.length) {
               //         getChapters();
               //       }
               //     }
               //     return true;
               //   },


               // For check

               NotificationListener<ScrollNotification>(
                 onNotification: (notification) {
                   if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                     if (widget.verseCount! > chapterData.length) {
                       getChapters(); // Fetch new verses on scroll
                     }
                   }
                   return true;
                 },





               // Working

               // NotificationListener<ScrollNotification>(
               //     onNotification: (notification){
               //       print(widget.verseCount!);
               //       print(chapterData.length);
               //       if (notification.metrics.pixels == notification.metrics.maxScrollExtent)  {
               //         if (widget.verseCount! > chapterData.length) {
               //           //fetchChapters();
               //           getChapters();
               //         }
               //       }
               //       return true;
               //     },
                   child: // Your child widget here





                    //
                    // isLoading || chapterData.isEmpty
                    //    ? Center(
                    //      child: Container(height: 150,width: 250,decoration: BoxDecoration(
                    //                           borderRadius: BorderRadius.circular(15),
                    //                            color: Colors.grey
                    //                           // color: Colors.transparent
                    //                         ),child: Center(child: Column(
                    //                           crossAxisAlignment: CrossAxisAlignment.center,
                    //                           mainAxisAlignment: MainAxisAlignment.center,
                    //                           children: [
                    //      CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,),
                    //      SizedBox(height: 10,),
                    //      Text("Please Wait it May Takes Time")
                    //                           ],
                    //                         ))),
                    //    ) :
                    //
                    //




                  //child:
                  //isLoading ||
                      chapterData.isEmpty
                   ? Center(
                 child: Container(
                   height: 150,
                   width: 250,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.grey,
                   ),
                   child: Center(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         CircularProgressIndicator(
                           color: Colors.black,
                           backgroundColor: Colors.white,
                         ),
                         SizedBox(height: 10,),
                         Text("Please Wait it May Takes Time",style: TextStyle(fontWeight: FontWeight.bold),),
                       ],
                     ),
                   ),
                 ),
               ) :  // Your data is loaded and ready to be displayed
                   CustomScrollView(
                    //controller: _scrollController,
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
                              audioManager.stopMusic();
                              //audioManager.toggleMusicBarVisibility();
                              //audioManager.resetMusicBarVisibility();

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
                         // snap: true,
                          floating: true,
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
                                                '${widget.verseCount}',
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
                                    controller: _scrollController,
                                    scrollDirection: Axis.vertical,
                                  // physics: AlwaysScrollableScrollPhysics(),
                                    physics: const NeverScrollableScrollPhysics(),
                                    //itemCount: chapterData.length,
                                     itemCount: chapterData.length + (isLoading ? 1 : 0),
                                    itemBuilder: (context, index) {

                                      if (index < chapterData.length){


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

                                        return Consumer<SettingsProvider>(
                                          builder: (BuildContext context, SettingProvider, Widget? child) {
                                            return Column(
                                              children: [
                                                Container(
                                                  color: _highlightedIndex == index
                                                      ? Colors.cyanAccent.withOpacity(
                                                      0.2) // Highlight color
                                                      : SettingProvider.isOn
                                                      ? CustomColors.clrblack
                                                      : CustomColors.clrskin,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: screenWidth * 0.04,
                                                        horizontal: screenWidth * 0.03),
                                                    child: Consumer<SettingsProvider>(
                                                      builder: (BuildContext context, SettingProvider, Widget? child) {
                                                        return  Column(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  border: Border.all(
                                                                      color: SettingProvider
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
                                                                      screenWidth * 0.04,
                                                                  color: SettingProvider
                                                                      .isOn
                                                                      ? CustomColors
                                                                      .clrwhite
                                                                      : CustomColors
                                                                      .clrblack,),
                                                                ),
                                                              ),
                                                            ),
                                                            Consumer<SettingsProvider>(
                                                              builder: (BuildContext context,
                                                                  settingProvider,
                                                                  Widget? child) {
                                                                return
                                                                  Text(
                                                                    "${chapterData[index].verseData!.verseData!.sanskrit}",
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        settingProvider
                                                                            .fontSize,
                                                                        color: settingProvider
                                                                            .isOn
                                                                            ? settingProvider
                                                                            .textColor
                                                                            : CustomColors
                                                                            .clrblack,
                                                                        fontFamily:
                                                                        settingProvider
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
                                                                                      gitaShlok: chapterData[index].
                                                                                           verseData
                                                                                          ?.verseData!
                                                                                          .sanskrit ??
                                                                                          '',
                                                                                      shlokMeaning: chapterData[index]
                                                                                          .verseData
                                                                                          ?.verseData!
                                                                                          .hindi ??
                                                                                          '',
                                                                                      detailsModel: chapterData[index],chapterName:widget.chapterHindiName, verseSerial: chapterData[index].verse,
                                                                                    ),
                                                                              ));
                                                                        },
                                                                        child: Icon(
                                                                          Icons
                                                                              .share_outlined,
                                                                          color: SettingProvider
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
                                                                        bookmarked!.verseData
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
                                                                            color: SettingProvider
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
                                                                                    chapterData[index].verseImage ??
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

                                                                    Consumer<AudioPlayerManager>(
                                                                      builder: (BuildContext
                                                                      context,
                                                                          audioController,
                                                                          Widget? child) {
                                                                        bool
                                                                        isCurrentSongPlaying =
                                                                            audioController.isPlaying
                                                                                && audioController.currentMusic == chapterData[index];

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
                                                                                    index],widget.myId);

                                                                                print("${isCurrentSongPlaying}");

                                                                                print("Song clicked and played");
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
                                                                            color: SettingProvider
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
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: screenWidth * 0.02,
                                                      vertical: screenWidth * 0.002),
                                                  child:
                                                  Consumer<SettingsProvider>(
                                                    builder: (BuildContext context,
                                                        settingProvider, Widget? child) {
                                                      return
                                                        Column(
                                                          children: [
                                                            Visibility(
                                                              visible: settingProvider
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
                                                                        settingProvider
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
                                                              visible: settingProvider
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
                                                                        settingProvider
                                                                            .fontSize,
                                                                        fontWeight:
                                                                        FontWeight.w400,
                                                                        fontFamily:
                                                                        'Roboto'),
                                                                  ),
                                                                  Divider(
                                                                    color:
                                                                    settingProvider
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
                                          },
                                        );



                                      }else {
                                        return Center(
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                              backgroundColor: Colors.white,
                                              strokeWidth: 1.5,
                                            ),
                                          ),
                                        );
                                        //   Container(
                                        //   alignment: Alignment.center,
                                        //   width: double.infinity,
                                        //  color: Colors.red.withOpacity(0.5),
                                        //   padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                                        //   child: Text('Please Wait', style: TextStyle(color: Colors.white),),
                                        // );
                                      }
                                    },
                                  ),
                               // )
                            ],
                          ),
                        ),
                      ],
                    ),
               // ),

          ),


                //
                // bottomNavigationBar: Consumer<AudioPlayerManager>(
                //   builder: (context, musicManager, child) {
                //     if (audioManager.isMusicBarVisible && chapterData.isNotEmpty) {
                //       return MusicBar(
                //         chapterHindiName: widget.chapterHindiName,
                //         verseSerial: chapterData[0].verse,
                //         chapterNumber: widget.myId,
                //       );
                //     } else {
                //       return const SizedBox.shrink();
                //     }
                //   },
                // ),


                bottomNavigationBar: Consumer<AudioPlayerManager>(
                  builder: (context, musicManager, child) {
                    if (audioManager.isMusicBarVisible){
                      return MusicBar(chapterHindiName: widget.chapterHindiName,verseSerial: chapterData[0].verse,chapterNumber: widget.myId,);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),

              ),
        ));
      },
    );
  }
}
