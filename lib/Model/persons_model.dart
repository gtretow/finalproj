// ignore_for_file: file_names

import 'package:myfinalapp/Model/person_model.dart';

class PersonsBack4AppModel {
  List<PersonModel> persons = [];

  PersonsBack4AppModel(this.persons);

  PersonsBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      persons = <PersonModel>[];
      json['results'].forEach((v) {
        persons.add(PersonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = persons.map((v) => v.toJson()).toList();
    return data;
  }
}
