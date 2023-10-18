import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:myfinalapp/Pages/list_registered.dart';
import 'package:myfinalapp/Pages/register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  final _pageOptions = [const AddPersonScreen(), const ListPeopleScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Pessoas'),
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.red,
        items: const [
          TabItem(icon: Icons.add, title: 'Adicionar'),
          TabItem(icon: Icons.list, title: 'Lista'),
        ],
        initialActiveIndex: _selectedPage,
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
      ),
    );
  }
}
