import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_flappy_bird/components/barries.dart';
import 'package:flutter_flappy_bird/constants.dart';
import 'package:flutter_flappy_bird/components/bird.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;
  bool gameHasStarted = false;
  static double barrierXone=1;
  double barrierXtwo=barrierXone + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {

      time += 0.5;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYAxis = initialHeight - height;
        barrierXone -= 0.3;
        barrierXtwo -= 0.3;
      });

      setState(() {
        if(barrierXone < -2){
          barrierXone += 3.5;
        }
        else{
          barrierXone -= 05;
        }
      });
      setState(() {
        if(barrierXone < -2){
          barrierXone += 3.5;
        }
        else{
          barrierXone -= 05;
        }
      });
      if (birdYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 0),
                      alignment: Alignment(0, birdYAxis),
                      color: Colors.blue,
                      child: MyBird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.15),
                      child: gameHasStarted
                          ? Text("")
                          : Text(
                        "T A P  T O  P L A Y",
                        style: kWhiteColorStyle20,
                      ),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierXone,1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXone,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(barrierXtwo,-1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 250.0,
                      ),
                    ),

                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Score",
                          style: kWhiteColorStyle20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "0",
                          style: kWhiteColorStyle35,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Best Score",
                          style: kWhiteColorStyle20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "10",
                          style: kWhiteColorStyle35,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
