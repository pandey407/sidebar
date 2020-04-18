import 'package:flutter/material.dart';
import 'package:sidebar_drawer/bloc_navigation_bloc/navigation_bloc.dart';

class Screen2 extends StatelessWidget with NavigationStates{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Second Screen",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      ),
    );
  }
}
