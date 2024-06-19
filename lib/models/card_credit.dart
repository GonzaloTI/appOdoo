import 'dart:convert';

CardCreditModel cardCreditFromJson(String str) =>
    CardCreditModel.fromJson(json.decode(str));

String cardCreditToJson(CardCreditModel data) => json.encode(data.toJson());

class CardCreditModel {
  String id;
  String cardNumber;
  String nameOwner;
  String dvv;
  bool valid;
  String idUser;
  String expMonth;
  String expYear;
  String idPaymentMethod;

  CardCreditModel({
    required this.id,
    required this.cardNumber,
    required this.nameOwner,
    required this.dvv,
    required this.valid,
    required this.idUser,
    required this.expMonth,
    required this.expYear,
    required this.idPaymentMethod,
  });

  CardCreditModel copyWith({
    String? id,
    String? cardNumber,
    String? nameOwner,
    String? dvv,
    bool? valid,
    String? idUser,
    String? expMonth,
    String? expYear,
    String? idPaymentMethod,
  }) =>
      CardCreditModel(
        id: id ?? this.id,
        cardNumber: cardNumber ?? this.cardNumber,
        nameOwner: nameOwner ?? this.nameOwner,
        dvv: dvv ?? this.dvv,
        valid: valid ?? this.valid,
        idUser: idUser ?? this.idUser,
        expMonth: expMonth ?? this.expMonth,
        expYear: expYear ?? this.expYear,
        idPaymentMethod: idPaymentMethod ?? this.idPaymentMethod,
      );

  factory CardCreditModel.fromJson(Map<String, dynamic> json) =>
      CardCreditModel(
        id: json["id"] ?? '',
        cardNumber: json["card_number"] ?? '',
        nameOwner: json["name_owner"] ?? '',
        dvv: json["dvv"] ?? '',
        valid: json["valid"] ?? '',
        idUser: json["id_user"] ?? '',
        expMonth: json["exp_month"] ?? '',
        expYear: json["exp_year"] ?? '',
        idPaymentMethod: json["id_payment_method"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "card_number": cardNumber,
        "name_owner": nameOwner,
        "dvv": dvv,
        "valid": valid,
        "id_user": idUser,
        "exp_month": expMonth,
        "exp_year": expYear,
        "id_payment_method": idPaymentMethod,
      };
}
