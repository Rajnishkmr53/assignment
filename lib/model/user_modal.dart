import 'package:bluestack_assignment/model/tournament_response.dart';

class User {

  int id;
  String user_name;
  String password;
  String name;
  String profile_pic;
  int rating;
  int tournament_played;
  int tournament_won;

  User({required this.id,required this.user_name,required this.password,required this.name,required this.profile_pic,required this.rating,required this.tournament_played,required this.tournament_won});

  factory User.fromJson(Map json) {
    return User(
        user_name : json['user_name'],
        id : json['id'],
        password: "",
        name:json['name'],
        rating : json['rating'],
        tournament_played :json['tournament_played'],
        tournament_won : json['tournament_won'],
        profile_pic : json['profile_pic']
    );
  }


  // User.fromJson(Map<String, dynamic> json)
  //     : user_name = json['user_name'],
  //       id = json['id'],
  //       password = json['password'],
  //       name = json['name'],
  //       rating = json['rating'],
  //       tournament_played = json['tournament_played'],
  //       tournament_won = json['tournament_won'],
  //       profile_pic = json['profile_pic'];

  Map<String, dynamic> toJson() => {
        'user_name': user_name,
        'password': password,
        'name': name,
        'profile_pic': profile_pic,
        'rating': rating,
        'tournament_played': tournament_played,
        'tournament_won': tournament_won,
      };
}
