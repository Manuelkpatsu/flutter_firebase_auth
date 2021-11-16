import 'package:flutter/material.dart';

import 'screens/welcome/welcome_screen.dart';

class AppRouter {
 static Route<dynamic> generateRoute(RouteSettings settings) {
   switch (settings.name) {
     case WelcomeScreen.routeName:
       return MaterialPageRoute(builder: (_) => const WelcomeScreen());
     default:
       return MaterialPageRoute(
         builder: (_) => Scaffold(
           body: Center(
             child: Text(
               'No route defined for ${settings.name}',
             ),
           ),
         ),
       );
   }
 }
}
