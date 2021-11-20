import 'dart:async';

import 'package:bluestack_assignment/data/datbase_provider.dart';
import 'package:bluestack_assignment/model/ApiResponse.dart';
import 'package:bluestack_assignment/model/tournament_data.dart';
import 'package:bluestack_assignment/model/user_modal.dart';
import 'package:bluestack_assignment/network/Apis.dart';
import 'package:bluestack_assignment/network/api_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AppUtill.dart';
import '../res.dart';

enum Event { LOAD, LOAD_MORE }

class HomeBlock {
  String _cursor = "";
  int? _userid = 0;
  List<Tournament> _tournaments = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _loadRecommendedStreamController = StreamController<Event>();
  final _recommendedStreamController = StreamController<List<Tournament>>();
  final _loadMoreStreamController = StreamController<bool>();
  // final _userStreamController = StreamController<User>();

  final _userStreamController=StreamController<User>.broadcast();

  StreamSink<Event> get loadRecommendedSink =>
      _loadRecommendedStreamController.sink;

  Stream<Event> get loadRecommendedStream =>
      _loadRecommendedStreamController.stream;

  StreamSink<List<Tournament>> get recommendedSink =>
      _recommendedStreamController.sink;

  Stream<List<Tournament>> get recommendedStream =>
      _recommendedStreamController.stream;

  StreamSink<bool> get loadmoreSink =>
      _loadMoreStreamController.sink;

  Stream<bool> get loadmoreStream =>
      _loadMoreStreamController.stream;

  StreamSink<User> get userSink =>
      _userStreamController.sink;

  Stream<User> get userStream =>
      _userStreamController.stream;

  HomeBlock() {
    getUserData();


    loadRecommendedStream.listen((value) {
      AppUtill.printAppLog("value::${value.toString()}");
      loadmoreSink.add(true);
      _getRecommendedItems((tournaments) {
        loadmoreSink.add(false);
        _tournaments.addAll(tournaments);
        recommendedSink.add(_tournaments);
        AppUtill.printAppLog("tournaments::${tournaments.length}");
        AppUtill.printAppLog("_tournaments::${_tournaments.length}");
      }, _cursor);
    });
  }

  _getRecommendedItems(void inner(List<Tournament> tournaments),
      String cursor) {
    ApiCalls().forRequest((ApiResponse apiResponce) {
      if (apiResponce.success) {
        _cursor = apiResponce.data.cursor;
        inner(apiResponce.data.tournaments);
      }
    }, Apis.GET_TOURNAMENTS.replaceAll("#cursor", cursor), RequestType.GET);
  }

  dispose() {
    _loadRecommendedStreamController.close();
    _recommendedStreamController.close();
    _loadMoreStreamController.close();
    _userStreamController.close();
  }

  void getUserData() {
    _prefs.then((SharedPreferences prefs) {
      _userid = prefs.getInt(Keys.USER);
      DBProvider.db.getUser(_userid, (_user) => {
        userSink.add(_user)
      });
    });
  }
}
