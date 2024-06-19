import 'package:flutter/material.dart';

//STRINGS

//const baseURLOdoo = 'http://192.168.0.15:8069/';

const baseURLOdoo = 'http://3.144.85.247:8069/';

//'http://127.0.0.24:8000/api/admin';

//'http://192.168.0.13:8000/api/admin';// usando pa pc conectandolo al celular por wifihostpot

const loginURLOdoo = baseURLOdoo + '/odoo/auth/login2';

const ComunicadosURLOdoo = baseURLOdoo + '/odoo/estudiante/comunicados';

const AlumnosxPadreURLOdoo = baseURLOdoo + '/odoo/estudiante/padre';

const AlumnosNotasURLOdoo = baseURLOdoo + '/odoo/estudiante/notas';

const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
//###################################################

// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

// button

TextButton kTextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
          child: Text(label, style: TextStyle(color: Colors.blue)),
          onTap: () => onTap())
    ],
  );
}

// likes and comment btn

Expanded kLikeAndComment(
    int value, IconData icon, Color color, Function onTap) {
  return Expanded(
    child: Material(
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: color,
              ),
              SizedBox(width: 4),
              Text('$value')
            ],
          ),
        ),
      ),
    ),
  );
}
