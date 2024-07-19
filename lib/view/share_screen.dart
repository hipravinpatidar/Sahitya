import 'package:flutter/material.dart';
import 'package:sahityadesign/ui_helpers/custom_colors.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: CustomColors.clrwhite,size: screenwidth * 0.06,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text('Share', style: TextStyle(color: CustomColors.clrwhite, fontFamily: 'Roboto', fontWeight: FontWeight.w600, fontSize: screenwidth * 0.06)
          ),
          backgroundColor: CustomColors.clrorange,
        ),
      
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.only(top: screenheight * 0.02, left: screenwidth * 0.05, right: screenwidth * 0.05),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(226, 64, 79, 1),
                          Color.fromRGBO(179, 22, 43, 1),
                        ]
                    ),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: screenwidth * 0.03),
                    child: Column(
                      children: [
                
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.03),
                          child: Column(
                            children: [
                
                              Text('ॐ',style: TextStyle(color: CustomColors.clrwhite,fontFamily: "Roboto",fontSize: screenwidth * 0.05),),
                              Text('॥ श्रीमद् भगवद् गीता ॥',style: TextStyle(fontSize: screenwidth * 0.05,fontFamily: 'Roboto',fontWeight: FontWeight.w400,color: Color.fromRGBO(255, 255, 255, 1),decoration: TextDecoration.underline,decorationColor: Colors.white),),
                              SizedBox(height: screenwidth * 0.02,),
                              Text("धर्मक्षेत्रे कुरुक्षेत्रे समवेता युयुत्सवः। मामकाः पाण्डवाश्चैव किमकुर्वत संजय",textAlign: TextAlign.center,style: TextStyle(fontSize: screenwidth * 0.05,fontFamily: 'Roboto',fontWeight: FontWeight.w400,color: CustomColors.clrwhite)),
                
                              Padding(
                                padding:  EdgeInsets.only(left: screenwidth * 0.02,right: screenwidth * 0.02),
                                child: Divider(thickness: screenwidth * 0.002,),
                              ),
                
                              SizedBox(height: screenwidth * 0.03,),
                              Container(
                                decoration: BoxDecoration(
                                  color: CustomColors.clrwhite,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                  child: Text('भावार्थ',style: TextStyle(fontFamily: 'Roboto',fontSize: screenwidth * 0.04,fontWeight: FontWeight.w400,color: Color.fromRGBO(0, 0, 0, 1)),),
                                ),
                              ),
                
                
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: screenwidth * 0.06),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                
                                    Text("भावार्थ : धृतराष्ट्र बोले- हे संजय! धर्मभूमि कुरुक्षेत्र में एकत्रित, युद्ध की इच्छावाले मेरे और पाण्डु के पुत्रों ने क्या किया?",textAlign: TextAlign.center,style: TextStyle(fontSize: screenwidth * 0.05,fontWeight: FontWeight.w400,color: CustomColors.clrwhite),),
                
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.08),
                                      child: Text('(अर्जुनविषादयोग )  श्लोक: 1',textAlign: TextAlign.center,style: TextStyle(fontSize: screenwidth * 0.05,fontWeight: FontWeight.w400,color: CustomColors.clrwhite),),
                                    ),
                
                
                                    Padding(
                                      padding:  EdgeInsets.only(left: screenwidth * 0.02,right: screenwidth * 0.02),
                                      child: Divider(thickness: screenwidth * 0.002,),
                                    ),
                            ],
                          ),
                        ),
                
                            ],
                          ),
                        ),
                
                
                        Container(
                          width: double.infinity,
                          color: Color.fromRGBO(112, 13, 27, 1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.01,vertical: screenwidth * 0.02),
                            child: Row(
                              children: [
                
                                SizedBox(width: screenwidth * 0.02,),
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: CustomColors.clrblack,
                                      borderRadius: BorderRadius.circular(10),
                                    ),child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02,vertical: screenwidth * 0.02),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: screenwidth * 0.06,
                                          width: screenwidth * 0.06,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/6f8b/d4e3/3622b64da1ee1f2a105da38608f4ebd6?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=abbduEQaR692JO2aCBP8Uhx027IYG1H2ppmjRR38jJF9mrXX4LfSI7iRjPMYmaM6bNaJkO104bdL-3OsVCEGt3rs8-D7SlmJ56hpz45bzdeneTK11rVln9PFVJGRNcL8wK4Y6Q8ANeYLOLaeYD4wqpvKVlajmuD3rPJTw6~I25e53uyGixZjgo~~OgZtB1kc037QdKiXWHQCUcdWbFxaFHgvhAquVRjsVefYpiHr1IbSWzele9VXaMZCPnPqFjaa8C8gfTQEOiEvGqKj33ku6~dp67bNxDhJ1iEynhCMSCaMkvPkQgAO3PyuFfUVMkVzUx3LuKmzv6ulqdSnO0BxRA__"),fit: BoxFit.cover)
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Get it on",style: TextStyle(fontSize: screenwidth * 0.02,color: CustomColors.clrwhite),),
                                              Text("Google Play",style: TextStyle(fontSize: screenwidth * 0.03,color: CustomColors.clrwhite),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  ),
                                ),
                
                                SizedBox(width: screenwidth * 0.03,),
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: CustomColors.clrblack,
                                      borderRadius: BorderRadius.circular(10),
                                    ),child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02,vertical: screenwidth * 0.02),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: screenwidth * 0.06,
                                          width: screenwidth * 0.06,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/c3f1/3b8c/a992e9cfa2b3f1d1f1abb7a5d311c35d?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Pq9UfD1zgcRqWfLlKwKTwunPQWSm4HjeMLAWjMDw0TKdIPURSCS2waVVNd0NKlLEShIVNjUDsTwh1Sq125VMJU1-u2Y1IyHGgO8W8l6IYcSEI7uR1Nkl6IY7T0NtRybqWSJHqIWltvw3ifq-V4SrOrmWHwmxV0ZFSAqYGl2J2Ksp55KPlZl6I2uQpQZGfCkvW1PuHfe8539QTPeRB1~SZHSNffa29bwZIRKURQ~rW-F2PL92HvCJZgfXJTsi-fEWEq7GogccqgOmA6dQVGwTdh3wKUse~1gP2ah5nxJRmAB~WXJUNxL8OYEMq3SxCaRfYlLIAllXF60w1LF~f8D8qg__"),fit: BoxFit.cover)
                                          ),
                                        ),
                
                
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.02),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Get it on",style: TextStyle(fontSize: screenwidth * 0.02,color: CustomColors.clrwhite),),
                                              Text("App Store",style: TextStyle(fontSize: screenwidth * 0.03,color: CustomColors.clrwhite),),
                                            ],
                                          ),
                                        )
                                      ],
                                      ),
                                    ),
                                  ),
                                ),
                
                                SizedBox(width: screenwidth * 0.03,),
                                GestureDetector(
                                  child: Container(
                                    height: screenwidth * 0.1,
                                    width: screenwidth * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),child: Image(image: NetworkImage("https://s3-alpha-sig.figma.com/img/64c4/ba75/45e806f9ddfa0f5c732cf1348d1a4710?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VioIfQ840MqxFo0iL3nOHBtBWuI4kC-1phgaFa2Cb9BxUQje~gKBabKWsFfNq7PHOrJlwXhrFquuWnDBskzfbMVfR0bNPULo72ugARrkHew-9iNUa01ciEZer5gUM~ZSoKehx9ek~QULxXHXZ03TRReZtdfn0irfsdrzJ8yIzI7gtiKbmfv2RI6S~jQYm0jJA51nL3KmF9KVNxTASodpGrwMc~vYO6KryEcZvaKyWf07KUtgpHZUhsQfkJH-h3dda~tRj~oJUfj5Ok2PEPXAz-vxFTXQt1pOWclSQ~k7f0rJQndHYrb4N9KWXXcwVyy13121LhCeewn3wRpicIO8ZQ__")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
                
                
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.1,vertical: screenwidth * 0.1),
                child: Row(
                  children: [

                    SizedBox(width: screenwidth * 0.05,),
                    Column(
                      children: [

                        Container(
                          height: screenwidth * 0.08,
                          width: screenwidth * 0.08,
                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/bdd9/415c/8bdeac681726a625de1eddf69cccb586?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bht6QpTsfLtFyNwca5gaoFMq7TXwtfUCpE31w9U88GYwUWIMEa9v2jNrlZLgZza~bWwUDc73DTW9sLbQOxCezDcHSVsmvxzyIl6vIRw~zZ4FQMfdZhJO0ZD8-xpjagfp8WGPXqTWhjJU~q~CzNA-VemudD4OQxutkTUedjNX2DgMDYvyfZfVmmy4u68h4RiKRHA0Z3pAzI1N2yLGvmf7MGTRCP8TwXptFIK9heMtVJ0RdxxTkfAK~T0HJYr6p7Eloh8jWLGQZZTBbFM2ifNkMqFA9uoLxpf8JgJ~gWe1RhskodaNoYMPjw8~oxEEd7A9sPXvbhjW0V6SmbLBLpiteQ__"))),
                        ),
                        SizedBox(height: screenwidth * 0.02,),
                        Container(
                          height: screenwidth * 0.2,
                          width: screenwidth * 0.2,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                          color: Colors.green),
                        ),
                      ],
                    ),

                    SizedBox(width: screenwidth * 0.05,),
                    Column(
                      children: [

                        Container(
                            height: screenwidth * 0.08,
                            width: screenwidth * 0.08,
                            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/d0a8/b980/140013f0f5d8690b163080d1004c6ba6?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=WBOEq0Xv77u6pPd-npJLq1H7ab0vQa3noNhhESKuGPnoCGjyVAjR07nm1tNHA2BNDlefrp-KLD4RHEu6Iy6fB3YANcxy9V3K-IxlUeFLLgzSURmFDMVSzeiJsm25qIejvLgF7OYs69dRXBOHvJFpme0YHiiF1JoVWEhNzWjnmmJpl1c7eSXQEZFn~lShQL8g2B~8SXZOzsT45vYnF7Ddz2LxaAt1pR1-~UouqfJDVF6u3DO5KzpEqnPVTk9AuzFWYfsztuAIhLYJGmxevu-g3d8c0Il9caUlavqu0cMAugzgRKtOgAa85Q32rlf1DBZLD2a75ZnefCRuXy1yZHbqCQ__"),fit: BoxFit.cover))
                        ),

                        SizedBox(height: screenwidth * 0.02,),
                        Container(
                          height: screenwidth * 0.2,
                          width: screenwidth * 0.2,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                          border: Border.all(color: Colors.brown),
                          color: Colors.red),
                        ),
                      ],
                    ),

                    SizedBox(width: screenwidth * 0.05,),
                    Column(
                      children: [
                
                        Container(
                          height: screenwidth * 0.08,
                          width: screenwidth * 0.08,
                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage("https://s3-alpha-sig.figma.com/img/315b/a6e2/0e42000d4136cf401e3ed847ee7a7604?Expires=1721606400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ltQ653r2CIryAf69VMCR1zMQQmxop4H5OU7a5ZSW8mBlhUXNHIfOVzVrQxiXSv9oSLSUtCfEIc2hFoxzmIWacm5EDc5BQviRrXXzwkV07s3Kd0Breo7-7NlB~-FkaHGHS~mVbb8kKuQ47iyt4FEmeAZwTjrOhwjN8czVPmpksUBAeDVUsnZ8vj5JPIrPF24FbZPo50uFemjtnqSihtpuJIX6v9TUEdkCtOyUDKjlH-R3QxFyEazNbjbhsCwEK3cJ8V6YCDpR~ElW83p1u8KSJqxw1gbQoU3BGAdOPxR9pqq5sFh2DeGLd1M8GnTfGE9-pm41~FAE9bcbjvdr5J~hwA__"),fit: BoxFit.cover)),
                        ),
                
                        SizedBox(height: screenwidth * 0.02,),
                        Container(
                          height: screenwidth * 0.2,
                          width: screenwidth * 0.2,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                          color: Colors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenwidth * 0.05),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(0, 71, 255, 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical:  screenwidth * 0.03),
                    child: Row(
                      children: [
                        SizedBox(width: screenwidth * 0.3,),
                        Text("Share Image",style: TextStyle(fontSize: screenwidth * 0.04,color: CustomColors.clrwhite,fontWeight: FontWeight.w400),),
                        SizedBox(width: screenwidth * 0.05,),
                        Icon(Icons.share,color: CustomColors.clrwhite,size: screenwidth * 0.1,)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}