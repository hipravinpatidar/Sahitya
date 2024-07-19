import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahityadesign/view/edit_screen.dart';
import 'package:sahityadesign/view/gita_chapter.dart';
import 'package:sahityadesign/view/share_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ui_helpers/custom_colors.dart';

class GitaScreen extends StatefulWidget {
  const GitaScreen({super.key});

  @override
  State<GitaScreen> createState() => _GitaScreenState();
}

class _GitaScreenState extends State<GitaScreen> {
  EditScreen editScreen = const EditScreen();

  bool _showHindiText = true;
  bool _showEnglishText = true;
  String _selectedChap = 'Chapter 1';
  //Color _themeColor = Colors.blue;
  String _selectedFont = 'OpenSans';
  double _fontSize = 14;

  void _updateFontSize(double fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }

  void _updateHindiText(bool value) {
    setState(() {
      _showHindiText = value;
    });
  }

  void _updateEnglishText(bool value) {
    setState(() {
      _showEnglishText = value;
    });
  }

  void _updateFont(String value){
    setState(() {
      _selectedFont = value;
    });
  }

  // void _changeThemeColor(Color newColor) {
  //   setState(() {
  //     _themeColor = newColor;
  //   });
  // }


  // ThemeData _themeData = ThemeData.light();
  //
  // void _changeThemeColor(Color newColor) {
  //   setState(() {
  //     if (newColor == Colors.blue) {
  //       _themeData = ThemeData.dark().copyWith(
  //         primaryColor: Colors.black,
  //         colorScheme: ColorScheme.dark(
  //           primary: Colors.red,
  //           secondary: Colors.redAccent
  //         ),
  //       );
  //     } else if (newColor == Colors.green) {
  //       _themeData = ThemeData.light().copyWith(
  //         primaryColor: Colors.green,
  //         colorScheme: ColorScheme.dark(
  //             primary: Colors.green,
  //             secondary: Colors.greenAccent
  //         ),
  //       );
  //     } else if (newColor == Colors.yellow) {
  //       _themeData = ThemeData.light().copyWith(
  //         primaryColor: Colors.yellow,
  //         colorScheme: ColorScheme.dark(
  //             primary: Colors.yellow,
  //             secondary: Colors.yellowAccent
  //         ),
  //       );
  //     } else if (newColor == Colors.purple) {
  //       _themeData = ThemeData.dark().copyWith(
  //         primaryColor: Colors.purple,
  //         colorScheme: ColorScheme.dark(
  //             primary: Colors.purple,
  //             secondary: Colors.purpleAccent
  //         ),
  //       );
  //     }
  //   });
  // }

  bool _isDarkMode = false;

  void _changeThemeMode(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }


  List<String> _chapOptions = [
    'Chapter 1', 'Chapter 2', 'Chapter 3',
    'Chapter 5', 'Chapter 6', 'Chapter 7',
    'Chapter 8', 'Chapter 9', 'Chapter 10',
    'Chapter 11', 'Chapter 12', ];


  List<String> _fontOptions = [
    'OpenSans',
    'Inter',
    'Lato',
    'Roboto',];


