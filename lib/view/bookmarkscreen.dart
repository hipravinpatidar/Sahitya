import 'package:flutter/material.dart';
import 'package:sahityadesign/ui_helpers/custom_colors.dart';
import 'package:sahityadesign/view/gita_chapter.dart';
import 'package:sahityadesign/view/share_screen.dart';
import 'package:sahityadesign/view/gita_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

 // late TabController _tabController;


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: CustomColors.clrwhite,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: CustomColors.clrwhite),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back
              },
            ),
            title: Text('Bookmark', style: TextStyle(color: CustomColors.clrwhite, fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: screenWidth * 0.06)),
            backgroundColor: CustomColors.clrorange,
          ),

          body: Column(
            children: [


              TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: CustomColors.clrblack,
                  indicatorColor: CustomColors.clrorange,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                  Tab(text: "Shlok",),
                  Tab(text: "Chapter",),
                ]),


              Expanded(child: TabBarView(
                children: [

                  BookMarkShlOk()


                ],
              ))


            ],
          )

        ),
    );
  }
}


class BookMarkShlOk extends StatelessWidget {
  const BookMarkShlOk({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [



      ],
    );
  }
}



