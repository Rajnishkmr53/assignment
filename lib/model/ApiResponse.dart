import 'package:bluestack_assignment/model/tournament_response.dart';

class ApiResponse {
  bool success;
  int code;
  TournamentResponse data;
  ApiResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        code = json['code'],
        data = TournamentResponse.fromJson(json['data']);

  Map<String, dynamic> toJson() => {
        'success': success,
        'code': code,
        'data': data,
      };
}
