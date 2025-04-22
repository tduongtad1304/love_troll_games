import 'package:flutter/material.dart';
import 'dart:math';
import 'success_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/rose.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  child: Align(
                    alignment: Alignment(0, 0.5),
                    child: Text(
                      'Spring 🌸 Do you love me?\nTad always loves you babe 🥰😊',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _askButton(
                        color: Colors.teal,
                        textButton: 'Yes',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SuccessPage(),
                            ),
                          );
                        },
                        onHover: (_) => _changeNoBtnPosition(),
                      ),
                      Visibility(
                        maintainState: true,
                        visible: _showingInitialPositionNoBtn,
                        child: MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _showingInitialPositionNoBtn = false;
                            });
                          },
                          child:
                              _askButton(color: Colors.red, textButton: 'No'),
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
                    onEnter: (_) => _changeNoBtnPosition(),
                    child: _askButton(color: _randomColor, textButton: 'No')),
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

  Color get _randomColor {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  ElevatedButton _askButton({
    required Color color,
    VoidCallback? onPressed,
    required String textButton,
    Function(bool)? onHover,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, right: 30, left: 30),
      ),
      onPressed: onPressed ?? () {},
      onHover: onHover,
      child: Text(
        textButton,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
