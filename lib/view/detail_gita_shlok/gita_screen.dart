import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahityadesign/model/shlok_model.dart';
import 'package:sahityadesign/view/bookmarkscreen.dart';
import 'package:sahityadesign/view/gita_chapter.dart';
import 'package:sahityadesign/view/share_screen.dart';
import '../ui_helpers/custom_colors.dart';
import '../ui_helpers/fontsize_manager.dart';
import '../ui_helpers/theme_manager.dart';

class GitaScreen extends StatefulWidget {
  const GitaScreen({super.key,required this.selectedChapter});

  final String selectedChapter;

  @override
  State<GitaScreen> createState() => _GitaScreenState();
}

class _GitaScreenState extends State<GitaScreen> {


  late bool _isOn;
  bool _showHindiText = true;
  bool _showEnglishText = true;
  bool _showBookFormate = false;
  String _selectedChap = 'Chapter 1';
  String _selectedFont = 'OpenSans';
  double _fontSize = 16.0;
  double _textSize = 15.0;

  Color _textColor = CustomColors.clrwhite;


  List<String> _chapOptions = [
    'Chapter 1', 'Chapter 2', 'Chapter 3',
    'Chapter 5', 'Chapter 6', 'Chapter 7',
    'Chapter 8', 'Chapter 9', 'Chapter 10',
    'Chapter 11', 'Chapter 12', ];

  List<String> _fontOptions = [
    'OpenSans',
    'Inter',
    'Lato',
    'Roboto',];

