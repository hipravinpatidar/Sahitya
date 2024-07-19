import 'package:flutter/material.dart';
import 'package:sahityadesign/model/bhagwat_model.dart';
import 'package:sahityadesign/ui_helpers/custom_colors.dart';
import 'package:sahityadesign/view/edit_screen.dart';
import 'package:sahityadesign/view/gita_screen.dart';
import 'package:sahityadesign/view/sahitya_home.dart';
import 'package:sahityadesign/view/sahitya_list.dart';
import 'package:sahityadesign/view/saved_itemscreen.dart';

class GitaChapter extends StatefulWidget {
  //final Function(bool) changeThemeMode;

  final bool isDarkMode;
   final double isIncrease;
  GitaChapter({required this.isDarkMode,required this.isIncrease});


// GitaChapter({super.key});


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
      theme: widget.isDarkMode? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
       // backgroundColor:  CustomColors.clrwhite,
        appBar: AppBar(
          backgroundColor: widget.isDarkMode ? CustomColors.clrblack : CustomColors.clrorange,
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
              color: widget.isDarkMode ? CustomColors.clrwhite : Colors.orange,
               child: Center(child: Padding(
                 padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                 child: Text('Continue Reading - Arjun Vishad Yog(18)',style: TextStyle(fontFamily: 'Roboto',fontSize: screenWidth * 0.04,fontWeight: FontWeight.w600,color: widget.isDarkMode ? CustomColors.clrblack : CustomColors.clrwhite),),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GitaScreen(),));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: screenWidth * 0.1,
                                        width: screenWidth * 0.1,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/36a3/2922/97b18f95800c21a19772628ab8e43252?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=PP1XQvqjg6FWm53LSfN9-7-FAXShaythuEs6G1dVPxyYoi1kmCXq7yi4SqRB9ZUGL4Yw4Pr1mzBzu8mPitt2eWAqhMNlEZ9gjXgPSrJew-QjoP9TQIa3OHKBwNfYCvkd4uWvAW6GVC-g~ibz~uDd9-OvZasZc73bPD6Z~BAolJ8a1oYe2YQBIrjmM5VOlHW-jb5fnysI2zDj~S8A13g-qQkZeV-MP4gsDRCCDxzKQlrZuTZdebNYEMYtYPsMYVBgsfvbnsg2Ak1DB8r-TLizZH7kmGTdotGHiiwsKd-TL9kkFy5amd-TyiKAIKTiWO-5Ik0n85UEVzATJNUfFrV0wQ__"), fit: BoxFit.cover,
                                          ),
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
                                            SizedBox(width: screenWidth * 0.6,child: Text(bhagwatitem[index].titile ?? '',style: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.w500,fontSize: widget.isIncrease,overflow: TextOverflow.ellipsis),maxLines: 1,)),
                                            SizedBox(width: screenWidth * 0.6,child: Text(bhagwatitem[index].slok ?? '',style: TextStyle(fontSize: widget.isIncrease,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),maxLines: 1,)),
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
                              color: widget.isDarkMode? Colors.orangeAccent : CustomColors.clrblack
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

