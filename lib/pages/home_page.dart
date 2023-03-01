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
              image: AssetImage("assets/rose.jpg"), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  child: Align(
                    alignment: Alignment(0, 0.5),
                    child: Text('Do you love me?',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        )),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.teal),
                          ),
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 20, right: 30, left: 30),
                        ),
                        onHover: (_isHovered) {
                          setState(() {
                            _isHovered = !_isHovered;
                            _changeNoBtnPosition();
                          });
                        },
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SuccessPage()));
                        },
                        child: const Text('Yes'),
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
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.red),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 20, bottom: 20, right: 30, left: 30),
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
                  onEnter: (_) => _changeNoBtnPosition(),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red),
                      ),
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 30, left: 30),
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
