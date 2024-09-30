import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahityadesign/controller/audio_controller.dart';

import '../ui_helpers/custom_colors.dart';

class MusicBar extends StatefulWidget {

  final String? chapterHindiName;
  final int? verseSerial;
  final chapterNumber;

  const MusicBar({super.key,this.chapterHindiName, this.verseSerial, this.chapterNumber,});

  @override
  State<MusicBar> createState() => _MusicBarState();
}

class _MusicBarState extends State<MusicBar> {
  @override
  Widget build(BuildContext context) {
    final audioManager = Provider.of<AudioPlayerManager>(context);

    var screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      height: 75.0, // Adjust as needed
      color: Colors.brown,
      child:
         Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              child:
              Column(
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.1,
                        height: screenWidth * 0.1,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/image/imagecircle.png"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("${widget.chapterNumber}",style: const TextStyle(color: Colors.white),)),
                      ),

                      //SizedBox(width: screenWidth * 0.03,),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: screenWidth * 0.03,
                            left: screenWidth * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [

                                  SizedBox(
                                    width: screenWidth * 0.24,
                                    child: Text(
                                      "${widget.chapterHindiName}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),

                                  SizedBox(width: screenWidth * 0.04,),
                                  SizedBox(
                                    width: screenWidth * 0.05,
                                    child: Text("${audioManager.currentMusic?.verse}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],

                              ),


                              SizedBox(
                                width: screenWidth * 0.4,
                                child: Text(
                                  audioManager.currentMusic?.verseData?.verseData?.sanskrit.toString() ?? '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenWidth * 0.07,),

                      Row(


                        children: [


                          // Skip Previous
                          IconButton(
                            onPressed: () {
                              audioManager.skipPrevious(chapterId: widget.chapterNumber);
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: screenWidth * 0.08,
                            ),
                          ),

                          // Toggle Play Pause
                          GestureDetector(
                            onTap: () => audioManager.togglePlayPause(),
                            child: Icon(
                              audioManager.isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle,
                              size: screenWidth * 0.08,
                              color: CustomColors.clrwhite,
                            ),
                          ),

                          // Skip Next
                          IconButton(
                            onPressed: () {
                              audioManager.skipNext(widget.chapterNumber);
                            },
                            icon: Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: screenWidth * 0.08,
                            ),
                          ),

                          // Remove Music Bar
                          IconButton(
                            onPressed: () {
                              audioManager.stopMusic();
                              audioManager.resetMusicBarVisibility();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: screenWidth * 0.08,
                            ),
                          ),
                        ],

                      )



                      // Skip Next
                      // IconButton(
                      //   onPressed: () {
                      //     if (audioManager.isPlaying) {
                      //       // Skip to the next track
                      //       audioManager.skipNext();
                      //     } else {
                      //       // Handle the case where the music is not playing
                      //       audioManager.toggleMusicBarVisibility();
                      //     }
                      //   },
                      //   icon: Icon(
                      //     audioManager.isPlaying
                      //         ? Icons.skip_next
                      //         : Icons.highlight_remove_outlined,
                      //     color: Colors.white,
                      //     size: screenWidth * 0.1,
                      //   ),
                      // ),

                    ],
                  ),

                  Padding(
                    padding:EdgeInsets.symmetric(vertical: screenWidth * 0.01),
                    child: Container(
                      height: 5,
                      width: double.infinity,
                      child: SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: CustomColors.clrwhite,
                          trackHeight: 1.5,
                          trackShape: const RectangularSliderTrackShape(),
                          inactiveTrackColor: CustomColors.clrwhite.withOpacity(0.5),
                          thumbColor: CustomColors.clrwhite,
                          thumbShape: SliderComponentShape.noThumb,
                          overlayColor: CustomColors.clrwhite.withOpacity(0.7),
                          valueIndicatorColor: CustomColors.clrwhite,
                        ),
                        child: Slider(
                          min: 0.0,
                          max: audioManager.duration.inSeconds.toDouble(),
                          value: audioManager.currentPosition.inSeconds.toDouble(),
                          onChanged: (double value) {
                            audioManager.seekTo(Duration(seconds: value.toInt()));
                          },
                        ),
                      ),
                    ),
                  ),

                ],
              )
            ),
    );
  }
}
