class CellNumber {
  final String number;
  final String expiryDate;

  CellNumber({required this.number, required this.expiryDate});

  factory CellNumber.fromJson(Map<String, dynamic> json) {
    return CellNumber(
      number: json['number'],
      expiryDate: json['expiryDate'],
    );
  }
}