  // Bottom Sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: CustomColors.clrwhite,
      context: context,
      builder: (context) {

          var screenHeight = MediaQuery.of(context).size.height;
          var screenWidth = MediaQuery.of(context).size.width;


           return StatefulBuilder(
             builder: (context, StateSetter setState) {
               return SizedBox(
                 height: screenWidth * 1.2,
                 child: Column(
                   children: [

                     // Fonts Styles
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenWidth * 0.04),
                       child: Row(children: [

                         Container(
                             width:screenWidth * 0.04,
                             height: screenWidth * 0.04,
                             child: Image(image: AssetImage("assets/image/a.png"),)),
                         SizedBox(width: screenWidth * 0.02,),
                         Text("Font type",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth * 0.04,fontFamily: 'Roboto',color: CustomColors.clrblack),),

                        Spacer(),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                           child: DropdownButton<String>(
                             value: _selectedFont,
                             onChanged: (String? newValue) {
                               setState(() {
                                 _selectedFont = newValue ?? '';
                               });
                               _updateFont(newValue!);
                             },
                             items: _fontOptions.map((String font) {
                               return DropdownMenuItem<String>(
                                 value: font,
                                 child: Text(font,style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrblack),),
                               );
                             }).toList(),

                             // remove the default elevation
                             dropdownColor: Colors.white, // change the dropdown background color
                             borderRadius: BorderRadius.circular(5), // make the dropdown button rounded
                             alignment: Alignment.center, // center the dropdown button
                             underline: Container(),
                           ),
                         ),
                       ],),
                     ),

                     // Slider(Increase Size)
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,vertical: screenWidth * 0.05),
                       child: Row(children: [

                         SizedBox(width: screenWidth * 0.04,),
                         Container(
                           width:screenWidth * 0.04,
                           height: screenWidth * 0.04,
                           child: Image(image: AssetImage("assets/image/tt.png")),),
                         SizedBox(width: screenWidth * 0.02,),
                         Text("Font size",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth * 0.04,fontFamily: 'Roboto',color: CustomColors.clrblack),),

                         Spacer(),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                           child:  Slider(
                               value: _fontSize,
                               min: 12,
                               max: 25,
                               divisions: 12,
                               label: '${_fontSize.round()}',
                               onChanged: (double value) {
                                 setState(() {
                                   _fontSize =  value;
                                 });
                                 _updateFontSize(value);
                               },
                               activeColor: Colors.black,
                               thumbColor: Colors.brown,
                               inactiveColor: Colors.brown,
                             ),
                           ),
                       ],),
                     ),

                     // Themes
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical: screenWidth * 0.05),
                       child: Row(children: [

                         Icon(Icons.color_lens_rounded,size: screenWidth * 0.06,color: CustomColors.clrblack,),
                         SizedBox(width: screenWidth * 0.02,),
                         Text("Themes",style: TextStyle(fontWeight: FontWeight.w500,fontSize: screenWidth * 0.04,fontFamily: 'Roboto',color: CustomColors.clrblack),),

                         
                         Spacer(),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[



                               ColorContainer(
                                 color: CustomColors.clrskin,
                                 onTap:(){
                                   _changeThemeMode(false);
                                 }
                                 //_handleSkinTap,
                               //  isSelected: _isSelectedSkin,
                               ),
                               ColorContainer(
                                 color: CustomColors.clrblack,
                                 onTap:(){
                                   _changeThemeMode(true);
                                 }
                                 //_handleBlackTap,
                                // isSelected: _isSelectedBlack,
                               ),


                             ],
                           ),
                         ),


                       ],),
                     ),
                     Divider(),

                     // Chane Text In Hindi
                     Transform.scale(
                         scale: 0.7,
                         child: SwitchListTile(
                           title: Row(
                             children: [
                               Icon(Icons.menu_book,color: CustomColors.clrblack,size: screenWidth * 0.07,),
                               SizedBox(width: screenWidth * 0.02,),
                               Text("Translation",style: TextStyle(fontSize: screenWidth * 0.07,color: CustomColors.clrblack),)
                             ],
                           ),
                           value: _showHindiText,
                           onChanged: (value) {
                             setState(() {
                               _showHindiText = value;
                             });
                           _updateHindiText(value);
                           },  // Add this line
                           activeColor: Colors.brown,
                         ),
                       ),

                     // Chane Text In English
                     Transform.scale(
                         scale:  0.7,
                         child: SwitchListTile(
                           title: Row(
                             children: [
                               Icon(Icons.menu_book,color: CustomColors.clrblack,size: screenWidth * 0.07,),
                               SizedBox(width: screenWidth * 0.02,),
                               Text("Translitration",style: TextStyle(fontSize: screenWidth * 0.07,color: CustomColors.clrblack),),
                             ],
                           ),
                           value: _showEnglishText,
                           onChanged: (value) {
                             setState(() {
                               _showEnglishText = value;
                             });
                            _updateEnglishText(value);
                           },
                           activeColor: Colors.brown,

                         ),
                       ),
                     Divider()

                   ],
                 ),
               );
             }
           );
      },
    );
  }

  // Dialog Box
  showmeDialog(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
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
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),

                DropdownButton<String>(
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
                      child: Text(chap),
                    );
                  }).toList(),
                ),

                SizedBox(height: screenWidth * 0.04),
                Text(
                  'Shlok',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Enter between 1 - 4',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: screenWidth * 0.03),
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
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.white,
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
                      child: Text(
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
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SafeArea(
        child: Scaffold(
          //backgroundColor: CustomColors.clrwhite,
          body: CustomScrollView(
            slivers: [
      
              SliverAppBar(
                backgroundColor: _isDarkMode ? CustomColors.clrblack : CustomColors.clrorange,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GitaChapter(isDarkMode: _isDarkMode,isIncrease: _fontSize,),));
                    //Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: CustomColors.clrwhite, size: screenWidth * 0.06),
                ),
      
                title: Text("Sahitya", style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.w600, fontFamily: 'Roboto',color: CustomColors.clrwhite)),
      
                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(),));
                          },
                          child: Icon(Icons.search, color: CustomColors.clrwhite,
                            size: screenWidth * 0.06,),
                        ),
                        SizedBox(width: screenWidth * 0.02,),
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet();
                           // Navigator.push(context, DialogRoute(context: context, builder: (context) => EditScreen(),));
                          },
                          child: Icon(Icons.edit, color: CustomColors.clrwhite,
                            size: screenWidth * 0.06,),
                        )
                      ],
                    ),
                  )
                ],
              ),
      
              SliverAppBar(

                backgroundColor:  _isDarkMode ? CustomColors.clrblack: CustomColors.clrfavblue,
                shadowColor: Colors.black,
                toolbarHeight: screenWidth * 0.2,
                automaticallyImplyLeading: false,
                pinned: true,
                flexibleSpace: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    //image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/e584/7a76/4c85096d843730cbdef709a0ea3eb074?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CEooIgkrvVOQZOPLeZ~sKTj6c-sU8oUutC25NuqYubQleUao1LzAn1l8~BZsr1MCrb93JAW4Yl0-iec1PPdHk7lesu3LkJW-TH1xpPhrzn8sc3tgk8MwgmaiPPF7sjmrkZXNCd9QGfLWBg7xAkAsypgKoJyluRAS3ZPwGvp7sY5w4DF2zDlk6PoTpNbegcloATgUCl3krv-pTpaeKEl2GZtSjP7e4Yxe~vvBtMLk8Xty4tZFOP-1o0Xnom~6zwtImUxq-60GtnFO-8i5rB3HiXiZs~Xx5tWdyOsgNo-vIUE2Yx9L8NiM93kQ8cMJThQvYgFlxLbhZ6MFjW0~FpgQ1Q__"),fit:BoxFit.cover)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Row(
                      children: [
      
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.clrwhite,
                            shape: BoxShape.circle,
                            border: Border.all(color: _isDarkMode ? Colors.orangeAccent :CustomColors.clrbrown, width: screenWidth  * 0.002,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.002),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chapter',
                                  style: TextStyle(fontSize: screenWidth * 0.03,color: CustomColors.clrblack),
                                ),
                                Text(
                                  '18',
                                  style: TextStyle(fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,color: CustomColors.clrblack),
                                ),
                              ],
                            ),
                          ),
                        ),
      
                        GestureDetector(
                          onTap: () {
                            showmeDialog(context);
                          },
                          child: Container(
                            width: screenWidth * 0.6,
                            height: screenWidth * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/image/frame.png"),fit: BoxFit.cover)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                 // vertical: screenWidth * 0.001
                                ),
                               child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.03,),
                                  Text('Arjun Vishad Yog',style: TextStyle(fontSize: screenWidth * 0.04),),
                                  Icon(Icons.arrow_drop_down,size: screenWidth * 0.05,),
                                ],
                              ),
                            ),
                          ),
                        ),
      
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.clrwhite,
                            shape: BoxShape.circle,
                            border: Border.all(color: _isDarkMode ? Colors.orangeAccent :CustomColors.clrbrown, width: screenWidth * 0.002,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.002),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chapter',
                                  style: TextStyle(fontSize: screenWidth * 0.03,color: CustomColors.clrblack),
                                ),
                                Text(
                                  '18',
                                  style: TextStyle(fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,color: CustomColors.clrblack),
                                ),
                              ],
                            ),
                          ),
                        ),
      
      
                      ],
                    ),
                  ),
                ),
              ),
      
              SliverToBoxAdapter(
                child: Column(
                  children: [
      
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                      return  Container(
                          child: Column(
                            children: [
      
                              Container(
                                color: _isDarkMode? CustomColors.clrblack:CustomColors.clrskin,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                                  child: Column(
                                    children: [
      
                                    Text("धर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः । मामकाः पाण्डवाश्चैव किमकुर्वत संजय ॥1-1॥",textAlign: TextAlign.center,style: TextStyle(fontSize: _fontSize ,fontWeight: FontWeight.w400,fontFamily: _selectedFont),),
      
                                      Padding(
                                        padding:EdgeInsets.symmetric(horizontal: screenWidth * 0.07,vertical: screenWidth * 0.08),
                                        child: Row(
                                          children: [
      
                                            GestureDetector(onTap: () {
                                              Navigator.push(context, DialogRoute(context: context, builder: (context) => ShareScreen(),));
                                            },child: Icon(Icons.share_outlined,color: _isDarkMode ? Colors.white: CustomColors.clrbrown,size: screenWidth * 0.07,)),
      
                                            SizedBox(width: screenWidth * 0.03,),
                                            GestureDetector(onTap: () {
      
                                            },child: Icon(Icons.bookmark_border,color: _isDarkMode ? Colors.white: CustomColors.clrbrown,size: screenWidth * 0.07,)),
      
                                            Spacer(),
                                            GestureDetector(onTap: () {
      
                                            },child: Icon(Icons.play_circle_fill,color: _isDarkMode ? Colors.white: CustomColors.clrbrown,size: screenWidth * 0.08,)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
      
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.004),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: _showHindiText,
                                      child: Column(
                                        children: [
                                          Text(
                                            "भावार्थ : धृतराष्ट्र बोले- हे  संजय! धर्मभूमि कुरुक्षेत्र में एकत्रित, युद्ध की इच्छावाले मेरे और पाण्डु के पुत्रों ने क्या किया?॥1-1॥",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                                          ),
                                         Container(
                                           height: screenWidth * 0.03,
                                         )
                                        ],
                                      ),
                                    ),
                                   // SizedBox(height: screenWidth * 0.05,),
                                    Visibility(
                                      visible: _showEnglishText,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Meaning: Dhritarashtra said – O Sanjay! What did I and Pandu's sons, desirous of war, gather in the sacred land of Kurukshetra?॥1-1॥",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                                          ),
                                          Divider(
                                            color: _isDarkMode? Colors.orangeAccent : CustomColors.clrblack,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
      
      
                            ],
                          ),
                        );
                    },)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }


class ColorContainer extends StatefulWidget {
  final Color color;
  final VoidCallback onTap;

  ColorContainer({required this.color, required this.onTap});

  @override
  State<ColorContainer> createState() => _ColorContainerState();
}

class _ColorContainerState extends State<ColorContainer> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
        child: Container(
          width: screenWidth * 0.06,
          height: screenWidth * 0.06,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: _isSelected
                ? Border.all(color: Colors.brown, width: 2)
                : null,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
