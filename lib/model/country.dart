class Country {
  final String name;
  final String code;
  final String dialCode;

  Country({
    required this.name,
    required this.code,
    required this.dialCode
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['name'] as String,
        code: json['code'] as String,
        dialCode: json['dial_code'] as String
    );
  }
}