  List<ShlokModel> gitashlok = [

    ShlokModel(
        sanskrit: "धर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः । मामकाः पाण्डवाश्चैव किमकुर्वत संजय ॥1-1॥",
        hindi: "धृतराष्ट्र बोले- हे  संजय! धर्मभूमि कुरुक्षेत्र में एकत्रित, युद्ध की इच्छावाले मेरे और पाण्डु के पुत्रों ने क्या किया?॥1-1॥",
        english: "Meaning: Dhritarashtra said – O Sanjay! What did I and Pandu's sons, desirous of war, gather in the sacred land of Kurukshetra?॥1-1॥",
        serialno: "1",
        hindiDetails: "प्रथम अध्याय का नाम अर्जुनविषादयोग है। वह गीता के उपदेश का विलक्षण रंगमंच प्रस्तुत करता है जिसमें श्रोता और वक्ता दोनों ही कुतूहल शांति के लिए नहीं वरन् जीवन की प्रगाढ़ समस्या के समाधान के लिये प्रवृत्त होते हैं। शौर्य और धैर्य, साहस और बल इन चारों गुणों की प्रभूत मात्रा से अर्जुन का व्यक्तित्व बना था और इन चारों के ऊपर दो गुण और थे एक क्षमा, दूसरी प्रज्ञा। बलप्रधान क्षात्रधर्म से प्राप्त होनेवाली स्थिति में पहुँचकर सहसा अर्जुन के चित्त पर एक दूसरे ही प्रकार के मनोभाव का आक्रमण हुआ, कार्पण्य का। एक विचित्र प्रकार की करुणा उसके मन में भर गई और उसका क्षात्र स्वभाव लुप्त हो गया। जिस कर्तव्य के लिए वह कटिबद्ध हुआ था उससे वह विमुख हो गया। ऊपर से देखने पर तो इस स्थिति के पक्ष में उसके तर्क धर्मयुक्त जान पड़ते हैं, किंतु उसने स्वयं ही उसे कार्पण्य दोष कहा है और यही माना है कि मन की इस कायरता के कारण उसका जन्मसिद्ध स्वभाव उपहत या नष्ट हो गया था। वह निर्णय नहीं कर पा रहा था कि युद्ध करे अथवा वैराग्य ले ले। क्या करें, क्या न करें, कुछ समझ में नहीं आता था। इस मनोभाव की चरम स्थिति में पहुँचकर उसने धनुषबाण एक ओर डाल दिया।कृष्ण ने अर्जुन की वह स्थिति देखकर जान लिया कि अर्जुन का शरीर ठीक है किंतु युद्ध आरंभ होने से पहले ही उस अद्भुत क्षत्रिय का मनोबल टूट चुका है। बिना मन के यह शरीर खड़ा नहीं रह सकता। अतएव कृष्ण के सामने एक गुरु कर्तव्य आ गया। अत: तर्क से, बुद्धि से, ज्ञान से, कर्म की चर्चा से, विश्व के स्वभाव से, उसमें जीवन की स्थिति से, दोनों के नियामक अव्यय पुरुष के परिचय से और उस सर्वोपरि परम सत्तावान ब्रह्म के साक्षात दर्शन से अर्जुन के मन का उद्धार करना, यही उनका लक्ष्य हुआ। इसी तत्वचर्चा का विषय गीता है। पहले अध्याय में सामान्य रीति से भूमिका रूप में अर्जुन ने भगवान से अपनी स्थिति कह दी।प्रथम अध्याय में दोनों सेनाओं का वर्णन किया जाता है।शंख बजाने के पश्चात अर्जुन सेना को देखने के लिए रथ को सेनाओं के मध्य ले जाने के लिए कृष्ण से कहता है।तब मोहयुक्त हो अर्जुन कायरता तथा शोक युक्त वचन कहता है।",
    ),

    ShlokModel(
        sanskrit: "कर्मण्येवाधिकारस्ते मा फलेषु कदाचन ।",
        hindi: "कर्म तो तेरा अधिकार है, फल की चिंता मत कर ",
        english: "One should always do one’s work with full dedication and leave the results of the work to God!",
        serialno: "2",
        hindiDetails: "अर्जुन की भावनाओं का वर्णन करने के लिए, संजय ने कृपाया शब्द का प्रयोग किया है , जिसका अर्थ है दया या करुणा। यह करुणा दो प्रकार की होती है। एक दिव्य करुणा है जो भगवान और संत भौतिक क्षेत्र में आत्माओं के प्रति महसूस करते हैं, भगवान के वियोग में उनके दुख को देखते हुए। दूसरी भौतिक करुणा है जो हम दूसरों के शारीरिक कष्ट को देखकर महसूस करते हैं। भौतिक करुणा एक उत्तम भावना है जो पूरी तरह से निर्देशित नहीं है। यह कार के स्वास्थ्य को लेकर जुनूनी होने के समान है जबकि अंदर बैठा ड्राइवर भोजन के लिए भूखा है। अर्जुन इस दूसरी तरह की भावना का अनुभव कर रहा है। वह युद्ध के लिए एकत्र अपने शत्रुओं के प्रति भौतिक दया से अभिभूत है। यह तथ्य कि अर्जुन दुःख और निराशा से ग्रस्त है, यह दर्शाता है कि उसे स्वयं करुणा की सख्त आवश्यकता है। इसलिए, दूसरों पर उसकी दया का विचार निरर्थक है।इस श्लोक में श्री कृष्ण को मधुसूदन कहकर संबोधित किया गया है। उन्होंने मधु नामक राक्षस का वध किया था, इसलिए उनका नाम मधुसूदन पड़ा, अर्थात  मधु राक्षस का वध करने वाला। यहाँ वे उस संदेह रूपी राक्षस का वध करने वाले हैं जो अर्जुन के मन में उत्पन्न हो गया है और उसे अपना कर्तव्य पालन करने से रोक रहा है।",
    ),

    ShlokModel(
        sanskrit: "अहं सर्वस्य प्रभवो मत्तः सर्वं प्रवर्तते ।",
        hindi: "मैं सभी का स्रोत हूँ, सभी चीज़ें मेरे से निकलती हैं ।",
        english: " Everything in this world is from Me (Lord), everything emanates from Me!",
        serialno: "3",
        hindiDetails: "",
    ),

    ShlokModel(
        sanskrit: " योगस्थ: कुरु कर्माणि सङ्गं त्यक्त्वा धनञ्जय ",
        hindi: "योग में स्थिर होकर कर्म कर, संग को त्याग दे । ",
        english: "Be firm in yoga, O Arjuna; Do your duty and give up all attachment to success or failure.",
        serialno: "4",
        hindiDetails: "",
    ),

    ShlokModel(
        sanskrit: "अहमात्मा गुडाकेश सर्वभूताशयस्थित: ",
        hindi: "मैं सभी प्राणियों के हृदय में स्थित हूँ ।",
        english: "O Arjuna, I am the soul situated in the heart of all beings.",
        serialno: "5",
        hindiDetails: "",
    ),

    ShlokModel(
        sanskrit: "न जायते मृयते वा कदचि- न्णायं भूत्वा भविता वा न भूयः ",
        hindi: " न तो मैं पैदा होता हूँ, न मरता हूँ, न मैं था और न मैं हूँ । ",
        english: "There was no time when neither I was nor you, nor were all these kings; Nor will there be any of us in the future!",
        serialno: "6",
        hindiDetails: "",
    ),

    ShlokModel(sanskrit: " मामुपेत्य पुनर्जन्म दु:खालयमशाश्वतम् ",
        hindi: "मेरे पास आने से पुनर्जन्म के दुख से मुक्ति मिलती है ।",
        english: "He who has taken refuge in Me, O son of Kunti, I am the source of all the spiritual and material worlds; Everything emanates from me!",
        serialno: "7",
        hindiDetails: "",
    ),

    ShlokModel(
        sanskrit: "मन्मना भव मद्भक्तो मद्याजी मां नमस्कुरु",
        hindi: " मेरे ही चिंतन में रहो, मेरा भक्त बनो, मेरी पूजा करो ",
        english: "Meditate on me, become my devotee, worship me, and offer your obeisances to me",
        serialno: "8",
        hindiDetails: "",
    ),

    ShlokModel(
        sanskrit: "यदा यदा हि धर्मस्य ग्लानिर्भवति भारत!",
        hindi: " जब-जब धर्म की हानि होती है, तब-तब मैं अवतार लेता हूँ ।",
        english: "O descendant of Bharata, whenever there is a decline in religious conduct and a strong rise of unrighteousness, at that time I myself incarnate.",
        serialno: "9",
        hindiDetails: "",
    ),

    ShlokModel(sanskrit: ": मा च योऽव्यभिचारेन भक्तियोगेन सेवते! ",
        hindi: "जो मेरी भक्ति में लगा रहता है, वह संसार के बंधन से मुक्त हो जाता है ",
        english: "One who is engaged in perfect devotional service, who does not fall under any circumstances, at once transcends the modes of material nature and thus rises to the platform of Brahman",
        serialno: "10",
        hindiDetails: "",
    ),

  ];


