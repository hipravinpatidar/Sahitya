import 'package:flutter/material.dart';
import 'package:sahityadesign/model/bhagwat_model.dart';
import 'package:sahityadesign/ui_helpers/custom_colors.dart';
import 'package:sahityadesign/view/gita_screen.dart';
import 'package:sahityadesign/view/sahitya_home.dart';
import 'package:sahityadesign/view/saved_itemscreen.dart';
import '../ui_helpers/theme_manager.dart';

class GitaChapter extends StatefulWidget {
      GitaChapter({super.key, required this.fontSize});

      double fontSize;

  @override
  State<GitaChapter> createState() => _GitaChapterState();
}

class _GitaChapterState extends State<GitaChapter> {


  List<BhagwatModel> bhagwatitem =[

    BhagwatModel(id: "1",slok: "Slok 1 -18",titile: "Arjun Vishad Yog"),
    BhagwatModel(id: "2",slok: "Slok 1 -72",titile: "Sankhya Yog"),
    BhagwatModel(id: "3",slok: "Slok 1 -50",titile: "Karm Yog"),
    BhagwatModel(id: "4",slok: "Slok 1 -30",titile: "Gyan Karm Sanyas Yog"),
    BhagwatModel(id: "5",slok: "Slok 1 -12",titile: "Karm Sanyas Yog"),
    BhagwatModel(id: "6",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
    BhagwatModel(id: "7",slok: "Slok 1 -45",titile: "Gyan Vigyan Yog"),
    BhagwatModel(id: "8",slok: "Slok 1 -45",titile: "Akshar Brahma Yog"),
    BhagwatModel(id: "9",slok: "Slok 1 -45",titile: "Raj Vidhya Raj Guhya Yog"),
    BhagwatModel(id: "10",slok: "Slok 1 -45",titile: "Vibhuti Yog"),
    BhagwatModel(id: "11",slok: "Slok 1 -45",titile: "Vishwarup Darshan Yog"),
    BhagwatModel(id: "12",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
    BhagwatModel(id: "13",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
    BhagwatModel(id: "14",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
    BhagwatModel(id: "15",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
    BhagwatModel(id: "16",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
    BhagwatModel(id: "17",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
    BhagwatModel(id: "18",slok: "Slok 1 -45",titile: "Aatmsayam Yog"),
  ];
  List<bool> _isBookmarked = [];
  List<String> _savedItems = [];


  void _showSaveOptionsDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          backgroundColor: CustomColors.clrwhite,
          title: Text('Save As',style: TextStyle(color: CustomColors.clrblack),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Save as Read',style: TextStyle(color: CustomColors.clrblack),),
                onTap: () {
                  _saveItem('Read: ${bhagwatitem[index].titile}');
                  _saveBookmark(index);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Save as Recite',style: TextStyle(color: CustomColors.clrblack),),
                onTap: () {
                  _saveItem('Recite: ${bhagwatitem[index].titile}');
                  _saveBookmark(index);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Save as Memories',style: TextStyle(color: CustomColors.clrblack),),
                onTap: () {
                  _saveItem('Memories:${bhagwatitem[index].titile}');
                  _saveBookmark(index);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveItem(String category) {
    setState(() {
      _savedItems.add(category);
    });
  }

  void _saveBookmark(int index) {
    setState(() {
      _isBookmarked[index] = true;
    });
  }

  void _removeBookmark(int index) {
    setState(() {
      _isBookmarked[index] = false;
    });
    _removeItemFromSavedList(index);
  }

  void _removeItemFromSavedList(int index) {
    String? title = bhagwatitem[index].titile;
    _savedItems.removeWhere((item) => item.contains(title ?? ''));
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < bhagwatitem.length; i++) {
      _isBookmarked.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getInstance()!.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: ThemeManager.getInstance()!.isDarkMode ?  CustomColors.clrblack : CustomColors.clrorange,
            leading: GestureDetector(
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SahityaHome(),));
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SavedItemsScreen(_savedItems,bhagwatitem,_removeItemFromSavedList)),
                      );
                    },child: Icon(Icons.bookmark,color: CustomColors.clrwhite,size: screenWidth * 0.06,)),
                  SizedBox(width: screenWidth * 0.02,),
                  Icon(Icons.search,color: CustomColors.clrwhite,size: screenWidth * 0.06,)

                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
               color:ThemeManager.getInstance()!.isDarkMode ?  CustomColors.clrwhite : Colors.orange,
               child: Center(child: Padding(
                 padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                 child: Text('Continue Reading - Arjun Vishad Yog(18)',style: TextStyle(fontFamily: 'Roboto',fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600,color: ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrblack : CustomColors.clrwhite),),
               ))),

              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: screenWidth * 0.08),
                physics: NeverScrollableScrollPhysics(),
                itemCount: bhagwatitem.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.01),
                    child: Column(
                        children: [

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                            child: Row(
                              children: [

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GitaScreen(selectedChapter: bhagwatitem[index].id ?? ''),));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: screenWidth * 0.1,
                                        width: screenWidth * 0.1,
                                        decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/36a3/2922/97b18f95800c21a19772628ab8e43252?Expires=1722816000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ACcazxZPRqxAvSBZY3n9~0b9nAKdkqts5mdAGQt7iCLb5Ud8qKPpViHXie6ra1Cc1WIX8uVjOBVpaxY3cycDS6qd1S~Ijd5-VqaHGPWWt239SbLcslOnMHBOXaKX9DVS0~-Zjf5nD7KLDeiCVxju-5~o2jJFFfjguPQvLflFM5sBEn5WZCXWNSGjAeQSfKC5svqzvfCrBwf~4JPTJtmWCHzIFZ3mhLidaGvNk4wT24hqg5RHCJUvwCT~nHFFbiaotgIUw6x2hLFJZvlOkfxw-rVYJuyGFJJWiEk4jM15dakS7YCE8hM1lQN5k9L1RfjDusOy-E3HDLs8GsM-vgfuJw__"))
                                        ),
                                        child: Center(
                                          child: Text(bhagwatitem[index].id as String,style: TextStyle(fontSize: screenWidth * 0.03,fontFamily: 'Roboto',),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(left: screenWidth * 0.05),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(width: screenWidth * 0.6,child: Text(bhagwatitem[index].titile ?? '',style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.w500,fontSize: widget.fontSize,overflow: TextOverflow.ellipsis),maxLines: 1,)),
                                            SizedBox(width: screenWidth * 0.6,child: Text(bhagwatitem[index].slok ?? '',style: TextStyle(fontSize: widget.fontSize,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),maxLines: 1,)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Spacer(),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: Icon(Icons.play_arrow, size: screenWidth * 0.08, color: CustomColors.clrorange,),
                                    ),
                                    SizedBox(width: screenWidth * 0.02,),
                                    GestureDetector(
                                        onTap: () {
                                          if(!_isBookmarked[index]){
                                            setState(() {
                                              _showSaveOptionsDialog(index);
                                              _saveBookmark(index);
                                            });
                                            _isBookmarked[index] = false;
                                          }else{
                                            _removeBookmark(index);
                                            setState(() {
                                              _isBookmarked[index] = false;
                                            });
                                          }
                                        },
                                        child: Icon( _isBookmarked[index] ? Icons.bookmark: Icons.bookmark_outline, size: screenWidth * 0.07, color: CustomColors.clrorange,)),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: screenWidth * 0.02,),
                          Divider(
                              height: screenWidth * 0.002,
                              color: ThemeManager.getInstance()!.isDarkMode ?  Colors.orangeAccent : CustomColors.clrblack,
                          )
                        ],
                      ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
