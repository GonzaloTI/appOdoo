import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _nameState();
}

class _nameState extends State<NavBar> {
  SharedPreferences? usershared;

  Future<void> obtenerSharedPreferences() async {
    usershared = await SharedPreferences.getInstance();
    setState(() {});

    if (usershared?.getString('token') == null) {
      context.push('/login');
    }
  }

  @override
  void initState() {
    obtenerSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        // Remove padding
        // padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('name: ${usershared?.getString('name')}'),
            accountEmail: Text('ci: ${usershared?.getString('ci')}'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home),
                  onTap: () => context.push('/homebar'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Hijos'),
                  onTap: () => context.push('/hijoslist'),
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Comunicados'),
                  onTap: () => context.push('/bitacoralist'),
                ),
              ],
            ),
          ),
          /*ListTile(
            title: Text('Login'),
            leading: Icon(Icons.login),
            onTap: () => context.push('/login'),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () => context.push('/homebar'),
          ),
          ListTile(
            leading: Icon(Icons.archive),
            title: Text('Favorites'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Users'),
            onTap: () => context.push('/users'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Abogados'),
            onTap: () => context.push('/abogadoslist'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Jueces'),
            onTap: () => context.push('/juecelist'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Clientes'),
            onTap: () => context.push('/clientelist'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Casos'),
            onTap: () => context.push('/casoslist'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Buscar Caso / ci-numero'),
            onTap: () => context.push('/buscarcaso'),
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Repots'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Bitacoras'),
            onTap: () => context.push('/bitacoralist'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('casos'),
            onTap: () => null,
          ),*/
          Divider(),
          ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                logout();
                context.push('/login');
              }),
        ],
      ),
    );
  }
}
