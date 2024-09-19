import 'package:flutter/material.dart';
import 'package:sahityadesign/view/grid_sahitya.dart';
import 'package:sahityadesign/view/sahitya_list.dart';
import '../ui_helpers/custom_colors.dart';


class  SahityaHome extends StatefulWidget {
  const SahityaHome({super.key});

  @override
  State<SahityaHome> createState() => _SahityaHomeState();
}

class _SahityaHomeState extends State<SahityaHome> with SingleTickerProviderStateMixin {

  late TabController _tabController;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

  }

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DefaultTabController(length: 4, child: Scaffold(
        backgroundColor: Colors.white,

        appBar:  AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            backgroundColor: CustomColors.clrorange,
            title: Text("Sahitya", style: TextStyle(fontWeight: FontWeight.w600, color: CustomColors.clrwhite, fontSize: screenWidth * 0.06, fontFamily: 'Roboto'),),
            leading: Icon(
                Icons.arrow_back, color: CustomColors.clrwhite, size: screenWidth * 0.06),

            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                child: Row(
                  children: [

                    Icon(Icons.bookmark,color: CustomColors.clrwhite,size: screenWidth * 0.06,),
                    SizedBox(width: screenWidth * 0.02,),
                    Icon(Icons.search,color: CustomColors.clrwhite,size: screenWidth * 0.06,)

                  ],
                ),
              )
            ],

            // flexibleSpace: Padding(
            //   padding: EdgeInsets.only(left: screenWidth * 0.03, top:screenWidth * 0.15),
            //
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
            //     child: Row(
            //       children: [
            //
            //         Text("Sahitya Books",style: TextStyle(fontSize: screenWidth * 0.06,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrorange),),
            //
            //         Spacer(),
            //         Padding(
            //           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            //           child: Container(
            //             decoration: BoxDecoration(
            //               color: CustomColors.clrgreydark,
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //
            //             child: Padding(
            //               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,vertical: screenWidth * 0.01),
            //               child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     GestureDetector(
            //                         onTap: () {
            //                           setState(() {
            //                             _isGridView = true;
            //                           });
            //                         },
            //                         child: Container(
            //                           height: screenHeight * 0.04,
            //                           width: screenWidth * 0.08,
            //                           decoration: BoxDecoration(
            //                             color: _isGridView ? CustomColors.clrwhite
            //                                 : null,
            //                             borderRadius: BorderRadius.circular(5),
            //                           ),
            //                           child: ImageIcon(NetworkImage("https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
            //                               color: _isGridView ? CustomColors.clrorange: Colors.black),
            //                         )
            //                     ),
            //                     const SizedBox(width: 8,),
            //                     GestureDetector(
            //                         onTap: () {
            //                           setState(() {
            //                             _isGridView = false;
            //                           });
            //                         },
            //                         child: Container(
            //                           height: screenHeight * 0.04,
            //                           width: screenWidth * 0.08,
            //                           decoration: BoxDecoration(
            //                             color: _isGridView
            //                                 ? null
            //                                 : Colors.white,
            //                             borderRadius: BorderRadius.circular(5),
            //                           ),
            //                           child: ImageIcon(
            //                              AssetImage("assets/image/cube.png"),
            //                               color: _isGridView
            //                                   ? CustomColors.clrblack
            //                                   : CustomColors.clrorange),
            //                         )
            //                     ),
            //                   ]
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Category Data
            // bottom: TabBar(
            //   controller: _tabController,
            //   dividerColor: Colors.transparent,
            //   unselectedLabelColor: Colors.grey,
            //   labelColor: Colors.black,
            //   physics: AlwaysScrollableScrollPhysics(),
            //   tabAlignment: TabAlignment.start,
            //   indicatorColor: Colors.orange,
            //   labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            //   labelStyle: TextStyle(fontSize: screenWidth * 0.04,
            //       fontWeight: FontWeight.w500,
            //       fontFamily: 'Roboto'),
            //   indicatorSize: TabBarIndicatorSize.tab,
            //   isScrollable: true,
            //   // tabs: List.generate(category.length, (int index)=> Tab(text: category[index].name)),
            //
            //   tabs: [
            //
            //     Tab(
            //       text: "All",
            //     ),
            //     Tab(
            //       text: "POPULAR",
            //     ),
            //     Tab(
            //       text: "MOST RELATED",
            //     ),
            //     Tab(
            //       text: "VEDAS",
            //     ),
            //
            //   ],
            // ),

        ),
        body: Column(

          children: [


          Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03,vertical: screenWidth * 0.02),
                child: Row(
                  children: [

                    Text("Sahitya Books",style: TextStyle(fontSize: screenWidth * 0.06,fontWeight: FontWeight.w500,fontFamily: 'Roboto',color: CustomColors.clrorange),),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                          color: CustomColors.clrgreydark,
                          borderRadius: BorderRadius.circular(10),
                        ),

                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,vertical: screenWidth * 0.01),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isGridView = true;
                                      });
                                    },
                                    child: Container(
                                      height: screenHeight * 0.04,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                        color: _isGridView ? CustomColors.clrwhite
                                            : null,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ImageIcon(NetworkImage("https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
                                          color: _isGridView ? CustomColors.clrorange: Colors.black),
                                    )
                                ),
                                const SizedBox(width: 8,),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isGridView = false;
                                      });
                                    },
                                    child: Container(
                                      height: screenHeight * 0.04,
                                      width: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                        color: _isGridView
                                            ? null
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ImageIcon(
                                         AssetImage("assets/image/cube.png"),
                                          color: _isGridView
                                              ? CustomColors.clrblack
                                              : CustomColors.clrorange),
                                    )
                                ),
                              ]
                          ),
                        ),
                      ),
                  ],
                ),
              ),



            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.black,
              physics: AlwaysScrollableScrollPhysics(),
              tabAlignment: TabAlignment.start,
              indicatorColor: Colors.orange,
              labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              labelStyle: TextStyle(fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto'),
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              // tabs: List.generate(category.length, (int index)=> Tab(text: category[index].name)),

              tabs: [

                Tab(
                  text: "All",
                ),
                Tab(
                  text: "POPULAR",
                ),
                Tab(
                  text: "MOST RELATED",
                ),
                Tab(
                  text: "VEDAS",
                ),

              ],
            ),

            Expanded(child: TabBarView(
                controller: _tabController,
                children: [

                 // SahityaGrid()
                  _isGridView ? SahityaList():GridSahitya(),
                  _isGridView ? Center(child: Text("list")):Center(child: Text("Grid"))
                  //
                ],
              ),
            ),

          ],
        ),

        // TabBarView(
        //   controller: _tabController,
        //   children: [
        //
        //    // SahityaGrid()
        //     _isGridView ? SahityaList():SahityaGrid(),
        //     _isGridView ? Center(child: Text("list")):Center(child: Text("Grid"))
        //     //
        //   ],
        // ),

      )
      ),
    );

  }
}
