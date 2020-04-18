import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sidebar_drawer/bloc_navigation_bloc/navigation_bloc.dart';
import 'package:sidebar_drawer/sidebar/menu_item.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSideBarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink = isSideBarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;
    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
        initialData: false,
        stream: isSideBarOpenedStream,
        builder: (context, snapshot) {
          return AnimatedPositioned(
            duration: _animationDuration,
            top: 0,
            bottom: 0,
            left: snapshot.data ? 0 : -screenWidth,
            right: snapshot.data ? 0 : screenWidth - 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.blueAccent,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.perm_identity,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          title: Text(
                            'Drawer Heading',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.white,
                          indent: 20,
                          endIndent: 20,
                        ),
                        MenuItem(
                          icon: Icons.home,
                          title: "Home",
                          onTap: (){
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.cake,
                          title: "Screen 1",
                          onTap: (){
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.Screen1ClickEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.call,
                          title: "Screen 2",
                          onTap: (){
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.Screen2ClickEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.more,
                          title: "More",
                        ),
                        Divider(
                          height: 64,
                          thickness: 0.5,
                          color: Colors.white,
                          indent: 20,
                          endIndent: 20,
                        ),
                        MenuItem(
                          icon: Icons.settings,
                          title: "Settings",
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0,-0.8),
                  child: GestureDetector(
                    onTap: () {
                      onIconPressed();
                    },
                    child: ClipPath(
                      clipper: CustomMenuClipper(),
                      child: Container(
                        width: 35,
                        height: 110,
                        color: Colors.blueAccent,
                        alignment: Alignment.center,
                        child: AnimatedIcon(
                          icon: AnimatedIcons.menu_home,
                          progress: _animationController.view,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width-1, height/2 -20, width, height/2);
    path.quadraticBezierTo(width+1, height/2 +20, 10, height-16);
    path.quadraticBezierTo(0, height-8, 0, height);
    
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
