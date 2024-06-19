import 'package:appeventos/models/alumno.dart';
import 'package:appeventos/models/nota.dart';
import 'package:appeventos/screens/navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../services/datos_service.dart';

class ClientelistnotasIA extends StatelessWidget {
  final Alumno? alumnonotas;

  ClientelistnotasIA({super.key, this.alumnonotas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClienteScreen(id: alumnonotas?.id),
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Resumen de Rendimiento'),
        centerTitle: true,
      ),
    );
  }

  text(String s) {}
}

class ClienteScreen extends StatefulWidget {
  final int? id;

  ClienteScreen({super.key, this.id});

  @override
  // ignore: library_private_types_in_public_api
  _clienteScreen createState() => _clienteScreen();
}

class _clienteScreen extends State<ClienteScreen> {
  List<dynamic> _userList = [];
  String recommendations = '';

  bool _loading = true;

  // get all clientes
  Future<void> retrieveUsers() async {
    List<Map<String, dynamic>> studentData = [{}];
    ApiResponse response2 = await getAlumnosNotas2(widget.id);
// obtiene a los clientes
    if (response2.error == null) {
      studentData = response2.data as List<Map<String, dynamic>>;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response2.error}'),
      ));
    }
    print(" lista de notas  $studentData");

    if (studentData.toString() != "[]") {
      ApiResponse response = await getRecommendations(studentData);
// obtiene a los clientes
      if (response.error == null) {
        setState(() {
          // _userList = response.data as List<dynamic>;
          _loading = _loading ? !_loading : _loading;
          recommendations = response.data.toString();
        });
      } else if (response.error == unauthorized) {
        /* logout().then((value) => {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false)
          });*/
        // ignore: use_build_context_synchronously
        context.push('/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${response.error}'),
        ));
      }
    } else {
      setState(() {
        // _userList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        recommendations = "No tiene Notas Aun";
      });
    }
  }

  @override
  void initState() {
    retrieveUsers(); // obtiene a los usuarios
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () {
              return retrieveUsers();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                  child: Text(
                    'Recomendaciones:',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        recommendations,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
