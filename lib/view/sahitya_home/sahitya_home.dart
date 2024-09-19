import 'package:flutter/material.dart';
import 'package:sahityadesign/api_service/api_service.dart';
import 'package:sahityadesign/view/sahitya_grid/grid_sahitya.dart';
import 'package:sahityadesign/view/sahiya_list/sahitya_list.dart';
import '../../model/tab_model.dart';
import '../../ui_helpers/custom_colors.dart';

class SahityaHome extends StatefulWidget {
  const SahityaHome({super.key});

  @override
  State<SahityaHome> createState() => _SahityaHomeState();
}

class _SahityaHomeState extends State<SahityaHome>{

  bool _isGridView = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getTabsData();
  }

  var categorymodel = <TabsName>[];

  Future<void> getTabsData() async {

    setState(() {
      _isLoading = true;
    });

    try {
      final Map<String, dynamic> jsonResponse = await ApiService()
          .getTabs('https://mahakal.rizrv.in/api/v1/sahitya');

     // print(jsonResponse);
      if (jsonResponse.containsKey('status') &&
          jsonResponse.containsKey('data') &&
          jsonResponse['data'] != null) {
        final categoryModel = TabModel.fromJson(jsonResponse);

        print(categoryModel);

        setState(() {
          categorymodel = categoryModel.data;
        });
      } else {
        print("Error: 'status' or 'data' key is missing or null in response.");
      }
    } catch (error) {
      print('Error  in fetching category data: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    print("${categorymodel.length}");
  }


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> tabs = [
      Tab(
        height: 60,
        child: Column(
          children: [
            Icon(Icons.favorite_border_sharp,
                size: screenWidth * 0.1, color: CustomColors.clrorange),
            SizedBox(
              width: screenHeight * 0.08,
              child:  Center(
              //  child: Consumer<LanguageManager>(
                //  builder: (BuildContext context, languageManager, Widget? child) {

                //   return
            child:Text(
                     // languageManager.nameLanguage == 'English' ? "Favourite" : "फेवरेट",
                      "All",
                      style:  TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: CustomColors.clrblack,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
                 // },
              //  ),
              ),
            ),
          ],
        ),
      ),
      ...categorymodel.map((cat) => Tab(
        height: 60,
        child: Column(
          children: [
            Container(
              height: screenWidth * 0.1,
              width: screenWidth * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(cat.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: screenHeight * 0.08,
              child: Center(
                child:
               // Consumer<LanguageManager>(
               //   builder: (BuildContext context, languageManager, Widget? child) {
                   // return
    Text(
                      // cat.hiName,

                     // languageManager.nameLanguage == 'English' ? cat.enName : cat.hiName,

      cat.enName,
                      style: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: CustomColors.clrblack,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 1,
                    ),
               //   },
               // ),
              ),
            ),
          ],
        ),
      )),
    ];

    return SafeArea(
      child: DefaultTabController(
          length: categorymodel.length + 1,
          child: Scaffold(
            backgroundColor: Colors.white,

            appBar: AppBar(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: CustomColors.clrorange,
              title: Text(
                "Sahitya",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CustomColors.clrwhite,
                    fontSize: screenWidth * 0.06,
                    fontFamily: 'Roboto'),
              ),
              leading: Icon(Icons.arrow_back,
                  color: CustomColors.clrwhite, size: screenWidth * 0.06),

              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Row(
                    children: [

                      Icon(Icons.translate,color: Colors.white,),

                      SizedBox(width: screenWidth * 0.05),
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColors.clrgreydark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.01,
                              vertical: screenWidth * 0.01),
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
                                        color: _isGridView
                                            ? CustomColors.clrwhite
                                            : null,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ImageIcon(
                                          NetworkImage(
                                              "https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
                                          color: _isGridView
                                              ? CustomColors.clrorange
                                              : Colors.black),
                                    )),
                                const SizedBox(
                                  width: 8,
                                ),
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
                                        color:
                                        _isGridView ? null : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ImageIcon(
                                          AssetImage("assets/image/cube.png"),
                                          color: _isGridView
                                              ? CustomColors.clrblack
                                              : CustomColors.clrorange),
                                    )),
                              ]),
                        ),
                      ),
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
            body: _isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white,)) : Column(
              children: [

                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: screenWidth * 0.03,
                //       vertical: screenWidth * 0.02),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Sahitya Books",
                //         style: TextStyle(
                //             fontSize: screenWidth * 0.06,
                //             fontWeight: FontWeight.w500,
                //             fontFamily: 'Roboto',
                //             color: CustomColors.clrorange),
                //       ),
                //       Spacer(),
                //       Container(
                //         decoration: BoxDecoration(
                //           color: CustomColors.clrgreydark,
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //         child: Padding(
                //           padding: EdgeInsets.symmetric(
                //               horizontal: screenWidth * 0.01,
                //               vertical: screenWidth * 0.01),
                //           child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 GestureDetector(
                //                     onTap: () {
                //                       setState(() {
                //                         _isGridView = true;
                //                       });
                //                     },
                //                     child: Container(
                //                       height: screenHeight * 0.04,
                //                       width: screenWidth * 0.08,
                //                       decoration: BoxDecoration(
                //                         color: _isGridView
                //                             ? CustomColors.clrwhite
                //                             : null,
                //                         borderRadius: BorderRadius.circular(5),
                //                       ),
                //                       child: ImageIcon(
                //                           NetworkImage(
                //                               "https://cdn0.iconfinder.com/data/icons/rounded-basics/24/svg-rounded_list-512.png"),
                //                           color: _isGridView
                //                               ? CustomColors.clrorange
                //                               : Colors.black),
                //                     )),
                //                 const SizedBox(
                //                   width: 8,
                //                 ),
                //                 GestureDetector(
                //                     onTap: () {
                //                       setState(() {
                //                         _isGridView = false;
                //                       });
                //                     },
                //                     child: Container(
                //                       height: screenHeight * 0.04,
                //                       width: screenWidth * 0.08,
                //                       decoration: BoxDecoration(
                //                         color:
                //                             _isGridView ? null : Colors.white,
                //                         borderRadius: BorderRadius.circular(5),
                //                       ),
                //                       child: ImageIcon(
                //                           AssetImage("assets/image/cube.png"),
                //                           color: _isGridView
                //                               ? CustomColors.clrblack
                //                               : CustomColors.clrorange),
                //                     )),
                //               ]),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: screenWidth * 0.04,),
                TabBar(
                    isScrollable: true,
                    splashFactory: NoSplash.splashFactory,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03),
                    indicatorColor: CustomColors.clrorange,
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01),
                    tabs: tabs),
                Expanded(
                  child: TabBarView(
                   // controller: _tabController,
                    children: [
                      // SahityaGrid()
                      _isGridView ? SahityaList() : GridSahitya(),
                      _isGridView ? Center(child: Text("list")) : Center(child: Text("Grid")),
                      _isGridView ? Center(child: Text("list is ")) : Center(child: Text("Grid is ")),

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
          )),
    );
  }
}
