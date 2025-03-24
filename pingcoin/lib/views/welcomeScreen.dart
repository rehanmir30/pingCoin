import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';
import 'package:pingcoin/constants/colors.dart';

import 'auth/loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  // double _swipePosition = 0.0;
  // final double _maxSwipeDistance = 200.0;

  late AnimationController _controller;
  late Animation<double> _animation;
  bool isSwiped = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..repeat(reverse: true); // Moves back and forth

    _animation = Tween<double>(begin: 0, end: 10).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // void _onHorizontalDragUpdate(DragUpdateDetails details) {
  //   setState(() {
  //     _swipePosition += details.delta.dx;
  //     if (_swipePosition < 0) _swipePosition = 0;
  //     if (_swipePosition > _maxSwipeDistance) _swipePosition = _maxSwipeDistance;
  //   });
  // }
  //
  // void _onHorizontalDragEnd(DragEndDetails details) {
  //   if (_swipePosition >= _maxSwipeDistance) {
  //     print("Started!");
  //     setState(() {
  //       _swipePosition = 0.0;
  //     });
  //   } else {
  //     setState(() {
  //       _swipePosition = 0.0;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBg,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.15,
          ),
          SvgPicture.asset("assets/svgs/logo.svg"),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            "PING IT OUT.info",
            style: TextStyle(color: rWhite, fontSize: 40, fontWeight: FontWeight.w600),
          ),
          Text(
            "Test the authenticity of your silver and gold coins with precision.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: rWhite),
          ).marginSymmetric(horizontal: 60),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: SwipeButton.expand(
                    borderRadius: BorderRadius.circular(16),
                    onSwipe: () {
                      setState(() => isSwiped = true);
                      Future.delayed(Duration(milliseconds: 300), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      });
                    },
                    activeThumbColor: Colors.green,
                    thumb: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(isSwiped ? 0 : _animation.value, 0), // Moves slightly left-right
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.arrow_forward, color: Colors.white),
                          ),
                        );
                      },
                    ),
                    activeTrackColor: Colors.transparent,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Swipe to start',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.2)),
                                Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.5)),
                                Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.8)),
                              ],
                            ).marginOnly(right: 10))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.1,
          )
        ],
      ),
    );
  }
}
// Container(
// width: MediaQuery.of(context).size.width * 0.9,
// height: 60,
// alignment: Alignment.center,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [
// Colors.white.withOpacity(0.15),
// Colors.white.withOpacity(0.02),
// ],
// begin: Alignment.topLeft,
// end: Alignment.bottomRight,
// ),
// border: Border.all(color: Colors.white.withOpacity(0.2)),
// borderRadius: BorderRadius.circular(16),
// ),
// child: Padding(
// padding: const EdgeInsets.symmetric(
// horizontal:4,
// vertical: 2,
// ),
// child: SwipeButton.expand(
// borderRadius: BorderRadius.circular(16),
// onSwipe: () {
// Get.to(LoginScreen(),transition: Transition.leftToRight);
// },
// activeThumbColor: rGreen,
// thumb: Container(
// child: Icon(
// Icons.arrow_forward,
// color: rWhite,
// ),
// ),
// activeTrackColor: Colors.transparent,
// inactiveThumbColor: Colors.white,
// inactiveTrackColor: Colors.transparent,
// child: Row(
// children: [
// Expanded(
// flex: 2,
// child: Align(
// alignment: Alignment.centerRight,
// child: Text(
// 'Swipe to start',
// style: TextStyle(
// fontSize: 18,
// color: Colors.white,
// ),
// ),
// ),
// ),
// Expanded(
// flex: 1,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Icon(Icons.chevron_right,color: rWhite.withOpacity(0.2),),
// Icon(Icons.chevron_right,color: rWhite.withOpacity(0.5),),
// Icon(Icons.chevron_right,color: rWhite.withOpacity(0.8),),
// ],
// ).marginOnly(right: 10))
// ],
// ),
// ),
// ),
// )