import 'package:admin_bet_hint/controllers/menu_controller.dart';
import 'package:admin_bet_hint/services/utils.dart';
import 'package:admin_bet_hint/widghets/add_title_widget.dart';
import 'package:admin_bet_hint/widghets/dashboard_button.dart';
import 'package:admin_bet_hint/widghets/header.dart';
import 'package:admin_bet_hint/widghets/responsive.dart';
import 'package:admin_bet_hint/widghets/side_menu.dart';
import 'package:admin_bet_hint/widghets/text_widghet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'hide MenuController;

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../services/global_methods.dart';
import 'Loading_manager.dart';

class AddGamescreen extends StatefulWidget {
  static const routeName = '/AddGamescreen';
  const AddGamescreen({Key? key}) : super(key: key);

  @override
  State<AddGamescreen> createState() => _AddGamescreenState();
}

class _AddGamescreenState extends State<AddGamescreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _team1titleController,
      _team2titleController,
      _gameDateController,
      _gameTimeDateController,
      _eventToOccurController,
      _oddController;

  @override
  void initState() {
    _team1titleController = TextEditingController();
    _team2titleController = TextEditingController();
    _gameDateController = TextEditingController();
    _gameTimeDateController = TextEditingController();
    _eventToOccurController = TextEditingController();
    _oddController = TextEditingController();

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

  void clearForm() {
    _team1titleController.clear();
    _team2titleController.clear();
    _gameDateController.clear();
    _gameTimeDateController.clear();
    _eventToOccurController.clear();
    _oddController.clear();
  }

  bool _isLoading = false;

  Future<void> _uploadForm() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (_isValid) {
      _formKey.currentState!.save();

      final _uuid = Uuid().v4();

      try {
        await FirebaseFirestore.instance.collection('games').doc(_uuid).set({
          'id': _uuid,
          'team1Title': _team1titleController.text,
          'team2Title': _team2titleController.text,
          'gameDate': _gameDateController.text,
          'gameTime': _gameTimeDateController.text,
          'eventToOccur': _eventToOccurController.text,
          'odd': _oddController.text,
          'eventOutCome': 'Updating..',
          'isHistory': false,
          'thumbsUp': [],
          'thumbsDown': [],
          'createdAt': Timestamp.now(),
        });

        Fluttertoast.showToast(
            msg: "game was successully uploaded",
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

    var inPutDecoration = InputDecoration(
      filled: true,
      fillColor: _scalfoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: context.read<MenuController>().getaddGameScalffoldKey,
        drawer: const SideMenu(),
        body: LoadingManager(
          isLoading: _isLoading,
          child: Row(
            children: [
              if (Responsive.isDestop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Header(
                      fct: () {
                        context
                            .read<MenuController>()
                            .controlAddGameDetailsMenu();
                      },
                      title: 'Add Game',
                      showTextField: false,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextWidget(
                    //     text: 'Add Game',
                    //     color: color,
                    //     textSize: 24,
                    //     isTitle: false,
                    //   ),
                    // ),
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
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
                                        text: 'clear all',
                                        onpress: () {
                                          clearForm();
                                        },
                                        icon: Icons.clear_all,
                                        backgroundColor: Colors.red,
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Spacer(),
                                      DashboardButton(
                                        text: 'Upload ',
                                        onpress: () {
                                          _uploadForm();
                                        },
                                        icon: Icons.upload_file,
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
}

//