  @override
  void initState() {
    super.initState();
    _loadFontSize();
    ThemeManager.getInstance()!.initPrefs();
    _loadSwitchState();
  }

  @override
  void dispose() {
    ThemeManager.getInstance()?.clearPrefs();
    super.dispose();
  }

  Future<void> _loadFontSize() async {
    final fontSize = await FontPreferenceManager.getFontSize();
    setState(() {
      _fontSize = fontSize;
    });
  }

  void _updateFontSize(double fontSize) {
    setState(() {
    FontPreferenceManager.setFontSize(fontSize);
    });
  }

  updateHindiText() {
    setState(() {
      _showHindiText = !_showHindiText;
    });
  }

  updateEnglishText() {
    setState(() {
      _showEnglishText = !_showEnglishText;
    });
  }

  void _updateFont(String value){
    setState(() {
      _selectedFont = value;
    });
  }

  void myText(double size){
    setState(() {
      _textSize = size;
    });
  }


  _loadSwitchState() async {
    await ThemeManager.getInstance()!.initPrefs();
    final isDarkMode = ThemeManager.getInstance()!.isDarkMode;
    setState(() {
      _isOn = isDarkMode;
    });
  }

  _onTapBox() async {
    await ThemeManager.getInstance()!.toggleDarkMode();
  }

  onClickIt(){
    setState(() {
      _isOn = !_isOn;
    });
    _onTapBox();
  }

  onBookFormate(){
    setState(() {
      _showBookFormate = !_showBookFormate;
    });
  }

