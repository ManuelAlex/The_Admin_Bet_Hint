import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scalffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gridScalffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _addGameScalffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _gamesHistoryScalffoldKey =
      GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _editGameScreenScalfoldKey =
      GlobalKey<ScaffoldState>();

//_EditGameScreenMenuScalfoldKey
  //getters
  GlobalKey<ScaffoldState> get getscalffoldKey => _scalffoldKey;
  GlobalKey<ScaffoldState> get getgridScalffoldKey => _gridScalffoldKey;
  GlobalKey<ScaffoldState> get getaddGameScalffoldKey => _addGameScalffoldKey;
  GlobalKey<ScaffoldState> get getgamesHistoryScalffoldKey =>
      _gamesHistoryScalffoldKey;
  GlobalKey<ScaffoldState> get getEditGameScreenScalfoldKey =>
      _editGameScreenScalfoldKey;

  //callBacks
  void controlDashBoardMenu() {
    if (!_scalffoldKey.currentState!.isDrawerOpen) {
      _scalffoldKey.currentState!.openDrawer();
    }
  }

  void controlGameDetailsMenu() {
    if (!_gridScalffoldKey.currentState!.isDrawerOpen) {
      _gridScalffoldKey.currentState!.openDrawer();
    }
  }

  void controlAddGameDetailsMenu() {
    if (!_addGameScalffoldKey.currentState!.isDrawerOpen) {
      _addGameScalffoldKey.currentState!.openDrawer();
    }
  }

  void controlGameHistoryDetailsMenu() {
    if (!_gamesHistoryScalffoldKey.currentState!.isDrawerOpen) {
      _gamesHistoryScalffoldKey.currentState!.openDrawer();
    }
  }

  void controlEditGameScreenMenu() {
    if (!_editGameScreenScalfoldKey.currentState!.isDrawerOpen) {
      _editGameScreenScalfoldKey.currentState!.openDrawer();
    }
  }
}
