import 'package:admin_bet_hint/controllers/menu_controller.dart';
import 'package:admin_bet_hint/screens/add_game.dart';
import 'package:admin_bet_hint/screens/all_games.dart';
import 'package:admin_bet_hint/services/global_methods.dart';
import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/dashboard_button.dart';
import 'package:admin_bet_hint/widghets/detail_screen_widget.dart';
import 'package:admin_bet_hint/widghets/header.dart';
import 'package:admin_bet_hint/widghets/text_widghet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:provider/src/provider.dart';

import 'Loading_manager.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(0.8),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<MenuController>().controlDashBoardMenu();
              },
              title: 'DashBoard',
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  DashboardButton(
                    backgroundColor: Colors.blue,
                    icon: Icons.store,
                    onpress: () {},
                    text: 'View All',
                  ),
                  const Spacer(),
                  DashboardButton(
                    backgroundColor: Colors.blue,
                    icon: Icons.add,
                    onpress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddGamescreen(),
                        ),
                      );
                    },
                    text: 'Add Game',
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(text: ' Games', color: color, textSize: 18),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                // DetailScreenWidget(),

                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('games')
                        .snapshots(),
                    builder: (context, snapshot) {
                      ///
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const MaterialApp(
                          debugShowCheckedModeBanner: false,
                          home: Scaffold(
                            body: Center(
                              child: LoadingManager(
                                  isLoading: true, child: Text('')),
                            ),
                          ),
                        );
                        //Text('An Error Occured ${snapshot.error}'),
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DetailScreenWidget(
                                    id: snapshot.data!.docs[index]['id'],
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: Text(
                              'Your game store is empty, please add some games',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          );
                        }
                      }

                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            ' Something went wrong',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
