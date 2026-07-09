import 'package:flutter/material.dart';
import 'package:food_delivery/Pages/screens/app_main_screen.dart';
import 'package:food_delivery/Pages/screens/food_app_home_screen.dart';
import 'package:food_delivery/core//models/on_bording_model.dart';
import 'package:food_delivery/utils/consts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: imageBackground,
            child: Image.asset(
              "assets/food-delivery/food pattern.png",
              color: imageBackgound2,
              repeat: ImageRepeat.repeatY,
            ),
          ),
          Positioned(
            top: -80,
            right: 0,
            left: 0,
            child: Image.asset("assets/food-delivery/chef.png"),
          ),
          Positioned(
            top: 139,
            right: 50,
            child: Image.asset("assets/food-delivery/leaf.png", width: 80),
          ),

          Positioned(
            top: 390,
            right: 40,
            child: Image.asset("assets/food-delivery/chili.png", width: 80),
          ),
          Positioned(
            top: -230,
            right: -20,
            left: 0,
            child: Image.asset(
              "assets/food-delivery/ginger.png",
              width: 90,
              height: 90,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomClip(),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    SizedBox(
                      height: 260,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: data.length,
                        onPageChanged: (value) {
                          setState(() {
                            _currentPage = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: data[index]['title'],
                                      style: TextStyle(color: orange),
                                    ),
                                    TextSpan(
                                      text: data[index]['title2'],
                                      style: TextStyle(color: red),
                                    ),

                                    TextSpan(
                                      text: data[index]['subTitle'],
                                      style: TextStyle(color: grey1),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20),
                              Text(
                                data[index]["description"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),

                              SizedBox(height: 30),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  data.length,
                                  (index) => AnimatedContainer(
                                    duration: Duration(microseconds: 300),
                                    width: _currentPage == index ? 20 : 10,
                                    height: 10,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: _currentPage == index
                                          ? Colors.orange
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AppMainScreen(),
                                    ),
                                  );
                                },
                                color: red,
                                height: 65,
                                minWidth: 250,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  "Get Started",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 30);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 30);
    path.quadraticBezierTo(size.width / 2, -30, 0, 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
