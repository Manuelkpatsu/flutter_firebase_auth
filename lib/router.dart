import 'package:flutter/material.dart';

import 'screens/login/phone/number/enter_number_screen.dart';
import 'screens/welcome/welcome_screen.dart';

class AppRouter {
 static Route<dynamic> generateRoute(RouteSettings settings) {
   switch (settings.name) {
     case WelcomeScreen.routeName:
       return MaterialPageRoute(builder: (_) => const WelcomeScreen());
     case EnterNumberScreen.routeName:
       return MaterialPageRoute(builder: (_) => const EnterNumberScreen());
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
