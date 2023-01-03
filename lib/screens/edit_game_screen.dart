import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/add_title_widget.dart';
import 'package:admin_bet_hint/widghets/dashboard_button.dart';

import 'package:admin_bet_hint/widghets/side_menu.dart';
import 'package:admin_bet_hint/widghets/text_widghet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../services/global_methods.dart';
import 'Loading_manager.dart';

class EditGameScreen extends StatefulWidget {
  final String id,
      team1Title,
      team2Title,
      gameDate,
      gameTime,
      eventToOccur,
      odd;

  const EditGameScreen(
      {Key? key,
      required this.id,
      required this.team1Title,
      required this.team2Title,
      required this.gameDate,
      required this.gameTime,
      required this.eventToOccur,
      required this.odd})
      : super(key: key);

  @override
  State<EditGameScreen> createState() => _EditGameScreenState();
}

class _EditGameScreenState extends State<EditGameScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _team1titleController,
      _team2titleController,
      _gameDateController,
      _gameTimeDateController,
      _eventToOccurController,
      _oddController;

  @override
  void initState() {
    _team1titleController = TextEditingController(text: widget.team1Title);
    _team2titleController = TextEditingController(text: widget.team2Title);
    _gameDateController = TextEditingController(text: widget.gameDate);
    _gameTimeDateController = TextEditingController(text: widget.gameTime);
    _eventToOccurController = TextEditingController(text: widget.eventToOccur);
    _oddController = TextEditingController(text: widget.odd);

    super.initState();
  }

  @override
  void dispose() {
    _team1titleController.dispose();
    _team2titleController.dispose();
    _gameDateController.dispose();
    _gameTimeDateController.dispose();
    _eventToOccurController.dispose();
    _oddController.dispose();

    super.dispose();
  }

  // Future<void> _submitForm() async {
  //   final isValid = _formKey.currentState!.validate();
  // }

  void deleteForm() async {}

  bool _isLoading = false;
  String team1Title = '';
  String team2Title = '';
  String gameDate = '';
  String gameTime = '';
  String eventToOccur = '';
  String odd = '';

  Future<void> _updateForm() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _isLoading = true;
        });
        await FirebaseFirestore.instance
            .collection('games')
            .doc(widget.id)
            .update({
          'team1Title': _team1titleController.text,
          'team2Title': _team2titleController.text,
          'gameDate': _gameDateController.text,
          'gameTime': _gameTimeDateController.text,
          'eventToOccur': _eventToOccurController.text,
          'odd': _oddController.text,
          'eventOutCome': '',
          'createdAt': Timestamp.now(),
        });

        await Fluttertoast.showToast(
            msg: "game has been updated",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            fontSize: 16.0);

        // print('Succesfully registered');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
        //print('An error occured $error');
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
        //print('An error occured $error');
      } finally {
        _isLoading = false;
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    final theme = Utils(context).getTheme;
    final size = Utils(context).getscreenSize;
    final _scalfoldColor = Theme.of(context).scaffoldBackgroundColor;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // key: context.read<MenuController>().getEditGameScreenScalfoldKey,
        drawer: const SideMenu(),
        body: LoadingManager(
          isLoading: _isLoading,
          child: Row(
            children: [
              // if (Responsive.isDestop(context))
              //   const Expanded(
              //     child: SideMenu(),
              //   ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Header(
                    //   fct: () {
                    //     context
                    //         .read<MenuController>()
                    //         .controlEditGameScreenMenu();
                    //   },
                    //   title: 'Edit Game',
                    //   showTextField: false,
                    // ),
                    SingleChildScrollView(
                      child: Container(
                        width: size.width > 650 ? 650 : size.width,
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AddTitleWidget(
                                controller: _team1titleController,
                                returnText: 'Please enter a Team1 title',
                                textTitle: 'Team 1 title',
                                titlekey: 'Team1Title',
                              ),
                              AddTitleWidget(
                                controller: _team2titleController,
                                returnText: 'Please enter a Team2 title',
                                textTitle: 'Team 2 title',
                                titlekey: 'Team2Title',
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(
                                  text: 'Date of game',
                                  color: color,
                                  textSize: 18,
                                  isTitle: true,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: _scalfoldColor,
                                      child: TextFormField(
                                          controller: _gameDateController,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                                Icons.calendar_today_rounded),
                                            labelText: 'select date',
                                            hintText: '  game date',
                                          ),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime(2100));

                                            if (pickedDate != null) {
                                              setState(() {
                                                _gameDateController.text =
                                                    DateFormat('d MMM ')
                                                        .format(pickedDate);
                                              });
                                            }
                                          }),
                                    ),
                                  ),
                                  //
                                  Expanded(
                                    child: Container(
                                      color: _scalfoldColor,
                                      child: TextFormField(
                                          controller: _gameTimeDateController,
                                          decoration: const InputDecoration(
                                            hintText: 'game time',
                                            icon: Icon(
                                                Icons.calendar_today_rounded),
                                            labelText: 'select time',
                                          ),
                                          onTap: () async {
                                            TimeOfDay? pickedTime =
                                                await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now());

                                            if (pickedTime != null) {
                                              setState(() {
                                                _gameTimeDateController.text =
                                                    pickedTime.format(context);
                                              });
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              AddTitleWidget(
                                controller: _eventToOccurController,
                                returnText: 'Please enter a the event to bet',
                                textTitle: 'Event to occur',
                                titlekey: 'Event2occur',
                              ),
                              AddTitleWidget(
                                controller: _oddController,
                                returnText: 'Please enter an Odd',
                                textTitle: 'Odd',
                                titlekey: 'odd',
                              ),
                              Divider(
                                thickness: 20,
                                color: Theme.of(context).cardColor,
                              ),
                              Container(
                                color: _scalfoldColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      DashboardButton(
                                        text: 'Delete',
                                        onpress: () {
                                          _showDeleteDialogue();
                                        },
                                        icon: Icons.delete,
                                        backgroundColor: Colors.red,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Spacer(),
                                      DashboardButton(
                                        text: 'Update ',
                                        onpress: () {
                                          _updateForm();
                                        },
                                        icon: Icons.update,
                                        backgroundColor: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialogue() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'lib/assets/images/sign-42530_1280.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.fill,
                ),
                const SizedBox(width: 8),
                const SizedBox(height: 8),
                const Text('Delete'),
              ],
            ),
            content: const Text("Do you want to Delete ?"),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: "Cancel",
                  textSize: 15,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('games')
                      .doc(widget.id)
                      .delete();
                  await Fluttertoast.showToast(
                      msg: "game has been deleted",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade600,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.red,
                  text: "Ok",
                  textSize: 15,
                ),
              ),
            ],
          );
        });
  }
}






//

