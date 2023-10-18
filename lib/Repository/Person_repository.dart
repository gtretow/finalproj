// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, file_names

import 'package:myfinalapp/Model/persons_model.dart';
import 'package:myfinalapp/Model/person_model.dart';
import 'package:myfinalapp/Repository/back4_app_custom_repository.dart';

class PersonBack4AppRepository {
  final _customDio = Back4AppCustomDio();

  PersonBack4AppRepository();

  Future<PersonsBack4AppModel> getPersons() async {
    var url = "/contactList";
    var result = await _customDio.dio.get(url);

    return PersonsBack4AppModel.fromJson(result.data);
  }

  Future<void> createPerson(PersonModel personModel) async {
    try {
      await _customDio.dio
          .post("/contactList", data: personModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editPerson(PersonModel personModel) async {
    try {
      await _customDio.dio.put("/contactList/${personModel.objectId}",
          data: personModel.toJsonEndpoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePerson(String objectId) async {
    try {
      await _customDio.dio.delete(
        "/contactList/$objectId",
      );
    } catch (e) {
      rethrow;
    }
  }
}
