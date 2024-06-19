import 'package:appeventos/models/alumno.dart';
import 'package:appeventos/screens/alumnoRecomendacionIA.dart';
import 'package:appeventos/screens/alumnolistnotas.dart';
import 'package:appeventos/screens/navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import '../../models/api_response.dart';
import '../services/datos_service.dart';

class Clientelist extends StatelessWidget {
  Clientelist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClienteScreen(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Lista de Hijos'),
        icon: const Icon(Icons.add),
        onPressed: () {
          //  context.push('/clientescreate');
        },
      ),
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('Lista de Hijos del padre'),
        centerTitle: true,
      ),
    );
  }

  text(String s) {}
}

class ClienteScreen extends StatefulWidget {
  ClienteScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _clienteScreen createState() => _clienteScreen();
}

class _clienteScreen extends State<ClienteScreen> {
  List<dynamic> _userList = [];

  bool _loading = true;

  // get all clientes
  Future<void> retrieveUsers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int userId = pref.getInt('userId') ?? 0;

    ApiResponse response = await getAlumnosxPadre(userId);
// obtiene a los clientes
    if (response.error == null) {
      setState(() {
        _userList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
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
            child: ListView.builder(
                itemCount: _userList.length,
                itemBuilder: (BuildContext context, int index) {
                  Alumno users = _userList[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                children: [
                                  Text(
                                    (users.id!).toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  Text(' Nombre:  '),
                                  Text(' '),
                                  Text(
                                    "${users.name!} ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  Text(' '),
                                ],
                              ),
                            ),
                            PopupMenuButton(
                              child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.black,
                                  )),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: Text('Ver Notas'), value: 'edit'),
                                // dialogo para eliminar y su confirmacion
                                PopupMenuItem(
                                    child: Text('Resumen de sus notas por IA'),
                                    value: 'edit2'),
                              ],
                              onSelected: (val) {
                                if (val == 'edit') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Clientelistnotas(
                                          alumnonotas: users)));
                                } else {
                                  //_handleDeletePost(post.id ?? 0);
                                }
                                if (val == 'edit2') {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ClientelistnotasIA(
                                          alumnonotas: users)));
                                }
                              },
                            )
                          ],
                        ),
                        Text(
                          " Rude: ${users.rude!} ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 10,
                              width: 0.5,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 0.5,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  );
                }),
          );
  }
}

class DialogExample extends StatefulWidget {
  final Alumno? id;

  DialogExample({this.id});

  @override
  _DialogExample createState() => _DialogExample();
}

class _DialogExample extends State<DialogExample> {
/*
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});*/

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Eliminar'),
          content: Text('cliente  ${widget.id?.name}'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {}

              //  context.push('/login')
              , // hace una accion      Navigator.pop(context, 'OK'),

              child: const Text('eliminar'),
            ),
          ],
        ),
      ),
      child: const Text('Eliminar'),
    );
  }
}
