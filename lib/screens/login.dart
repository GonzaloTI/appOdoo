import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constant.dart';
import '../models/api_response.dart';
import '../models/userodoo.dart';
import '../services/user_service.dart';
import 'package:appeventos/provider/album_provider.dart';
//import 'home.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool loading = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void _loginUser() async {
    // Obtener el token de forma asíncrona
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");
    // Guardar el token en el repository
    ref.read(albumRepositoryProvider).tokenNotificacion = token;

    ApiResponse response = await login(txtEmail.text, txtPassword.text,
        ref.read(albumRepositoryProvider).tokenNotificacion!);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as Userodoo);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }

  void _saveAndRedirectToHome(Userodoo user) async {
// Obtener el token de FCM
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.keynotificaciones ?? '');
    await pref.setInt('userId', user.id ?? 0);
    await pref.setString('name', user.name ?? '');
    await pref.setString('ci', user.ci ?? '');

    ref.read(albumRepositoryProvider).userCurrent = user;

    /* Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);*/

    // ignore: use_build_context_synchronously
    context.push('/bitacoralist');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                validator: (val) =>
                    val!.isEmpty ? 'Invalid email address' : null,
                decoration: kInputDecoration('Email')),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: txtPassword,
                obscureText: true,
                validator: (val) =>
                    val!.length < 2 ? 'Required at least 6 chars' : null,
                decoration: kInputDecoration('Password')),
            SizedBox(
              height: 10,
            ),
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : kTextButton('Login', () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                        _loginUser();
                      });
                    }
                  }),
            SizedBox(
              height: 10,
            ),
            kLoginRegisterHint(
                'No tienes un cuanta? ', 'comuniquese con soporte', () {
              print('Callback function executed!');
              /*   Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Register()),
                (route) => true,
              );*/
            })
          ],
        ),
      ),
    );
  }
}
