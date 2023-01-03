import 'package:admin_bet_hint/provider/dark_theme_provider.dart';
import 'package:admin_bet_hint/screens/Loading_manager.dart';
import 'package:admin_bet_hint/screens/add_game.dart';
import 'package:admin_bet_hint/screens/all_games.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:provider/provider.dart';

import 'const/theme_data.dart';
import 'controllers/menu_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getcurrenAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    // TODO: implement initState
    getcurrenAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "",
          authDomain: "",
          projectId: "bet-hint-app",
          storageBucket: "",
          messagingSenderId: "",
          appId: "1:819948447216:android:bcdc1ef891b942a2c1a935"));

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: LoadingManager(isLoading: true, child: Text('')),
                ),
              ),
            );
            //Text('An Error Occured ${snapshot.error}'),
          } else if (snapshot.hasData) {
            MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text('An Error Occured ${snapshot.error}'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => MenuController(),
              ),
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                home: const AllGamesScreen(),
                routes: {
                  AddGamescreen.routeName: (ctx) => const AddGamescreen(),
                },
              );
            }),
          );
        });
  }
}
