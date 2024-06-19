import 'dart:convert';
import 'dart:io';

import 'package:appeventos/models/card_credit.dart';
import 'package:appeventos/models/error_model.dart';

import 'package:appeventos/models/response_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/userodoo.dart';

final albumRepositoryProvider = Provider(
  (ref) => AlbumRepository(
    client: http.Client(),
  ),
);

class AlbumRepository {
  final http.Client _client;

  AlbumRepository({required http.Client client}) : _client = client;
  String idAlbumCurrent = '';
  List<String> idAlbums = [];
  Userodoo? userCurrent;
  String? tokenNotificacion;
  String nombre = "hola mundo desde provider";

  CardCreditModel? cardCurrent;

  Future<ErrorModel> createCardCredit(String cardNumber, String name,
      String dvv, String idUser, String expMonth, String expYear) async {
    ErrorModel error =
        ErrorModel(error: 'Hubo un error al crear el album', data: null);
    try {
      Uri url = Uri.http('/api/payments/createCardCredit');
      Map<String, String> headers = {'Content-type': 'application/json'};
      String bodyParams = jsonEncode({
        "card_number": cardNumber,
        "name_owner": name,
        "dvv": dvv,
        "valid": false,
        "id_user": int.parse(idUser),
        "exp_month": int.parse(expMonth),
        "exp_year": int.parse(expYear)
      });
      final response = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(response.body);
      ResponseApi res = ResponseApi.fromMap(data);
      if (res.success) {
        error = ErrorModel(error: null, data: res.data);
      } else {
        error = ErrorModel(error: res.message, data: null);
      }
    } catch (e) {
      print(e);
    }
    return error;
  }

  Future<List<CardCreditModel>> getCardCreditsByIdUser(String idUser) async {
    List<CardCreditModel> lista = [];
    try {
      Uri url = Uri.http('/api/payments/getCardCredit/$idUser');
      Map<String, String> headers = {'Content-type': 'application/json'};
      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201) {
        for (var element in data) {
          lista.add(CardCreditModel.fromJson(element));
        }
      }
    } catch (e) {
      print(e);
    }
    return lista;
  }

  bool existeProductoFisico() {
    return true;
  }
}
