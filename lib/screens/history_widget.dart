import 'package:admin_bet_hint/screens/edit_game_screen.dart';

import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/text_widghet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/global_methods.dart';

class DetailScreenWidget extends StatefulWidget {
  final String id;
  const DetailScreenWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailScreenWidget> createState() => _DetailScreenWidgetState();
}

class _DetailScreenWidgetState extends State<DetailScreenWidget> {
  String _dropEditValue = 'Updating..';

  String team1Title = '';
  String team2Title = '';
  String gameDate = '';
  String gameTime = '';
  String eventToOccur = '';
  String odd = '';

  @override
  void initState() {
    getGameData();
    super.initState();
  }

  Future<void> getGameData() async {
    try {
      final DocumentSnapshot gamesDoc = await FirebaseFirestore.instance
          .collection('games')
          .doc(widget.id)
          .get();
      // ignore: unnecessary_null_comparison
      if (gamesDoc == null) {
        return;
      } else {
        setState(() {
          team1Title = gamesDoc.get('team1Title');
          team2Title = gamesDoc.get('team2Title');
          gameDate = gamesDoc.get('gameDate');
          gameTime = gamesDoc.get('gameTime');
          eventToOccur = gamesDoc.get('eventToOccur');
          odd = gamesDoc.get('odd');
        });
      }
    } catch (error) {
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getscreenSize;
    Color color = Utils(context).color;

    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditGameScreen(
                  id: widget.id,
                  team1Title: team1Title,
                  team2Title: team2Title,
                  gameDate: gameDate,
                  gameTime: gameTime,
                  eventToOccur: eventToOccur,
                  odd: odd,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 40,
                  ),
                  TextWidget(
                    text: team1Title,
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ),
                  TextWidget(text: " vs ", color: Colors.cyan, textSize: 15),
                  TextWidget(
                    text: team2Title,
                    color: color,
                    textSize: 20,
                    isTitle: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: gameDate + '' + gameTime,
                color: color,
                textSize: 15,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: eventToOccur,
                color: color,
                textSize: 16,
                isTitle: true,
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 5),
                child: Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Odd($odd)',
                        color: color,
                        textSize: 18,
                        isTitle: true,
                      ),
                      const Spacer(),
                      TextWidget(
                        text: DateFormat('d MMM ')
                            .format(DateTime.now())
                            .toString(),
                        color: color,
                        textSize: 15,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(text: "", color: color, textSize: 18),
                          const SizedBox(
                            width: 5,
                          ),
                          _historyOptionDropdown(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _historyOptionDropdown() {
    return DropdownButtonHideUnderline(
        child: DropdownButton<String>(
      value: _dropEditValue,
      onChanged: (value) {
        setState(() {
          _dropEditValue = value!;
        });
        print(_dropEditValue);
      },
      hint: const Text('Update outCome'),
      items: const [
        DropdownMenuItem(
          child: Text(
            'Updating..',
            style: TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          value: 'Updating..',
        ),
        DropdownMenuItem(
          child: Text(
            'Win',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
          ),
          value: 'Win',
        ),
        DropdownMenuItem(
          child: Text(
            'Lose',
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
          ),
          value: 'Lose',
        ),
      ],
    ));
  }
}
