// lib/widgets/cell_number_tile.dart

import 'package:flutter/material.dart';
import 'package:cell_number_app/models/cell_number.dart';

class CellNumberTile extends StatelessWidget {
  final CellNumber cellNumber;

  const CellNumberTile({super.key, required this.cellNumber});

  @override
  Widget build(BuildContext context) {
    DateTime expiryDate = DateTime.parse(cellNumber.expiryDate);
    DateTime now = DateTime.now();
    Color? tileColor;

    if (expiryDate.isBefore(now)) {
      tileColor = Colors.red;
    } else if (expiryDate.isBefore(now.add(const Duration(days: 30)))) {
      tileColor = Colors.orange;
    }

    return Container(
      color: tileColor,
      child: ListTile(
        title: Text(cellNumber.number),
        subtitle: Text('Expiry Date: ${cellNumber.expiryDate}'),
      ),
    );
  }
}
