import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahityadesign/model/chapters_model.dart';
import 'package:sahityadesign/ui_helpers/custom_colors.dart';
import 'package:screenshot/screenshot.dart';
import '../controller/share_verse.dart';

class ShareScreen extends StatefulWidget {
    ShareScreen({super.key,required this.gitaShlok,required this.shlokMeaning,required this.detailsModel, this.chapterName, this.verseSerial});

  final String gitaShlok;
  final String shlokMeaning;
  final String? chapterName;
  final int? verseSerial;

    Verse? detailsModel;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {

  final shareVerse = ShareVerse();

  Color color = Colors.red;
  bool _showColor = true;
  bool _showimage = false;
  int _selectedContainer = 1;
  int _colorIndex = 0;

  final List<Color> _colors = [Colors.cyan, Colors.green, Colors.black54 , Colors.black , Colors.brown];

  int _gradIndex = 0;
  final List<Gradient> _gradColors = [
    const LinearGradient(colors: [Colors.red, Colors.orange]),
    const LinearGradient(colors: [Colors.green, Colors.yellow]),
    const LinearGradient(colors: [Colors.blue, Colors.indigo]),
    const LinearGradient(colors: [Colors.purple, Colors.pink]),
    const LinearGradient(colors: [Colors.cyan, Colors.teal]),
  ];


  int _imageIndex = 0;
  final List<String> _images = [

    "assets/image/imagefirst.jpg",
    "assets/image/imagesecond.jpg",
    "assets/image/imagethird.jpg",

  ];


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.clrwhite,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.clrwhite,size: screenWidth * 0.06,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Share', style: TextStyle(color: CustomColors.clrwhite, fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: screenWidth * 0.06)
          ),
          backgroundColor: CustomColors.clrorange,
        ),
      
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.05, right: screenWidth * 0.05),
                child: Screenshot(
                  controller: context.watch<ShareVerse>().screenshotController,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _showColor ? _colors[_colorIndex] : null,
                      gradient: _showColor ? null : _gradColors[_gradIndex],
                      image: _showimage ? DecorationImage(image: AssetImage(_images[_imageIndex]),fit: BoxFit.cover) : null
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(top: screenWidth * 0.05),
                      child: Column(
                        children: [

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                            child: Column(
                              children: [

                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text("||",style: TextStyle(color: CustomColors.clrwhite,fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold),),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text('ॐ',style: TextStyle(color: CustomColors.clrwhite,fontFamily: "Roboto",fontSize: screenWidth * 0.07,fontWeight: FontWeight.w700),),
                                      SizedBox(width: screenWidth * 0.02,),
                                      Text("||",style: TextStyle(color: CustomColors.clrwhite,fontSize: screenWidth * 0.05,fontWeight: FontWeight.bold),),

                                    ],
                                  ),

                                Text('॥ श्रीमद् भगवद् गीता ॥',style: TextStyle(fontSize: screenWidth * 0.04,fontFamily: 'Roboto',fontWeight: FontWeight.w800,color: Color.fromRGBO(255, 255, 255, 1),decoration: TextDecoration.underline,decorationColor: Colors.white),),
                                SizedBox(height: screenWidth * 0.01,),
                                Text(widget.gitaShlok,textAlign: TextAlign.center,style: TextStyle(fontSize: screenWidth * 0.04,fontFamily: 'Roboto',fontWeight: FontWeight.w600,color: CustomColors.clrwhite)),

                                Padding(
                                  padding:  EdgeInsets.only(left: screenWidth * 0.02,right: screenWidth * 0.02),
                                  child: Divider(thickness: screenWidth * 0.002,),
                                ),

                                SizedBox(height: screenWidth * 0.03,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: CustomColors.clrwhite,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                                    child: Text('भावार्थ',style: TextStyle(fontFamily: 'Roboto',fontSize: screenWidth * 0.04,fontWeight: FontWeight.w400,color: Color.fromRGBO(0, 0, 0, 1)),),
                                  ),
                                ),


                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                      Text(widget.shlokMeaning,textAlign: TextAlign.center,style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600,color: CustomColors.clrwhite),),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                                        child: Text('${(widget.chapterName)}  श्लोक: ${widget.verseSerial}',textAlign: TextAlign.center,style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600,color: CustomColors.clrwhite),),
                                      ),

                                      Padding(
                                        padding:  EdgeInsets.only(left: screenWidth * 0.02,right: screenWidth * 0.02),
                                        child: Divider(thickness: screenWidth * 0.002,),
                                      ),
                                    ],
                                   ),
                                 ),
                              ],
                            ),
                          ),


                          Container(
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.2),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical: screenWidth * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  GestureDetector(
                                    child: Container(
                                      height: screenWidth * 0.08,
                                      width: screenWidth * 0.15,
                                      decoration: BoxDecoration(
                                        color: CustomColors.clrblack,
                                        image: const DecorationImage(image: AssetImage("assets/image/playstore.png"),fit: BoxFit.contain),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    child: Container(
                                     // height: 30,
                                      height: screenWidth * 0.08,
                                      width: screenWidth * 0.15,
                                      decoration: BoxDecoration(
                                        color: CustomColors.clrblack,
                                        image: const DecorationImage(image: AssetImage("assets/image/appstore.png"),fit: BoxFit.contain),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    child: Container(
                                       // height: 55,
                                      height: screenWidth * 0.13,
                                       // width: 180,
                                        width: screenWidth * 0.45,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(left: screenWidth * 0.02,right: screenWidth * 0.02),
                                          child: const Image(image: AssetImage("assets/image/appwhitelogo.png"),fit : BoxFit.fill,),
                                        )
                                    ),
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
              ),
                
                
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2,vertical: screenWidth * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      children: [

                        Container(
                          height: screenWidth * 0.05,
                          width: screenWidth * 0.05,
                          decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage("https://icon-library.com/images/theme-icon-png/theme-icon-png-27.jpg"))),
                        ),
                        SizedBox(height: screenWidth * 0.02,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _colorIndex = (_colorIndex + 1) % _colors.length;
                              _showColor = true;
                              _showimage = false;
                              _selectedContainer = 0;
                            });
                          },
                          child: Container(
                            height: screenWidth * 0.1,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                            color: _colors[_colorIndex],
                            border: _selectedContainer == 0 ? Border.all(color:  CustomColors.clrskin,width: 4): null),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [

                        Container(
                            height: screenWidth * 0.05,
                            width: screenWidth * 0.05,
                          decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage("https://cdn.icon-icons.com/icons2/368/PNG/512/Themes_37103.png"))),
                        ),

                        SizedBox(height: screenWidth * 0.02,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _gradIndex = (_gradIndex + 1) % _gradColors.length;
                              _showColor = false;
                              _showimage = false;
                              _selectedContainer = 1;

                            });
                          },
                          child: Container(
                            height: screenWidth * 0.1,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                            border: _selectedContainer == 1 ? Border.all(color: CustomColors.clrskin,width: 4) : null,
                            gradient: _gradColors[_gradIndex],),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                
                        Container(
                          height: screenWidth * 0.05,
                          width: screenWidth * 0.05,
                          decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage("https://cdn-icons-png.flaticon.com/512/5460/5460486.png"))),
                        ),
                
                        SizedBox(height: screenWidth * 0.02,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _imageIndex = (_imageIndex + 1) % _images.length;
                              _showimage = true;
                              _showColor = false;
                              _selectedContainer = 2;

                            });
                          },
                          child: Container(
                            height: screenWidth * 0.1,
                            width: screenWidth * 0.1,
                            decoration: BoxDecoration(shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(_images[_imageIndex]),fit: BoxFit.cover),
                            border: _selectedContainer == 2 ? Border.all(color: CustomColors.clrskin,width: 4) : null
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
                
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: GestureDetector(
                  onTap: () {
                   // shareVerse.shareVerse(widget.detailsModel!);
                    context.read<ShareVerse>().shareCustomDesign(widget.detailsModel!);
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(1),
                      color: const Color.fromRGBO(0, 71, 255, 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:  screenWidth * 0.02),
                      child: Row(
                        children: [
                          SizedBox(width: screenWidth * 0.3,),
                          Text("Share Image",style: TextStyle(fontSize: screenWidth * 0.04,color: CustomColors.clrwhite,fontWeight: FontWeight.w400),),
                          SizedBox(width: screenWidth * 0.05,),
                          Icon(Icons.share,color: CustomColors.clrwhite,size: screenWidth * 0.1,)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}