import 'package:flutter/material.dart';
import 'package:sahityadesign/view/gita_chapter/gitachapter.dart';
import '../../ui_helpers/custom_colors.dart';

class SahityaList extends StatefulWidget {
  const SahityaList({super.key});

  @override
  State<SahityaList> createState() => _SahityaListState();
}

class _SahityaListState extends State<SahityaList> {

  double _fontSize = 14;

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
                     case 0: Navigator.push(context, MaterialPageRoute(builder: (context) => GitaChapter(isToast: false,),));
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
                              image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/cfcc/6aec/3ac0958bc4f545a194db3f798e8d8220?Expires=1722816000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lLPzeYyW0gQOIDmrN6peBPWxG2-~jet~uwDTqPSudcvxMg1yCgJv-xV7itbhdbvMhLEs0YGVi0vU020m56pqf1ccFwHSNktsa4-Becupsov4U2X7iY2jrFsJw1vjxh-8TaHhdUEalMH10eaOqz4B-6RLvaP1khyJ0LKrrkCLSPtW2lPSwD-a45imGxQ9rQ4mSfK0nbcbm4C-JsSjEGe~YAarl8aWejXojHB2zDGgtB2KNNB76OUqlhS~u7KrGKR97ajlEauqqYD2KE-i~4OGBZnyobspIUxXmYidhcSuAZqnzRYr89tcukAX7lJeXni3R0d6cWXXURGFjU4oYeb5Fw__"),fit: BoxFit.cover)
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