  void _changeTextColor(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  // Bottom Sheet for customize
  void _showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: CustomColors.clrwhite,
      context: context,
      builder: (context) {
          var screenHeight = MediaQuery.of(context).size.height;
          var screenWidth = MediaQuery.of(context).size.width;
          return StatefulBuilder(
             builder: (context, StateSetter setState) {
               return Container(
                 height: screenHeight * 0.7,
                 child: Column(
                   children: [

                     // Fonts Styles
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenWidth * 0.04),
                       child: Row(children: [

                         Container(
                             width:screenWidth * 0.04,
                             height: screenWidth * 0.04,
                             child: Icon(Icons.text_rotation_none_outlined,size: screenWidth * 0.06,color: Colors.black,)),
                         SizedBox(width: screenWidth * 0.02,),
                         Text("Font type",style: TextStyle(fontWeight: FontWeight.w600,fontSize: screenWidth * 0.04,fontFamily: 'Roboto',color: CustomColors.clrblack),),

                        Spacer(),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                           child: DropdownButton<String>(
                             iconEnabledColor: CustomColors.clrblack,
                             value: _selectedFont,
                             onChanged: (String? newValue) {
                               setState(() {
                                 _selectedFont = newValue ?? '';
                               });
                               _updateFont(newValue!);
                             },
                             items: _fontOptions.map((String font) {
                               return DropdownMenuItem<String>(
                                 value: font,
                                 child: Text(font,style: TextStyle(fontSize: screenWidth * 0.05,color: CustomColors.clrblack),),
                               );
                             }).toList(),

                             // remove the default elevation
                             dropdownColor: Colors.white, // change the dropdown background color
                             borderRadius: BorderRadius.circular(5), // make the dropdown button rounded
                             alignment: Alignment.center, // center the dropdown button
                             underline: Container(),
                           ),
                         ),
                       ],),
                     ),

                     // Slider(Increase Size)
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01,vertical: screenWidth * 0.05),
                       child: Row(children: [

                         SizedBox(width: screenWidth * 0.04,),
                         Container(
                           width:screenWidth * 0.04,
                           height: screenWidth * 0.04,
                           child: Icon(Icons.text_fields_rounded,size: screenWidth * 0.06,color: CustomColors.clrblack,)),
                         SizedBox(width: screenWidth * 0.02,),
                         Text("Font size",style: TextStyle(fontWeight: FontWeight.w600,fontSize: screenWidth * 0.04,fontFamily: 'Roboto',color: CustomColors.clrblack),),

                         Spacer(),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                           child:  Slider(
                               value: _fontSize,
                               min: 12,
                               max: 25,
                               divisions: 12,
                               label: '${_fontSize.round()}',
                               onChanged: (double value) {
                                 setState(() {
                                   _fontSize =  value;
                                 });
                                // FontPreferenceManager.setFontSize(value);
                                 _updateFontSize(value);
                               },
                               activeColor: Colors.orange,
                               thumbColor: Colors.orange,
                               inactiveColor: Colors.black,
                             ),
                           ),
                       ],),
                     ),

                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical: screenWidth * 0.04),
                       child: Row(
                         children: <Widget>[

                           Icon(Icons.lightbulb_outline,size: screenWidth * 0.06,color: CustomColors.clrblack,),
                           Text("Light & Dark",style: TextStyle(fontSize: screenWidth * 0.04,color: CustomColors.clrblack,fontWeight: FontWeight.w600),),

                           Spacer(),
                           GestureDetector(
                             onTap: () {
                               setState(() {
                               });
                               onClickIt();
                             },
                             //onTap: ,
                             child: Container(
                               width: screenWidth * 0.2,
                               height: screenWidth * 0.09,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: _isOn? Colors.orange  : CustomColors.clrblack, // <--- swapped colors
                               ),
                               child: Row(
                                 children: [
                                   Expanded(
                                     child: Container(
                                       decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: _isOn? Colors.white : CustomColors.clrblack, // <--- swapped colors
                                       ),
                                       child: Center(
                                         child: Text(
                                           _isOn? 'ON' : 'OFF',
                                           style: TextStyle(
                                             fontSize: screenWidth * 0.04,
                                             color: _isOn? Colors.orange : Colors.white, // <--- swapped colors
                                           ),
                                         ),
                                       ),
                                     ),
                                   ),
                                   Container(
                                     width: screenWidth * 0.07,
                                     decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       color: _isOn? Colors.orange  : CustomColors.clrblack, // <--- swapped colors
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(width: screenWidth * 0.05,)

                         ],
                       ),
                     ),

                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical: screenWidth * 0.04),
                       child: Row(
                         children: <Widget>[

                           Icon(Icons.color_lens_outlined,size: screenWidth * 0.06,color: CustomColors.clrblack,),
                           Text("Themes",style: TextStyle(fontSize: screenWidth * 0.04,color: CustomColors.clrblack,fontWeight: FontWeight.w600),),

                           Spacer(),

                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                               CircleContainer(
                                 color: Colors.yellow,
                                 onTap: () {
                                   _changeTextColor(Colors.yellow);
                                   Navigator.pop(context);

                                 },
                               ),
                               SizedBox(width: screenWidth * 0.02,),
                               CircleContainer(
                                 color: Colors.white,
                                 onTap: () {
                                   _changeTextColor(Colors.white);
                                   Navigator.pop(context);

                                 },
                               ),
                               SizedBox(width: screenWidth * 0.02,),
                               CircleContainer(
                                 color: Colors.orange,
                                 onTap: () {
                                   _changeTextColor(Colors.orange);
                                   Navigator.pop(context);
                                 },
                               ),
                               SizedBox(width: screenWidth * 0.02,),
                               CircleContainer(
                                 color: Colors.tealAccent,
                                 onTap: () {
                                   _changeTextColor(Colors.tealAccent);
                                   Navigator.pop(context);
                                 },
                               ),
                             ],
                           ),
                           SizedBox(width: screenWidth * 0.04,),

                         ],
                       ),
                     ),

                     Divider(),

                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical: screenWidth * 0.04),
                       child: Row(
                         children: [
                           Icon(Icons.menu_book_sharp, color: CustomColors.clrblack, size: screenWidth * 0.06),
                           SizedBox(width: screenWidth * 0.02),
                           Text("Translation", style: TextStyle(fontSize: screenWidth * 0.04, color: CustomColors.clrblack,fontWeight: FontWeight.w600)),
                           Spacer(),
                           GestureDetector(
                             onTap: () {
                               setState(() {
                               });
                               updateHindiText();
                             },
                             child: Container(
                               width: screenWidth * 0.12,
                               height: screenWidth * 0.06,
                               decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black,width: 1),
                                 borderRadius: BorderRadius.all(Radius.circular(6),),
                                 color: _showHindiText ? Colors.orange : CustomColors.clrblack,
                               ),
                               child: Stack(
                                 children: [
                                   AnimatedPositioned(
                                     duration: Duration(milliseconds: 300),
                                     curve: Curves.easeInOut,
                                     left: _showHindiText ? screenWidth * 0.06 : 0,
                                     child: Padding(
                                       padding: EdgeInsets.symmetric(vertical: screenWidth * 0.002),
                                       child: Container(
                                         width: screenWidth * 0.05,
                                         height: screenWidth * 0.05,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.all(Radius.circular(8)),
                                           color: Colors.white,
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(width: screenWidth * 0.05,)
                         ],
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical: screenWidth * 0.04),
                       child: Row(
                         children: [
                           Icon(Icons.menu_book, color: CustomColors.clrblack, size: screenWidth * 0.06),
                           SizedBox(width: screenWidth * 0.02),
                           Text("Translitration", style: TextStyle(fontSize: screenWidth * 0.04, color: CustomColors.clrblack,fontWeight: FontWeight.w600)),
                           Spacer(),
                           GestureDetector(
                             onTap: () {
                               setState(() {
                               });
                               updateEnglishText();
                             },
                             child: Container(
                               width: screenWidth * 0.12,
                               height: screenWidth * 0.06,
                               decoration: BoxDecoration(
                                 border: Border.all(color: Colors.black,width: 1),
                                 borderRadius: BorderRadius.all(Radius.circular(6),),
                                 color: _showEnglishText ? Colors.orange : CustomColors.clrblack,
                               ),
                               child: Stack(
                                 children: [
                                   AnimatedPositioned(
                                     duration: Duration(milliseconds: 300),
                                     curve: Curves.easeInOut,
                                     left: _showEnglishText ? screenWidth * 0.06 : 0,
                                     child: Padding(
                                       padding: EdgeInsets.symmetric(vertical: screenWidth * 0.002),
                                       child: Container(
                                         width: screenWidth * 0.05,
                                         height: screenWidth * 0.05,
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.all(Radius.circular(8)),
                                           color: Colors.white,
                                         ),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(width: screenWidth * 0.05,)
                         ],
                       ),
                     ),
                     Padding(
                         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04,vertical: screenWidth * 0.04),
                         child: Row(
                               children: [
                                 Icon(Icons.book_outlined, color: CustomColors.clrblack, size: screenWidth * 0.06),
                                 SizedBox(width: screenWidth * 0.02),
                                 Text("Book Formate", style: TextStyle(fontSize: screenWidth * 0.04, color: CustomColors.clrblack,fontWeight: FontWeight.w600)),
                                 Spacer(),
                                 GestureDetector(
                                   onTap: () {
                                     setState(() {
                                     });
                                     onBookFormate();
                                   },
                                   child: Container(
                                     width: screenWidth * 0.12,
                                     height: screenWidth * 0.06,
                                     decoration: BoxDecoration(
                                       border: Border.all(color: Colors.black,width: 1),
                                       borderRadius: BorderRadius.all(Radius.circular(6),),
                                       color: _showBookFormate ? Colors.orange : CustomColors.clrblack,
                                     ),
                                     child: Stack(
                                       children: [
                                         AnimatedPositioned(
                                           duration: Duration(milliseconds: 300),
                                           curve: Curves.easeInOut,
                                           left: _showBookFormate ? screenWidth * 0.06 : 0,
                                           child: Padding(
                                             padding: EdgeInsets.symmetric(vertical: screenWidth * 0.002),
                                             child: Container(
                                                 width: screenWidth * 0.05,
                                                 height: screenWidth * 0.05,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.all(Radius.circular(8)),
                                                   color: Colors.white,
                                                 ),
                                               ),
                                           ),
                                           ),
                                       ],
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: screenWidth * 0.05,)
                               ],
                             ),
                       ),

                     Divider(),

                   ],
                 ),
               );}
          );},
        );
      }


 // Bottom Sheet for read hindi
  void _showTranslationBottomSheet(BuildContext context, String hindi) {
    showModalBottomSheet(
      backgroundColor: CustomColors.clrwhite,
      context: context,
      isScrollControlled: true,
      builder: (context) {

        var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight= MediaQuery.of(context).size.height;

        return Stack(
          children: [
            Container(
              height: screenHeight * 0.8,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,vertical: screenWidth * 0.04),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: screenHeight * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(image: NetworkImage("https://www.bhagavadgeeta.org/Images/Banner.jpg"),fit: BoxFit.cover)),
                      ),

                      SizedBox(height: screenWidth * 0.03,),
                      Text(hindi,textAlign: TextAlign.center,style: TextStyle(fontSize: _textSize,color: CustomColors.clrblack),),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: screenWidth * 1.5,right: screenWidth * 0.05,left: screenWidth * 0.05),
              child: Row(
                children: [


                  Container(
                    height: screenHeight * 0.05,
                    width: screenWidth * 0.8,
                    child: Slider(
                          value: _textSize,
                          min: 15,
                          max: 25,
                          divisions: 15,
                          label: '${_textSize.round()}',
                          onChanged: (double value) {
                            setState(() {
                              _textSize =  value;
                            });
                            myText(value);
                          },
                          activeColor: CustomColors.clrorange,
                          thumbColor:CustomColors.clrblack,
                          inactiveColor: CustomColors.clrblack,
                        ),
                  ),

                  Icon(Icons.play_circle,color: Colors.brown,size: screenWidth * 0.1,)

                ],
              ),
            ),
          ],
        );
      },
    );
  }


  // Dialog Box
  showmeDialog(BuildContext context) {

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: CustomColors.clrwhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bhagwat Geeta',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.clrblack
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),

                DropdownButton<String>(
                //  iconDisabledColor: Colors.red,
                  iconEnabledColor: CustomColors.clrblack,
                  dropdownColor: CustomColors.clrwhite,
                  borderRadius: BorderRadius.circular(5),
                  value: _selectedChap,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedChap = newValue ?? '';
                    });
                  },
                  items: _chapOptions.map((String chap) {
                    return DropdownMenuItem<String>(
                      value: chap,
                      child: Text(chap,style: TextStyle(color: CustomColors.clrblack),),
                    );
                  }).toList(),
                ),

                SizedBox(height: screenWidth * 0.04),
                Text(
                  'Shlok',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                    color: CustomColors.clrblack
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Enter between 1 - 4',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: CustomColors.clrblack
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                TextField(
                  decoration: InputDecoration(
                    labelStyle: TextStyle(fontSize: screenWidth * 0.03,color: CustomColors.clrblack),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Enter Shlok Number',
                  ),
                ),
                SizedBox(height: screenWidth * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.clrggreytxt,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                          color: CustomColors.clrblack,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CupertinoColors.activeBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'GO',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getInstance()!.isDarkMode ? ThemeData.dark() : ThemeData.light(),

      home: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [

              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor:ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrblack : CustomColors.clrorange,
                leading: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GitaChapter(fontSize: _fontSize,),));
                    //Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: CustomColors.clrwhite, size: screenWidth * 0.06),
                ),

                title: Text("Sahitya", style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.w600, fontFamily: 'Roboto',color: CustomColors.clrwhite)),

                actions: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookMark(),));
                          },
                          child: Icon(Icons.search, color: CustomColors.clrwhite,
                            size: screenWidth * 0.06,),
                        ),
                        SizedBox(width: screenWidth * 0.03,),
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet();
                           // Navigator.push(context, DialogRoute(context: context, builder: (context) => EditScreen(),));
                          },
                          child: Icon(Icons.g_translate_sharp, color: CustomColors.clrwhite,
                            size: screenWidth * 0.06,),
                        )
                      ],
                    ),
                  )
                ],
              ),

              SliverAppBar(
                backgroundColor:  ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrwhite: CustomColors.clrfavblue,
                shadowColor: Colors.black,
                toolbarHeight: _showBookFormate ? screenWidth * 0.13 :screenWidth * 0.2,
                automaticallyImplyLeading: false,
                pinned: true,
                flexibleSpace: _showBookFormate ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Hanuman Chalisa",textAlign: TextAlign.center,style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color:  ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrblack : CustomColors.clrorange),),
                ) : Container(

                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child:  Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.clrwhite,
                            shape: BoxShape.circle,
                            border: Border.all(color: ThemeManager.getInstance()!.isDarkMode ? Colors.orangeAccent :CustomColors.clrbrown, width: screenWidth  * 0.002,),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.002),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Chapter', style: TextStyle(fontSize: screenWidth * 0.03,color: CustomColors.clrblack),),

                                Text(widget.selectedChapter, style: TextStyle(fontSize: screenWidth * 0.04,fontWeight: FontWeight.w700,color: CustomColors.clrblack),
                                ),
                              ],
                            ),
                          ),
                        ),
      
                        GestureDetector(
                          onTap: () {
                            showmeDialog(context);
                          },
                          child: Container(
                            width: screenWidth * 0.6,
                            height: screenWidth * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/image/frame.png"),fit: BoxFit.cover)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                 // vertical: screenWidth * 0.001
                                ),
                               child: Row(
                                children: [
                                  SizedBox(width: screenWidth * 0.03,),
                                  Text('Arjun Vishad Yog',style: TextStyle(fontSize: screenWidth * 0.04,color: CustomColors.clrblack),),
                                  Icon(Icons.arrow_drop_down,size: screenWidth * 0.05,color: CustomColors.clrblack,),
                                ],
                              ),
                            ),
                          ),
                        ),
      
                        Container(
                          decoration: BoxDecoration(
                            color: CustomColors.clrwhite,
                            shape: BoxShape.circle,
                            border: Border.all(color:ThemeManager.getInstance()!.isDarkMode ? Colors.orangeAccent :CustomColors.clrbrown, width: screenWidth * 0.002,),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.002),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chapter',
                                  style: TextStyle(fontSize: screenWidth * 0.03,color: CustomColors.clrblack),
                                ),
                                Text(
                                  '18',
                                  style: TextStyle(fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.bold,color: CustomColors.clrblack),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _showBookFormate ? Padding(
                      padding:  EdgeInsets.symmetric(vertical: screenWidth * 0.03,horizontal: screenWidth * 0.05),
                      child: Text(
                        "श्रीगुरु चरन सरोज रज निज मन मुकुर सुधारि |\n"
                            "बरनउ रघुवर बिमल जसु जो दायकु फल चारि ||\n\n"
                            "बल बुद्धि विद्या देहु मोहिं हरहु क्लेश विकार |\n"
                            "रामचरित मानस बासिश लोक चारि ||\n\n"
                            "जय हनुमान ज्ञान गुन सागर |\n"
                            "जय कपीस तिहुँ लोक उजागर ||\n\n"
                            "राम दुलारे रघुवर प्रिय भरता सम भाई |\n"
                            "सहस बदन तुम्हरो जस गावत अवले काई ||\n\n"
                            "संकट मोचन नाम तिहारो |\n"
                            "मनवान्छित फल पावत नारो ||\n\n"
                            "महाबीर विक्रम बजरंगी |\n"
                            "कुमति निवार सुमति के संगी ||\n\n"
                            "कंचन बरन विराज सुबेसा |\n"
                            "कानन कुंडल कुंकुम तिलक चारि ||\n\n"
                            "तुम्हरे भजन राम को पावै |\n"
                            "जनम जनम के दुख बिसरावै ||\n\n"
                            "अन्त काल रघुवर पुर जाई |\n"
                            "जहाँ जनम हरिभक्त कहाई ||\n\n"
                            "और देवता चित्त न धरई |\n"
                            "हनुमत सेइ सर्व सुख करई ||\n\n"
                            "संकट कटे मिटे सब पीरा |\n"
                            "जो सुमिरै हनुमत बलबीरा ||\n\n"
                            "जय जय जय हनुमान गोसाई |\n"
                            "कृपा करहु गुरु देव की नाई ||\n\n"
                            "कीजै नाथ हृदय मह डेरा |\n"
                            "दास की करजा संतान तेरा ||\n\n"
                            "यह सत हनुमान चालीसा |\n"
                            "जो यह पढ़े हनुमान चालीसा ||\n\n"
                            "होय सिद्धि साखी गौरीसा |\n"
                            "ता पर कृपा राम दुआरे ||\n\n"
                            "तुलसीदास सदा हरि चेरा |\n"
                            "कीजै दास हनुमान केरा ||",
                        style: TextStyle(fontSize: 18, fontFamily: 'Devanagari',color: ThemeManager.getInstance()!.isDarkMode ? _textColor : CustomColors.clrblack), textAlign: TextAlign.center,),
                    ) : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: gitashlok.length,
                      itemBuilder: (context, index) {
                      return  Column(
                          children: [

                           Container(
                                color: ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrblack:CustomColors.clrskin,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04,horizontal: screenWidth * 0.03),
                                  child: Column(
                                    children: [

                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrwhite :CustomColors.clrblack)
                                        ),child:  Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(gitashlok[index].serialno,style: TextStyle(fontSize: 14),),
                                        ),
                                      ),


                                       Text(gitashlok[index].sanskrit,textAlign: TextAlign.center,style: TextStyle(fontSize: _fontSize,color: ThemeManager.getInstance()!.isDarkMode ? _textColor : CustomColors.clrblack),),

                                      Padding(
                                        padding:EdgeInsets.symmetric(horizontal: screenWidth * 0.07,vertical: screenWidth * 0.05),
                                        child: Row(
                                          children: [

                                            GestureDetector(onTap: () {
                                              Navigator.push(context, DialogRoute(context: context, builder: (context) => ShareScreen(gitaShlok: gitashlok[index].sanskrit,shlokMeaning: gitashlok[index].hindi,),));
                                            },child: Icon(Icons.share_outlined,color:  ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrwhite : CustomColors.clrbrown,size: screenWidth * 0.07,)),

                                            SizedBox(width: screenWidth * 0.03,),
                                            GestureDetector(onTap: () {
                                            },child: Icon(Icons.bookmark_border,color:  ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrwhite : CustomColors.clrbrown,size: screenWidth * 0.07,)),


                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.08),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    _showTranslationBottomSheet(context,gitashlok[index].hindiDetails,);
                                                  },child: Text("भावार्थ",style: TextStyle(color: Colors.blue,fontSize: screenWidth * 0.05),)),
                                            ),

                                            Spacer(),
                                            GestureDetector(onTap: () {

                                            },child: Icon(Icons.play_circle_fill,color:  ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrwhite : CustomColors.clrbrown,size: screenWidth * 0.08,)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02,vertical: screenWidth * 0.002),
                              child: Column(
                                children: [

                                   // Divider(color: ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrorange : CustomColors.clrblack,),

                                  Visibility(
                                    visible: _showHindiText,
                                    child: Column(

                                      children: [
                                        Text(gitashlok[index].hindi,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                                        ),
                                        Container(
                                          height: screenWidth * 0.03,
                                        )
                                      ],
                                    ),
                                  ),

                                  Visibility(
                                    visible: _showEnglishText,
                                    child: Column(
                                      children: [
                                        Text(gitashlok[index].english,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: _fontSize, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
                                        ),
                                        Divider(
                                          color: ThemeManager.getInstance()!.isDarkMode ? CustomColors.clrorange : CustomColors.clrblack,
                                        )
                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                          ],
                      );
                    },)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CircleContainer extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;

  CircleContainer({required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.08,
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.black,width: 2),
        ),
      ),
    );
  }
}
