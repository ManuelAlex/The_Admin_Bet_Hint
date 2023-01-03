import 'package:admin_bet_hint/controllers/menu_controller.dart';
import 'package:admin_bet_hint/screens/add_game.dart';
import 'package:admin_bet_hint/services/global_methods.dart';
import 'package:admin_bet_hint/widghets/dashboard_button.dart';
import 'package:admin_bet_hint/widghets/detail_screen_widget.dart';
import 'package:admin_bet_hint/widghets/header.dart';
import 'package:admin_bet_hint/widghets/responsive.dart';
import 'package:admin_bet_hint/widghets/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' hide MenuController;
import 'package:provider/src/provider.dart';

import 'Loading_manager.dart';

class AllGamesScreen extends StatefulWidget {
  final routeName = '/AllGamesScreen';
  const AllGamesScreen({Key? key}) : super(key: key);

  @override
  State<AllGamesScreen> createState() => _AllGamesScreenState();
}

class _AllGamesScreenState extends State<AllGamesScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalMethods globalMethods = GlobalMethods();
    return Scaffold(
      key: context.read<MenuController>().getgridScalffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDestop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      fct: () {
                        context.read<MenuController>().controlGameDetailsMenu();
                      },
                      title: 'All Games',
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
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('games')
                            .snapshots(),
                        builder: (context, snapshot) {
                          ///
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
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
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
