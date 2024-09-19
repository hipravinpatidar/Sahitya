import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahityadesign/controller/audio_controller.dart';

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
      height: 70.0, // Adjust as needed
      color: Colors.brown,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   PageRouteBuilder(
          //     pageBuilder: (context, animation, secondaryAnimation) =>
          //       //GitaScreen(),
          //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
          //       const begin = Offset(0.0, 1.0);
          //       const end = Offset.zero;
          //       const curve = Curves.easeInOutCirc;
          //
          //       var tween = Tween(begin: begin, end: end)
          //           .chain(CurveTween(curve: curve));
          //
          //       return SlideTransition(
          //         position: animation.drive(tween),
          //         child: child,
          //       );
          //     },
          //     transitionDuration: const Duration(milliseconds: 300),
          //   ),
          // );
        },
        child:
         Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child:
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

                  SizedBox(width: screenWidth * 0.03,),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: screenWidth * 0.03,
                        left: screenWidth * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.5,
                            child: Text(
                              "${widget.chapterHindiName} : ${widget.verseSerial}",
                              style: const TextStyle(
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.5,
                            child: Text(
                              audioManager.currentMusic?.verseData?.verseData?.sanskrit.toString() ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Skip Previous
                  IconButton(
                    onPressed: () {
                        audioManager.skipPrevious();
                    },
                    icon: Icon(
                          Icons.skip_previous,
                      color: Colors.white,
                      size: screenWidth * 0.1,
                    ),
                  ),

                  // Toggle Play Pause
                  IconButton(
                    onPressed: () {
                      audioManager.togglePlayPause();
                    },
                    icon: Icon(
                      audioManager.isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                      size: screenWidth * 0.1,
                    ),
                  ),

                  // Skip Next
                  IconButton(
                    onPressed: () {
                      if (audioManager.isPlaying) {
                        // Skip to the next track
                        audioManager.skipNext();
                      } else {
                        // Handle the case where the music is not playing
                        audioManager.toggleMusicBarVisibility();
                      }
                    },
                    icon: Icon(
                      audioManager.isPlaying
                          ? Icons.skip_next
                          : Icons.highlight_remove_outlined,
                      color: Colors.white,
                      size: screenWidth * 0.1,
                    ),
                  ),
                ],
              )
            ),
      ),
    );
  }
}
