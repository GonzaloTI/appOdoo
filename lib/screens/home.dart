import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navbar.dart';
import 'package:table_calendar/table_calendar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _nameState();
}

class _nameState extends State<Home> {
  SharedPreferences? usershared;
  List<dynamic> _userList = [];
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Future<void> obtenerSharedPreferences() async {
    usershared = await SharedPreferences.getInstance();
    setState(() {});
  }

  Future<void> retrieveUsers() async {}

  @override
  void initState() {
    obtenerSharedPreferences();
    retrieveUsers();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(''),
        icon: const Icon(Icons.refresh),
        onPressed: () {
          retrieveUsers();
        },
      ),
      appBar: AppBar(
        title: Text('Inicio - Calendario'),
        centerTitle: true,
      ),
      body: Container(
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 200,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //poner un calendario para filtrar por fecha
                        const SizedBox(height: 20),
                        TableCalendar(
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: DateTime.now(),
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay =
                                  focusedDay; // update `_focusedDay` here as well
                            });
                          },
                        ),

                        const Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Fin Calendario',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
