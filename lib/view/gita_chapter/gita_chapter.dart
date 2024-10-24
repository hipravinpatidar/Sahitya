// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sahityadesign/api_service/api_service.dart';
// import 'package:sahityadesign/controller/settings_controller.dart';
// import 'package:sahityadesign/model/chapters_model.dart';
// import 'package:sahityadesign/ui_helpers/custom_colors.dart';
// import 'package:sahityadesign/view/detail_gita_shlok/gita_screen.dart';
// import 'package:sahityadesign/view/sahitya_home/sahitya_home.dart';
// import '../../controller/audio_controller.dart';
// import '../../utils/music_bar.dart';
//
// class GeetaChapter extends StatefulWidget {
//     const GeetaChapter({super.key,});
//
//   @override
//   State<GeetaChapter> createState() => _GeetaChapterState();
// }
//
// class _GeetaChapterState extends State<GeetaChapter> {
//
//   bool isLoading = false;
//   late AudioPlayerManager audioManager = AudioPlayerManager();
//
//   List<MyChapters> chapterData = [];
//
//   Future<void> getChapters() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       final Map<String, dynamic> jsonResponse = await ApiService().getMyChap(
//           'https://mahakal.rizrv.in/api/v1/sahitya/bhagavad-geeta/chapters');
//
//       if (jsonResponse.containsKey('status') &&
//           jsonResponse.containsKey('data') &&
//           jsonResponse['data'] != null) {
//         final chaptersGita = ChaptersGita.fromJson(jsonResponse);
//
//         setState(() {
//           chapterData = chaptersGita.data; // Assign the list of chapters to chapterData
//         });
//
//         print("Chapter data length: ${chapterData.length}");
//       } else {
//         print("Error: 'status' or 'data' key is missing or null in response.");
//       }
//     } catch (error) {
//       print('Error in fetching category data: $error');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   // Future<void> getChapters() async {
//   //
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //
//   //   try {
//   //     final Map<String, dynamic> jsonResponse = await ApiService().getMyChap(
//   //         'https://mahakal.rizrv.in/api/v1/sahitya/bhagavad-geeta/chapters');
//   //
//   //     // print(jsonResponse);
//   //     if (jsonResponse.containsKey('status') &&
//   //         jsonResponse.containsKey('data') &&
//   //         jsonResponse['data'] != null) {
//   //       final categoryModel = MyChapters.fromJson(jsonResponse);
//   //
//   //       print(categoryModel.name);
//   //
//   //       setState(() {
//   //         // chapterData = categoryModel;
//   //       });
//   //     } else {
//   //       print("Error: 'status' or 'data' key is missing or null in response.");
//   //     }
//   //   } catch (error) {
//   //     print('Error  in fetching category data: $error');
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   //   print("${chapterData.length}");
//   // }
//
//   // Future<void> getChapters() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //
//   //   try {
//   //     final jsonResponse = await ApiService().getChapters('https://mahakal.rizrv.in/api/v1/sahitya/bhagavad-geeta/chapters');
//   //
//   //     if (jsonResponse != null) {
//   //       final Map<String, dynamic> jsonMap = jsonResponse;
//   //
//   //
//   //       if (jsonMap.containsKey('status') &&
//   //           jsonMap.containsKey('data') &&
//   //           jsonMap['data'] != null) {
//   //
//   //         final chapterModel = ShlokModel.fromJson(jsonMap);
//   //
//   //         print(chapterModel);
//   //
//   //         setState(() {
//   //           chapterData =  chapterModel.data;
//   //         });
//   //       } else {
//   //         print("Error: 'status' or 'data' key is missing or null in response.");
//   //       }
//   //     } else {
//   //       print("Error: Response is null");
//   //     }
//   //   } catch (error) {
//   //     print('Error  in fetching chapters data: $error');
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     getChapters();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var screenWidth = MediaQuery.of(context).size.width;
//
//     return Consumer<SettingsProvider>(
//       builder: (BuildContext context, settingsProvider, Widget? child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: settingsProvider.isOn ? ThemeData.dark() : ThemeData.light(),
//           home: Scaffold(
//             appBar: AppBar(
//               backgroundColor:settingsProvider.isOn  ?  CustomColors.clrblack : CustomColors.clrorange,
//               leading: GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => SahityaHome(),));
//                 },
//                 child: Icon(Icons.arrow_back, color: CustomColors.clrwhite, size: screenWidth * 0.06),
//               ),
//               title: Text("Shrimad Bhagwat Geeta", style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600, fontFamily: 'Roboto',color: CustomColors.clrwhite)),
//
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
//                   child: Row(
//                     children: [
//
//                       GestureDetector(
//                           onTap: () {
//                             //Navigator.push(context, MaterialPageRoute(builder: (context) => SavedItemsScreen(_savedItems,bhagwatitem,_removeItemFromSavedList)),);
//                           },child: Icon(Icons.bookmark,color: CustomColors.clrwhite,size: screenWidth * 0.06,)),
//                       SizedBox(width: screenWidth * 0.02,),
//                       Icon(Icons.search,color: CustomColors.clrwhite,size: screenWidth * 0.06,)
//
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             body: isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)):
//
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                       color: settingsProvider.isOn  ?  CustomColors.clrwhite : Colors.orange,
//                       child: Center(child: Padding(
//                         padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
//                         child: Text('Continue Reading - Arjun Vishad Yog(18)',style: TextStyle(fontFamily: 'Roboto',fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600,color: settingsProvider.isOn  ? CustomColors.clrblack : CustomColors.clrwhite),),
//                       ))),
//
//                   ListView.builder(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.symmetric(vertical: screenWidth * 0.08),
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: chapterData.length,
//                     itemBuilder: (context, index) {
//                       final chapter = chapterData[index];
//
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.01),
//                         child: Consumer<AudioPlayerManager>(
//                           builder: (BuildContext context, audioController, Widget? child) {
//
//                             bool isCurrentSongPlaying= audioController.isPlaying &&
//                                 chapterData[index] == audioController.currentMusic;
//
//                             return Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
//                                   child: Row(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) => GitaScreen(myId: chapter.id,chapterName: chapterData[index].name,chapterImage: chapterData[index].image,chapterHindiName: chapterData[index].hiName,verseCount: chapterData[index].verseCount,),),);
//                                         },
//                                         child: Consumer<SettingsProvider>(
//                                           builder: (BuildContext context, settingsProvider, Widget? child) {
//                                             return Row(
//                                               children: [
//                                                 Container(
//                                                   height: screenWidth * 0.1,
//                                                   width: screenWidth * 0.1,
//                                                   decoration: const BoxDecoration(
//                                                     image: DecorationImage(
//                                                       image: AssetImage("assets/image/imagecircle.png"), fit: BoxFit.cover
//                                                     ),
//                                                   ),
//                                                   child: Center(
//                                                     child: Text(
//                                                       "${chapter.id}",
//                                                       style: TextStyle(
//                                                         fontSize: screenWidth * 0.03,
//                                                         fontFamily: 'Roboto',
//                                                         fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(left: screenWidth * 0.05),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       SizedBox(
//                                                         width: screenWidth * 0.6,
//                                                         child: Text(
//                                                           chapter.hiName ?? '',
//                                                           style: TextStyle(
//                                                             fontFamily: 'Roboto',
//                                                             fontWeight: FontWeight.w500,
//                                                             fontSize: settingsProvider.fontSize,
//                                                             overflow: TextOverflow.ellipsis,
//                                                           ),
//                                                           maxLines: 1,
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: screenWidth * 0.6,
//                                                         child: Text(
//                                                           chapter.name ?? '',
//                                                           style: TextStyle(
//                                                             fontSize: settingsProvider.fontSize,
//                                                             fontWeight: FontWeight.w400,
//                                                             overflow: TextOverflow.ellipsis,
//                                                           ),
//                                                           maxLines: 1,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       Spacer(),
//
//                                       // Row(
//                                       //   children: [
//                                       //     GestureDetector(
//                                       //       onTap: () {
//                                       //         audioController.playMusic(chapterData[index].verses![index]);
//                                       //         },
//                                       //       child: Icon(
//                                       //         isCurrentSongPlaying ? Icons.pause : Icons.play_arrow,
//                                       //         size: screenWidth * 0.08,
//                                       //         color: CustomColors.clrorange,
//                                       //       ),
//                                       //     ),
//                                       //
//                                       //     SizedBox(width: screenWidth * 0.02),
//                                       //     // GestureDetector(
//                                       //     //   onTap: () {
//                                       //     //     setState(() {
//                                       //     //       if (!_isBookmarked[index]) {
//                                       //     //         _showSaveOptionsDialog(index);
//                                       //     //         _saveBookmark(index);
//                                       //     //         _isBookmarked[index] = true;
//                                       //     //       } else {
//                                       //     //         _removeBookmark(index);
//                                       //     //         _isBookmarked[index] = false;
//                                       //     //       }
//                                       //     //     });
//                                       //     //   },
//                                       //     //   child: Icon(
//                                       //     //     _isBookmarked[index] ? Icons.bookmark : Icons.bookmark_outline,
//                                       //     //     size: screenWidth * 0.07,
//                                       //     //     color: CustomColors.clrorange,
//                                       //     //   ),
//                                       //     // ),
//                                       //   ],
//                                       // ),
//
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: screenWidth * 0.02),
//                                 Divider(
//                                   height: screenWidth * 0.002,
//                                   color: settingsProvider.isOn  ? Colors.orangeAccent : CustomColors.clrblack,
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//
//             bottomNavigationBar: Consumer<AudioPlayerManager>(
//               builder: (context, musicManager, child) {
//                 return musicManager.isMusicBarVisible
//                     ? const MusicBar()
//                     : const SizedBox.shrink();
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
