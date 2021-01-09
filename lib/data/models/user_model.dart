import 'package:chat_app/data/sources/moor_database/moor_database.dart';
import 'package:flutter/material.dart';

class User {
  String id;
  String nickname;
  String email;
  String image;

  User({
    this.id,
    this.nickname,
    this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      nickname: data['nickname'],
      email: data['email'],
      image: data['image_url'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'email': email,
        'image_url': image,
      };

  Map<String, dynamic> toUpdateJson() => {
        'id': id,
        'nickname': nickname,
        'email': email,
        'image_url': image,
      };

  UserData toUserData({@required int type}) {
    return UserData(
      id: this.id,
      nickname: this.nickname,
      email: this.email,
      image: this.image,
      type: type,
    );
  }

  factory User.fromUserData(UserData userData) {
    return User(
      id: userData.id,
      nickname: userData.nickname,
      email: userData.email,
      image: userData.image,
    );
  }

//   factory Person.fromPersonData(PersonData personData) {
//     return Person(
//         name: personData.name,
//         gender: personData.gender,
//         birthYear: personData.birthYear,
//         height: personData.height,
//         mass: personData.mass,
//         eyeColor: personData.eyeColor,
//         skinColor: personData.skinColor,
//         hairColor: personData.hairColor,
//         homeworld: personData.homeworld,
//         films: MainModel.retrieveURLs(Constants.filmsRoute, personData.films),
//         species:
//             MainModel.retrieveURLs(Constants.speciesRoute, personData.species),
//         starships: MainModel.retrieveURLs(
//             Constants.starshipsRoute, personData.starships),
//         vehicles: MainModel.retrieveURLs(
//             Constants.vehiclesRoute, personData.vehicles),
//         created: personData.created,
//         edited: personData.edited,
//         url: Constants.mainUrl +
//             Constants.peopleRoute +
//             "${personData.id}" +
//             "/");
//   }

//   PersonData toPersonData() {
//     return PersonData(
//       id: getId(this.url),
//       name: this.name,
//       gender: this.gender,
//       birthYear: this.birthYear,
//       height: this.height,
//       mass: this.mass,
//       eyeColor: this.eyeColor,
//       skinColor: this.skinColor,
//       hairColor: this.hairColor,
//       homeworld: this.homeworld,
//       films: getIdList(this.films),
//       species: getIdList(this.species),
//       starships: getIdList(this.starships),
//       vehicles: getIdList(this.vehicles),
//       created: DateTime.now().toIso8601String(),
//       edited: DateTime.now().toIso8601String(),
//     );
//   }
// }
}
