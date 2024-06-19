import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constant.dart';
import '../models/api_response.dart';
import '../models/comunicados.dart';
import '../services/datos_service.dart';
import 'navbar.dart';

class bitacoralist extends StatelessWidget {
  bitacoralist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BitacoraScreen(),
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text('LISTA DE COMUNICADOS GESTION ESCOLAR'),
        centerTitle: true,
      ),
    );
  }

  text(String s) {}
}

class BitacoraScreen extends StatefulWidget {
  BitacoraScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _bitacoraScreen createState() => _bitacoraScreen();
}

class _bitacoraScreen extends State<BitacoraScreen> {
  List<dynamic> _userList = [];

  bool _loading = true;

  // get all Users
  Future<void> retrieveBitacora() async {
    ApiResponse response = await getBitacoras();
// obtiene a los usuarios
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
    retrieveBitacora(); // obtiene las bitacoras
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: () {
              return retrieveBitacora();
            },
            child: ListView.builder(
                itemCount: _userList.length,
                itemBuilder: (BuildContext context, int index) {
                  Comunicados users = _userList[index];
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
                                    "id : ${(users.id!).toString()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  Text('   '),

                                  // ignore: unnecessary_null_comparison
                                  (users.name != null)
                                      ? Text(
                                          "name: ${users.name!}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        )
                                      : Text(' no name  '),

                                  Text(' '),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "descrp: ${users.descripcion!} ",
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
