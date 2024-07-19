import 'package:flutter/material.dart';
import 'package:sahityadesign/view/gita_chapter.dart';

import '../ui_helpers/custom_colors.dart';

class SahityaList extends StatefulWidget {
  const SahityaList({super.key});

  @override
  State<SahityaList> createState() => _SahityaListState();
}

class _SahityaListState extends State<SahityaList> {

  bool _isDarkMode = false;
  double _fontSize = 14;

  void _changeThemeMode(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  void _updateFontSize(double fontSize) {
    setState(() {
      _fontSize = fontSize;
    });
  }

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors.clrwhite,
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03,horizontal: screenWidth * 0.03),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {

                switch(index){

                     case 0: Navigator.push(context, MaterialPageRoute(builder: (context) => GitaChapter(isDarkMode: _isDarkMode,isIncrease: _fontSize,),));

                //   case 1: Navigator.push(context, MaterialPageRoute(builder: (context) => Videomovies(),));
                //
                //   case 2: Navigator.push(context, MaterialPageRoute(builder: (context) => Videobhajan(),));
                //
                //   case 3: Navigator.push(context, MaterialPageRoute(builder: (context) => Videospritual(),));

                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.008),
                child: Container(
                  decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CustomColors.clrggreytxt)
                  ),
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Row(
                        children: [

                          Container(
                            height: screenWidth * 0.20,
                            width: screenWidth * 0.20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/f2ae/00fc/51387a14c0774e081257e09ed40e5e7a?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=eCIRf1~tQL9myZAUPelV-b49b5AcupdjyUsxtijOdm2nKgiT3Jq2Hiw0QtrDr-oiRzxnIseleZHJb9bfB~RTi~4aF5uOjw1VaawBgDvGEG0zZEMF5fklRIFfM2pQUjyTlTluAkrgCj17J8OQh088H0QWNIAMuYGo-yh3SHgkAaCMJckNPfEJS8QP~UMYh3JakZSyBnDWFxyTzIaNjFbXUkVnzHPbnSvaDMfsTkBkQIFkxwi~ztkij1-QLuKAla3DexOS~U84T67W79iUiKDdQjOupjCucsiC6Gf6LmHnkWY4uG5JuWwUkjvfue2BlHaCbtXQEeRLtwvPlxkm38kUvQ__"),fit: BoxFit.cover)
                            ),
                          ),

                          Padding(
                            padding:EdgeInsets.symmetric(horizontal: screenWidth * 0.03,vertical: screenWidth * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                SizedBox(width:screenWidth * 0.5,child: Text("Shrimad Bhagwat Gita",style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.w700,fontFamily: 'Roboto',color: CustomColors.clrblack,overflow: TextOverflow.ellipsis,decoration: TextDecoration.underline),maxLines: 1)),

                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.002),
                                  child: Text.rich(TextSpan(
                                      children:[

                                        TextSpan(text: "18",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrblack,fontSize: screenWidth * 0.04)),
                                        TextSpan(text: " Chapters",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrblack,fontSize: screenWidth * 0.04,overflow: TextOverflow.ellipsis)),
                                      ]
                                  )
                                  ),
                                ),

                                SizedBox(width: screenWidth * 0.5,child: Text("The Shrimad Bhagavad Gita is a revered Hindu scripture where Lord Krishna advises the warrior Arjuna on duty, righteousness, and spiritual wisdom during the Mahabharata war.",style: TextStyle(fontFamily: 'Roboto',fontSize: screenWidth * 0.03,fontWeight: FontWeight.w500,color: CustomColors.clrblack,overflow: TextOverflow.ellipsis),maxLines: 2,))

                              ],
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
              )
          );
        },),
    );
  }
}
