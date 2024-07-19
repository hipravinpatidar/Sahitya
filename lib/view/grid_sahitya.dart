import 'package:flutter/material.dart';
import 'package:sahityadesign/view/gita_chapter.dart';

import '../ui_helpers/custom_colors.dart';

class GridSahitya extends StatefulWidget {
  const GridSahitya({super.key});

  @override
  State<GridSahitya> createState() => _GridSahityaState();
}

class _GridSahityaState extends State<GridSahitya>{

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

      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: screenWidth<500 ? 0.78 : 0.9
        ),
        itemCount: 20,
        itemBuilder: (context, index) {

          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GitaChapter(isDarkMode: _isDarkMode,isIncrease: _fontSize,),));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: CustomColors.clrwhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey,
                              spreadRadius: 0.5,
                              blurRadius: 1.5,
                              offset: Offset(0, 0.5))
                        ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                            height: constraints.maxHeight * 0.6,
                            width: constraints.maxWidth * 1,
                            decoration:BoxDecoration(
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(5)),
                                image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/f2ae/00fc/51387a14c0774e081257e09ed40e5e7a?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=eCIRf1~tQL9myZAUPelV-b49b5AcupdjyUsxtijOdm2nKgiT3Jq2Hiw0QtrDr-oiRzxnIseleZHJb9bfB~RTi~4aF5uOjw1VaawBgDvGEG0zZEMF5fklRIFfM2pQUjyTlTluAkrgCj17J8OQh088H0QWNIAMuYGo-yh3SHgkAaCMJckNPfEJS8QP~UMYh3JakZSyBnDWFxyTzIaNjFbXUkVnzHPbnSvaDMfsTkBkQIFkxwi~ztkij1-QLuKAla3DexOS~U84T67W79iUiKDdQjOupjCucsiC6Gf6LmHnkWY4uG5JuWwUkjvfue2BlHaCbtXQEeRLtwvPlxkm38kUvQ__"),fit: BoxFit.cover) )
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width:screenWidth * 0.4,child: Text("Shrimad Bhagwat Gita",style: TextStyle(fontSize: screenWidth * 0.03,fontWeight: FontWeight.w700,fontFamily: 'Roboto',color: CustomColors.clrblack,overflow: TextOverflow.ellipsis,decoration: TextDecoration.underline),maxLines: 1)),

                              Text.rich(TextSpan(
                                  children:[

                                    TextSpan(text: "18",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrblack,fontSize: screenWidth * 0.03)),
                                    TextSpan(text: "Chapters",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrblack,fontSize: screenWidth * 0.03,overflow: TextOverflow.ellipsis)),
                                  ]
                              )
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },),
    );
  }
}