import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sahityadesign/api_service/api_service.dart';
import 'package:sahityadesign/controller/settings_controller.dart';
import 'package:sahityadesign/model/chapters_model.dart';
import 'package:sahityadesign/ui_helpers/custom_colors.dart';
import 'package:sahityadesign/view/detail_gita_shlok/gita_screen.dart';
import 'package:sahityadesign/view/sahitya_home/sahitya_home.dart';
import '../../controller/audio_controller.dart';
import '../../model/shlokModel.dart';
import '../../utils/music_bar.dart';
import 'gits_static_model.dart';

class GitaStatic extends StatefulWidget {

  final bool? isToast;

   const GitaStatic({super.key,this.isToast});

  @override
  State<GitaStatic> createState() => _GitaStaticState();
}

class _GitaStaticState extends State<GitaStatic> {

  late AudioPlayerManager audioManager = AudioPlayerManager();

  bool isLoading = true;
  
  List<GitaItems> gitaItems = [
    
    GitaItems(enName: "ARJUN VISHAD YOGA",hiName: "अर्जुन विषद योग",serailNumber: 1,totalCount: 47),
    GitaItems(enName: "SANKHYA YOGA",hiName: "सांख्य योग",serailNumber: 2,totalCount: 72),
    GitaItems(enName: "KARMA YOGA",hiName: "कर्म योग",serailNumber: 3,totalCount: 43),
    GitaItems(enName: "GYAAN KARMA SANNYAAS YOGA",hiName: "ज्ञान कर्म संन्यास योग",serailNumber: 4,totalCount: 42),
    GitaItems(enName: "KARMA SANNYASA YOGA",hiName: "कर्म संन्यास योग",serailNumber: 5,totalCount: 29),


    GitaItems(enName: "DHYAAN YOGA",hiName: "ध्यान योग",serailNumber: 6,totalCount: 47),
    GitaItems(enName: "GYAAN VIGYAAN YOG",hiName: "ज्ञान विज्ञान योग",serailNumber: 7,totalCount: 30),
    GitaItems(enName: "AKSHAR BRAHMA YOGA",hiName: "अक्षर ब्रह्म योग",serailNumber: 8,totalCount: 28),
    GitaItems(enName: "RAJVIDYA RAJGUHYA YOGA",hiName: "राजविद्या राजगुह्य योग",serailNumber: 9,totalCount: 34),
    GitaItems(enName: "VIBHUTI YOGA",hiName: "विभूति योग",serailNumber: 10,totalCount: 42),

    GitaItems(enName: "VISHVARUP DARSHAN YOGA",hiName: "विश्वरूप दर्शन योग",serailNumber: 11,totalCount: 55),
    GitaItems(enName: "BHAKTIYOGA",hiName: "भक्तियोग",serailNumber: 12,totalCount: 20),
    GitaItems(enName: "KSHETR KSHETRAGY VIBHAAG YOGA",hiName: "क्षेत्रक्षेत्रविभाग योग",serailNumber: 13,totalCount: 35),
    GitaItems(enName: "GUNATRAY VIBHAG YOGA",hiName: "गुणत्रय विभाग योग",serailNumber: 14,totalCount: 27),
    GitaItems(enName: "PURUSHOTTAM YOGA",hiName: "पुरूषोत्तम योग",serailNumber: 15,totalCount: 0),

    GitaItems(enName: "DAIVASUR SAMPADA VIBHAG YOGA",hiName: "दैवसुर सम्पदा विभाग योग",serailNumber: 16,totalCount: 46),
    GitaItems(enName: "SHRADDHAATRAY VIBHAAG YOGA",hiName: "श्रद्धात्रय विभाग योग",serailNumber: 17,totalCount: 46),
    GitaItems(enName: "MOKSHA SANNYASA YOGA",hiName: "मोक्ष संन्यास योग",serailNumber: 18,totalCount: 46),

    
  ];
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

