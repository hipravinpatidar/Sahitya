import 'package:flutter/material.dart';
import 'package:sahityadesign/view/gita_chapter/gita_chapter.dart';
import 'package:sahityadesign/view/gitastatic.dart';
import '../../ui_helpers/custom_colors.dart';

class GridSahitya extends StatefulWidget {
  const GridSahitya({super.key});

  @override
  State<GridSahitya> createState() => _GridSahityaState();
}

class _GridSahityaState extends State<GridSahitya>{

  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;

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
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => GeetaChapter(),));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GitaStatic(isToast: false,),));
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
                            decoration:const BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(5)),
                              image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/cfcc/6aec/3ac0958bc4f545a194db3f798e8d8220?Expires=1722816000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lLPzeYyW0gQOIDmrN6peBPWxG2-~jet~uwDTqPSudcvxMg1yCgJv-xV7itbhdbvMhLEs0YGVi0vU020m56pqf1ccFwHSNktsa4-Becupsov4U2X7iY2jrFsJw1vjxh-8TaHhdUEalMH10eaOqz4B-6RLvaP1khyJ0LKrrkCLSPtW2lPSwD-a45imGxQ9rQ4mSfK0nbcbm4C-JsSjEGe~YAarl8aWejXojHB2zDGgtB2KNNB76OUqlhS~u7KrGKR97ajlEauqqYD2KE-i~4OGBZnyobspIUxXmYidhcSuAZqnzRYr89tcukAX7lJeXni3R0d6cWXXURGFjU4oYeb5Fw__"),fit: BoxFit.cover)
                              ),),

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