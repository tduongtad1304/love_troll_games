import 'dart:math' as math;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:love_troll_games/success.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Love Troll Games 💖',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _showingInitialPositionNoBtn = true;
  late Offset _offset;

  @override
  void initState() {
    super.initState();
    _offset = _randomOffset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Love Games 💖',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/rose.jpg"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  child: Align(
                    alignment: Alignment(0, 0.5),
                    child: Text(
                      'Do you love me?',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.teal),
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                top: 20, bottom: 20, right: 30, left: 30),
                          ),
                        ),
                        onHover: (_isHovered) {
                          print('Hover');
                          setState(() {
                            _isHovered = !_isHovered;
                            _changeNoBtnPosition();
                          });
                        },
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Success()),
                          );
                        },
                        child: const Text('Yes'),
                      ),
                      Visibility(
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: true,
                        visible: _showingInitialPositionNoBtn,
                        child: MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _showingInitialPositionNoBtn = false;
                            });
                          },
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.only(
                                    top: 20, bottom: 20, right: 30, left: 30),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text('No'),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment(
                _offset.dx,
                _offset.dy,
              ),
              child: Visibility(
                visible: !_showingInitialPositionNoBtn,
                child: MouseRegion(
                  onEnter: (_) {
                    print('Enter');
                    _changeNoBtnPosition();
                  },
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(1.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.only(
                            top: 20, bottom: 20, right: 30, left: 30),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('No'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeNoBtnPosition() {
    setState(() {
      _offset = _randomOffset();
    });
  }

  Offset _randomOffset() {
    final dx = Random().nextDouble() * 2 - 1;
    final dy = Random().nextDouble() * 2 - 1;
    return Offset(dx, dy);
  }
}
