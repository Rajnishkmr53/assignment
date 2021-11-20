import 'package:bluestack_assignment/model/tournament_response.dart';

class Tournament {
  bool tournament_ended;
  String tournament_id;
  String name;
  String cover_url;
  String game_name;

  Tournament.fromJson(Map<String, dynamic> json)
      : tournament_ended = json['tournament_ended'],
        tournament_id = json['tournament_id'],
        name = json['name'],
        cover_url = json['cover_url'],
        game_name = json['game_name'];

  // Map<String, dynamic> toJson() => {
  //       'success': success,
  //       'code': code,
  //       'data': data,
  //     };
}
