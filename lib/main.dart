import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shapp/Screens/login_screen.dart';
import 'package:shapp/Screens/news_screen.dart';
import 'package:shapp/Screens/questiontask_screen.dart';
import 'package:shapp/Screens/registration_screen.dart';
import 'package:shapp/Screens/setting_screen.dart';
import 'package:shapp/providers/category_provider.dart';
import 'package:shapp/services/navigation_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It's preferable to use Multiprovider when you have multiple providers and put them at the
    //root of your project so you can access them every where
    // Nesting them down the widget tree like you did might not be a good idea
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>.value(
          value: CategoryProvider(),
        )
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.instance.navigatorKey,
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Color.fromRGBO(42, 117, 188, 1),
            accentColor: Color.fromRGBO(42, 117, 188, 1),
            backgroundColor: Color.fromRGBO(28, 27, 27, 1)),
        initialRoute: NewsScreen.id,
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          NewsScreen.id: (context) => NewsScreen(),
          QuestionTask.id: (context) => QuestionTask(),
          SettingScreen.id: (context) => SettingScreen(),
        },
      ),
    );
  }
}
