import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/screen1.dart';
import '../screens/screen2.dart';
import '../screens/homepage.dart';

enum NavigationEvents {
  HomePageClickEvent,
  Screen1ClickEvent,
  Screen2ClickEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async*{
    switch(event){
      case NavigationEvents.HomePageClickEvent: yield HomePage();
      break;
      case NavigationEvents.Screen1ClickEvent: yield Screen1();
      break;
      case NavigationEvents.Screen2ClickEvent: yield Screen2();
      break;
    }
  }
}
