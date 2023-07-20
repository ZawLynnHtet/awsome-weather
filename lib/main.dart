import 'package:awsome_weather/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'api.dart';
import 'style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:glass_kit/glass_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double location = 0.0;
  double temp = 0.0;
  double wind = 0.0;
  int? humidity;
  String country = "";
  String name = "";
  Position? myCurrentPosition;
  String tempResult = "";
  String searchResult = "Mandalay";
  Color dayLight = Colors.blue;
  Color nightLight = bgDark;
  TextEditingController searchValue = TextEditingController();

  Future getResult() async {
    var jsonRes = await cityCall(searchResult);
    temp = jsonRes['main']['temp'];
    wind = jsonRes['wind']['speed'];
    country = jsonRes['sys']['country'];
    name = jsonRes['name'];
    humidity = jsonRes['main']['humidity'];
    setState(() {});
  }


  

  @override
  void initState() {
    super.initState();
    getResult();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dayLight,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 260,
                        child: TextField(
                          controller: searchValue,
                          style: TextStyle(
                            color: textWhite
                          ),
                          enabled: true,
                          cursorOpacityAnimates: true,
                          cursorColor: textWhite,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              color: textWhite,
                            ),
                            suffixIcon: IconButton(onPressed: () async{
                              await getResult();
                              searchResult = searchValue.text;
                              searchValue.clear();
                              debugPrint(searchResult);
                              setState(() {
                                
                              });
                            }, icon: Icon(
                              Icons.search,
                              color: textWhite,
                            ),),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: textWhite, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: textWhite, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 63,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: textWhite, width: 2.0)),
                        child: MaterialButton(
                          onPressed: () async{
                            myCurrentPosition = await determinePosition();
                            // debugPrint(myCurrentPosition as String?);
                            setState(() {
                              
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.locationCrosshairs,
                            color: textWhite,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Today's Report",
                              style: TextStyle(
                                  color: textWhite,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: textWhite,
                                  size: 22,
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      color: textWhite,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          country,
                          style: TextStyle(
                              color: textWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'images/sun.png',
                    width: 200,
                    height: 200,
                    filterQuality: FilterQuality.high,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      "Its Hot",
                      style: TextStyle(
                          color: textWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    "${temp.toInt()} °C",
                    style: TextStyle(
                        color: textWhite,
                        fontSize: 60,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          alignment: Alignment.center,
                          height: 180,
                          width: 500,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.white54, Colors.white10]),
                            borderRadius: BorderRadius.circular(25),
                            // border: Border.all(width: 2, color: Colors.white30)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/sun.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Sun",
                                    style: TextStyle(
                                        color: textWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${temp.toInt()} °",
                                    style: TextStyle(
                                        color: textWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/cloudy.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Rain",
                                    style: TextStyle(
                                        color: textWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "$humidity °",
                                    style: TextStyle(
                                        color: textWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'images/wind.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Wind Speed",
                                    style: TextStyle(
                                        color: textWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${wind.toInt()} °",
                                    style: TextStyle(
                                        color: textWhite,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
