import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/bhagwat_model.dart';
import '../ui_helpers/custom_colors.dart';
import 'edit_screen.dart';

class SavedItemsScreen extends StatefulWidget {
  final List<String> _savedItems;
  final Function _removeItemFromSavedList;
  final List<BhagwatModel> _bhagwatItems;


  SavedItemsScreen(this._savedItems, this._bhagwatItems, this._removeItemFromSavedList);

  @override
  _SavedItemsScreenState createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  List<String> _readItems = [];
  List<String> _reciteItems = [];
  List<String> _memoriesItems = [];

  @override
  void initState() {
    super.initState();
    _categorizeItems();
  }

  void _categorizeItems() {

    _readItems.clear();
    _reciteItems.clear();
    _memoriesItems.clear();

    for (String item in widget._savedItems) {
      if (item.startsWith('Read')) {
        _readItems.add(item);
      } else if (item.startsWith('Recite')) {
        _reciteItems.add(item);
      } else if (item.startsWith('Memories')) {
        _memoriesItems.add(item);
      }
    }
  }

  //
  // void _categorizeItems() {
  //   for (Widget item in widget._savedItems) {
  //     if ((item as Text).data!.startsWith('Read')) {
  //       _readItems.add(item);
  //     } else if ((item as Text).data!.startsWith('Recite')) {
  //       _reciteItems.add(item);
  //     } else if ((item as Text).data!.startsWith('Memories')) {
  //       _memoriesItems.add(item);
  //     }
  //   }
  // }


  // void _categorizeItems() {
  //   for (Widget item in widget._savedItems) {
  //     Container container = item as Container;
  //     Text text = container.child as Text;
  //     if (text.data!.startsWith('Read')) {
  //       _readItems.add(item);
  //     } else if (text.data!.startsWith('Recite')) {
  //       _reciteItems.add(item);
  //     } else if (text.data!.startsWith('Memories')) {
  //       _memoriesItems.add(item);
  //     }
  //   }
  // }

  //
  // void _categorizeItems() {
  //   for (Widget item in widget._savedItems) {
  //     if ((item as Container).child is Text) {
  //       Text text = (item as Container).child as Text;
  //       if (text.data!.startsWith('Read')) {
  //         _readItems.add(item);
  //       } else if (text.data!.startsWith('Recite')) {
  //         _reciteItems.add(item);
  //       } else if (text.data!.startsWith('Memories')) {
  //         _memoriesItems.add(item);
  //       }
  //     }
  //   }
  // }


  @override
  Widget build(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: CustomColors.clrwhite,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColors.clrwhite,size: screenWidth * 0.06,),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back
          },
        ),
        title: Text('Bookmark', style: TextStyle(color: CustomColors.clrwhite, fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: screenWidth * 0.06)),
        backgroundColor: CustomColors.clrorange,

        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Icon(Icons.search,size: screenWidth * 0.06,color: CustomColors.clrwhite,),
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
        child: ListView(

          children: [
            Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.01),
              child: Container(
                height: screenWidth * 0.1,
                color: Colors.orange,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                    child: Text('Read',style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrwhite ),),
                  ),
                ),
              ),
            ),
            ..._readItems.map((item) => ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item),
                  Divider()
                ],
              ),

              // trailing: IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     int index = widget._bhagwatItems.indexWhere((element) => element.titile == item.split(':')[1].trim());
              //     widget._removeItemFromSavedList(index);
              //     setState(() {
              //       _categorizeItems(); // Call _categorizeItems again to update the lists
              //     });
              //   },
              // ),


            )),
            Padding(
              padding: EdgeInsets.only(bottom: screenWidth * 0.01),
              child: Container(
                height: screenWidth * 0.1,
                color: Colors.orange,
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                    child: Text('Recite',style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrwhite ),),
                  ),
                ),
              ),
            ),
            ..._reciteItems.map((item) => ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item),
                  Divider()
                ],
              ),

              // trailing: IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     int index = widget._bhagwatItems.indexWhere((element) => element.titile == item.split(':')[1].trim());
              //     widget._removeItemFromSavedList(index);
              //     setState(() {
              //       _categorizeItems(); // Call _categorizeItems again to update the lists
              //     });
              //   },
              // ),

            )),
            Container(
              height: screenWidth * 0.1,
              color: Colors.orange,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                  child: Text('Memories',style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrwhite ),),
                ),

              ),
            ),
            ..._memoriesItems.map((item) => GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen(),));
              },
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item),
                    Divider()
                  ],
                ),

                // trailing: IconButton(
                //   icon: Icon(Icons.delete),
                //   onPressed: () {
                //     int index = widget._bhagwatItems.indexWhere((element) => element.titile == item.split(':')[1].trim());
                //     widget._removeItemFromSavedList(index);
                //     setState(() {
                //       _categorizeItems(); // Call _categorizeItems again to update the lists
                //     });
                //   },
                // ),

              ),
            )),
          ],
        ),
      ),
    );
  }
}
