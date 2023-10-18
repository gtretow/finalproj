import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myfinalapp/Model/persons_model.dart';
import 'package:myfinalapp/Repository/Person_repository.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ListPeopleScreen extends StatefulWidget {
  const ListPeopleScreen({super.key});

  @override
  State<ListPeopleScreen> createState() => _ListPeopleScreenState();
}

class _ListPeopleScreenState extends State<ListPeopleScreen> {
  var _people = PersonsBack4AppModel([]);
  PersonBack4AppRepository personRepo = PersonBack4AppRepository();

  @override
  void initState() {
    super.initState();
    getPersons();
  }

  void getPersons() async {
    _people = await personRepo.getPersons();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          'Lista de Pessoas',
          maxFontSize: 18,
          maxLines: 1,
        ),
      ),
      body: _people.persons.isEmpty
          ? const Center(child: Text('Nenhuma pessoa cadastrada.'))
          : ListView.builder(
              itemCount: _people.persons.length,
              itemBuilder: (context, index) {
                final person = _people.persons[index];
                return ListTile(
                  leading: Image.file(
                    File(person.imagePath),
                    height: 50,
                  ),
                  title: AutoSizeText(
                    person.name,
                    maxFontSize: 15,
                  ),
                  subtitle: AutoSizeText(
                    person.address,
                    maxFontSize: 15,
                  ),
                );
              },
            ),
    );
  }
}