    return Consumer<SettingsProvider>(
      builder: (BuildContext context, settingsProvider, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: settingsProvider.isOn ? ThemeData.dark() : ThemeData.light(),
          home: Scaffold(
            appBar: AppBar(
              backgroundColor:settingsProvider.isOn  ?  CustomColors.clrblack : CustomColors.clrorange,
              leading: GestureDetector(
                onTap: () {
                 // Navigator.pop(context);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => SahityaHome(),));
                },
                child: Icon(Icons.arrow_back, color: CustomColors.clrwhite, size: screenWidth * 0.06),
              ),
              title: Text("Shrimad Bhagwat Geeta", style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600, fontFamily: 'Roboto',color: CustomColors.clrwhite)),

              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Row(
                    children: [

                      GestureDetector(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => SavedItemsScreen(_savedItems,bhagwatitem,_removeItemFromSavedList)),);
                          },child: Icon(Icons.bookmark,color: CustomColors.clrwhite,size: screenWidth * 0.06,)),
                      SizedBox(width: screenWidth * 0.02,),
                      Icon(Icons.search,color: CustomColors.clrwhite,size: screenWidth * 0.06,)

                    ],
                  ),
                ),
              ],
            ),
            body: 
            isLoading ? const Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)):

            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      color: settingsProvider.isOn  ?  CustomColors.clrwhite : Colors.orange,
                      child: Center(child: Padding(
                        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                        child: Text('Continue Reading - Arjun Vishad Yog(18)',style: TextStyle(fontFamily: 'Roboto',fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600,color: settingsProvider.isOn  ? CustomColors.clrblack : CustomColors.clrwhite),),
                      ))),

                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: gitaItems.length,
                    itemBuilder: (context, index) {
                      final chapter = gitaItems[index];

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenWidth * 0.01),
                        child: Consumer<AudioPlayerManager>(
                          builder: (BuildContext context, audioController, Widget? child) {

                            bool isCurrentSongPlaying= audioController.isPlaying &&
                                gitaItems[index] == audioController.currentMusic;

                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => GitaScreen(myId: chapter.serailNumber,chapterName: gitaItems[index].enName,chapterHindiName: gitaItems[index].hiName,verseCount: gitaItems[index].totalCount,),),);
                                        },
                                        child: Consumer<SettingsProvider>(
                                          builder: (BuildContext context, settingsProvider, Widget? child) {
                                            return Row(
                                              children: [
                                                Container(
                                                  height: screenWidth * 0.1,
                                                  width: screenWidth * 0.1,
                                                  decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage("assets/image/imagecircle.png"), fit: BoxFit.cover
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${chapter.serailNumber}",
                                                      style: TextStyle(
                                                          fontSize: screenWidth * 0.03,
                                                          fontFamily: 'Roboto',
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: screenWidth * 0.6,
                                                        child: Text(
                                                          chapter.hiName ?? '',
                                                          style: TextStyle(
                                                            fontFamily: 'Roboto',
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: settingsProvider.fontSize,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth * 0.6,
                                                        child: Text(
                                                          chapter.enName ?? '',
                                                          style: TextStyle(
                                                            fontSize: settingsProvider.fontSize,
                                                            fontWeight: FontWeight.w400,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Spacer(),

                                      // Row(
                                      //   children: [
                                      //     GestureDetector(
                                      //       onTap: () {
                                      //         audioController.playMusic(gitaItems[index].verses![index]);
                                      //         },
                                      //       child: Icon(
                                      //         isCurrentSongPlaying ? Icons.pause : Icons.play_arrow,
                                      //         size: screenWidth * 0.08,
                                      //         color: CustomColors.clrorange,
                                      //       ),
                                      //     ),
                                      //
                                      //     SizedBox(width: screenWidth * 0.02),
                                      //     // GestureDetector(
                                      //     //   onTap: () {
                                      //     //     setState(() {
                                      //     //       if (!_isBookmarked[index]) {
                                      //     //         _showSaveOptionsDialog(index);
                                      //     //         _saveBookmark(index);
                                      //     //         _isBookmarked[index] = true;
                                      //     //       } else {
                                      //     //         _removeBookmark(index);
                                      //     //         _isBookmarked[index] = false;
                                      //     //       }
                                      //     //     });
                                      //     //   },
                                      //     //   child: Icon(
                                      //     //     _isBookmarked[index] ? Icons.bookmark : Icons.bookmark_outline,
                                      //     //     size: screenWidth * 0.07,
                                      //     //     color: CustomColors.clrorange,
                                      //     //   ),
                                      //     // ),
                                      //   ],
                                      // ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: screenWidth * 0.02),
                                Divider(
                                  height: screenWidth * 0.002,
                                  color: settingsProvider.isOn  ? Colors.orangeAccent : CustomColors.clrblack,
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),


                ],
              ),
            ),

            bottomNavigationBar: Visibility(
              visible: widget.isToast ?? false,
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "No internet connection",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ),
        );
      },
    );
  }
}

