import 'package:chat_app/bloc/contacts_bloc/contacts_bloc.dart';
import 'package:chat_app/bloc/messages_bloc/messages_bloc.dart';
import 'package:chat_app/bloc/user_bloc/user_bloc.dart';
import 'package:chat_app/ui/modules/chat_screen.dart';
import 'package:chat_app/ui/modules/registration_screen.dart';
import 'package:chat_app/ui/modules/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/ui/modules/home/home_screen.dart';
import 'package:chat_app/ui/modules/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant.dart';

class RouteGenerator {
  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    // Getting arguments passed in while calling Navigator.pushNamed
    //final args = settings.arguments;
    switch (settings.name) {
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.
      case Constants.splashScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: Constants.splashScreen),
          builder: (_) => SplashScreen(),
        );
      case Constants.registrationScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: Constants.registrationScreen),
          builder: (_) => BlocProvider(
            create: (_) => UserBloc(),
            child: RegistrationScreen(),
          ),
        );
      case Constants.loginScreen:
        return MaterialPageRoute(
          settings: RouteSettings(name: Constants.loginScreen),
          builder: (_) => BlocProvider(
            create: (_) => UserBloc(),
            child: LoginScreen(),
          ),
        );
      case Constants.landingScreen:
        if (args != null) {
          if (args is List) {
            return MaterialPageRoute(
              settings: RouteSettings(name: Constants.landingScreen),
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) => UserBloc(),
                  ),
                  BlocProvider(
                    create: (_) => ContactsBloc(),
                  ),
                ],
                child: HomeScreen(
                  uId: args[0],
                ),
              ),
            );
          }
        }
        return _errorRoute();
      case Constants.chatScreen:
        if (args != null) {
          if (args is List) {
            return MaterialPageRoute(
              settings: RouteSettings(name: Constants.chatScreen),
              builder: (_) => BlocProvider(
                create: (_) => MessagesBloc(),
                child: Chat(
                  peerId: args[0],
                  peerEmail: args[1],
                ),
              ),
            );
          }
        }
        return _errorRoute();
      /*case Constants.filmScreen:
        if (args != null) {
          if (args is List) {
            return MaterialPageRoute(
              settings: RouteSettings(name: Constants.filmScreen),
              builder: (_) => FilmScreen(
                filmId: args[0],
                filmTitle: args[1],
              ),
            );
          }
        }
        return _errorRoute();*/
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
