import 'package:flutter/material.dart';
import 'package:sidebar_drawer/bloc_navigation_bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Home page",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
    );
  }
}