//
// class SavedItemsScreen extends StatefulWidget {
//   final List<String> _savedItems;
//   final Function _removeItemFromSavedList;
//   final List<BhagwatModel> _bhagwatItems;
//
//
//   SavedItemsScreen(this._savedItems, this._bhagwatItems, this._removeItemFromSavedList);
//
//   @override
//   _SavedItemsScreenState createState() => _SavedItemsScreenState();
// }
//
// class _SavedItemsScreenState extends State<SavedItemsScreen> {
//   List<String> _readItems = [];
//   List<String> _reciteItems = [];
//   List<String> _memoriesItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _categorizeItems();
//   }
//
//   void _categorizeItems() {
//
//     _readItems.clear();
//     _reciteItems.clear();
//     _memoriesItems.clear();
//
//     for (String item in widget._savedItems) {
//       if (item.startsWith('Read')) {
//         _readItems.add(item);
//       } else if (item.startsWith('Recite')) {
//         _reciteItems.add(item);
//       } else if (item.startsWith('Memories')) {
//         _memoriesItems.add(item);
//       }
//     }
//   }
//
//   //
//   // void _categorizeItems() {
//   //   for (Widget item in widget._savedItems) {
//   //     if ((item as Text).data!.startsWith('Read')) {
//   //       _readItems.add(item);
//   //     } else if ((item as Text).data!.startsWith('Recite')) {
//   //       _reciteItems.add(item);
//   //     } else if ((item as Text).data!.startsWith('Memories')) {
//   //       _memoriesItems.add(item);
//   //     }
//   //   }
//   // }
//
//
//   // void _categorizeItems() {
//   //   for (Widget item in widget._savedItems) {
//   //     Container container = item as Container;
//   //     Text text = container.child as Text;
//   //     if (text.data!.startsWith('Read')) {
//   //       _readItems.add(item);
//   //     } else if (text.data!.startsWith('Recite')) {
//   //       _reciteItems.add(item);
//   //     } else if (text.data!.startsWith('Memories')) {
//   //       _memoriesItems.add(item);
//   //     }
//   //   }
//   // }
//
//   //
//   // void _categorizeItems() {
//   //   for (Widget item in widget._savedItems) {
//   //     if ((item as Container).child is Text) {
//   //       Text text = (item as Container).child as Text;
//   //       if (text.data!.startsWith('Read')) {
//   //         _readItems.add(item);
//   //       } else if (text.data!.startsWith('Recite')) {
//   //         _reciteItems.add(item);
//   //       } else if (text.data!.startsWith('Memories')) {
//   //         _memoriesItems.add(item);
//   //       }
//   //     }
//   //   }
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: CustomColors.clrwhite,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: CustomColors.clrwhite,size: screenWidth * 0.06,),
//           onPressed: () {
//             Navigator.of(context).pop(); // Navigate back
//           },
//         ),
//         title: Text('Bookmark', style: TextStyle(color: CustomColors.clrwhite, fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: screenWidth * 0.06)),
//         backgroundColor: CustomColors.clrorange,
//
//         actions: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//             child: Icon(Icons.search,size: screenWidth * 0.06,color: CustomColors.clrwhite,),
//           )
//         ],
//       ),
//
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
//         child: ListView(
//
//           children: [
//             Padding(
//               padding: EdgeInsets.only(bottom: screenWidth * 0.01),
//               child: Container(
//                 height: screenWidth * 0.1,
//                 color: Colors.orange,
//                 child: ListTile(
//                     title: Padding(
//                       padding: EdgeInsets.only(bottom: screenWidth * 0.04),
//                       child: Text('Read',style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrwhite ),),
//                     ),
//                 ),
//               ),
//             ),
//             ..._readItems.map((item) => ListTile(
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(item),
//                   Divider()
//                 ],
//               ),
//
//               // trailing: IconButton(
//               //   icon: Icon(Icons.delete),
//               //   onPressed: () {
//               //     int index = widget._bhagwatItems.indexWhere((element) => element.titile == item.split(':')[1].trim());
//               //     widget._removeItemFromSavedList(index);
//               //     setState(() {
//               //       _categorizeItems(); // Call _categorizeItems again to update the lists
//               //     });
//               //   },
//               // ),
//
//
//             )),
//             Padding(
//               padding: EdgeInsets.only(bottom: screenWidth * 0.01),
//               child: Container(
//                 height: screenWidth * 0.1,
//                 color: Colors.orange,
//                 child: ListTile(
//                   title: Padding(
//                     padding: EdgeInsets.only(bottom: screenWidth * 0.04),
//                     child: Text('Recite',style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrwhite ),),
//                   ),
//                 ),
//               ),
//             ),
//             ..._reciteItems.map((item) => ListTile(
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(item),
//                   Divider()
//                 ],
//               ),
//
//               // trailing: IconButton(
//               //   icon: Icon(Icons.delete),
//               //   onPressed: () {
//               //     int index = widget._bhagwatItems.indexWhere((element) => element.titile == item.split(':')[1].trim());
//               //     widget._removeItemFromSavedList(index);
//               //     setState(() {
//               //       _categorizeItems(); // Call _categorizeItems again to update the lists
//               //     });
//               //   },
//               // ),
//
//             )),
//             Container(
//               height: screenWidth * 0.1,
//               color: Colors.orange,
//               child: ListTile(
//                 title: Padding(
//                   padding: EdgeInsets.only(bottom: screenWidth * 0.04),
//                   child: Text('Memories',style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrwhite ),),
//                 ),
//
//               ),
//             ),
//             ..._memoriesItems.map((item) => GestureDetector(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(),));
//               },
//               child: ListTile(
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(item),
//                     Divider()
//                   ],
//                 ),
//
//                 // trailing: IconButton(
//                 //   icon: Icon(Icons.delete),
//                 //   onPressed: () {
//                 //     int index = widget._bhagwatItems.indexWhere((element) => element.titile == item.split(':')[1].trim());
//                 //     widget._removeItemFromSavedList(index);
//                 //     setState(() {
//                 //       _categorizeItems(); // Call _categorizeItems again to update the lists
//                 //     });
//                 //   },
//                 // ),
//
//                 ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
