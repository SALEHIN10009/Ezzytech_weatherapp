import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_forcust/widgets/custom_text.dart';

class ForcustDetails extends StatelessWidget {
  ForcustDetails({super.key, this.isSelected});
  bool? isSelected;

  var cilcious = [
    "29°C",
    "32°C",
    "40°C",
    "28°C",
    "29°C",
    "30°C",
    "32°C",
    "37°C",
  ];

  var img = [
    "assets/images/rainy.png",
    "assets/images/cloud.png",
    "assets/images/rainy.png",
    "assets/images/cloud.png",
    "assets/images/rainy.png",
    "assets/images/cloud.png",
    "assets/images/rainy.png",
    "assets/images/cloud.png",
  ];
  var img_1 = [
    "assets/images/cloud.png",
    "assets/images/cloud.png",
    "assets/images/cloud.png",
    "assets/images/cloud.png",
    "assets/images/cloud.png",
    "assets/images/cloud.png",
    "assets/images/cloud.png",
    "assets/images/cloud.png",
  ];

  var time = [
    "12:00",
    "02:00",
    "72:00",
    "12:00",
    "52:00",
    "12:00",
    "12:00",
    "52:00",
  ];
  var date = [
    "Sep, 13",
    "Sep, 14",
    "Sep, 15",
    "Sep, 16",
    "Sep, 17",
    "Sep, 18",
    "Sep, 19",
    "Sep, 20",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff47BFDF),
      body: Column(
        children: [
          const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Spacer(),
                    FaIcon(
                      Icons.settings,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: [
                              CustomText(
                                txt: "Today",
                                textColor: Colors.white,
                                fs: 30,
                                fw: FontWeight.bold,
                                lspace: 0.0,
                              ),
                              const Spacer(),
                              CustomText(
                                txt: "Sep, 12",
                                textColor: Colors.white,
                                fs: 25,
                                fw: FontWeight.w300,
                                lspace: 0.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: img.length,
                            itemBuilder: (_, index) {
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 138,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        // border: Border.all(
                                        //   width: 1,
                                        //   color: Colors.white,
                                        // ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            cilcious[index],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w200,
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          Image.asset(
                                            img[index],
                                          ),
                                          Text(
                                            time[index],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w200,
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          CustomText(
                            txt: "Next Forecast",
                            textColor: Colors.white,
                            fs: 22,
                            fw: FontWeight.bold,
                            lspace: 0.0,
                          ),
                          const Spacer(),
                          const FaIcon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: cilcious.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        leading: Text(
                          date[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        title: Image.asset(
                          img_1[index],
                        ),
                        trailing: Text(
                          cilcious[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
