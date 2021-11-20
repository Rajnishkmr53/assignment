import 'package:bluestack_assignment/model/tournament_data.dart';

class TournamentResponse {
  String cursor;
  int? tournament_count;
  bool is_last_batch;
  List<Tournament> tournaments;

  TournamentResponse.fromJson(Map<String, dynamic> json)
      : cursor = json['cursor'],
        tournament_count = json['tournament_count'],
        is_last_batch = json['is_last_batch'],
        tournaments = (json['tournaments'] as List).map((i) => Tournament.fromJson(i)).toList();

  // Map<String, dynamic> toJson() => {
  //   'success': success,
  //   'code': code,
  //   'data': data,
  // };
}