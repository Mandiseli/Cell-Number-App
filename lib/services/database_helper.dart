import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  final ConnectionSettings settings = ConnectionSettings(
    host: 'srv1475.hstgr.io',
    port: 3306,
    user: 'u296730420_siluxcontrol',
    password: '!Q1w2e3q1w2e3',
    db: 'u296730420_siluxcontrol',
  );

  Future<MySqlConnection> _getConnection() async {
    return await MySqlConnection.connect(settings);
  }

  Future<void> createCellNumber(String cellNumber) async {
    final conn = await _getConnection();
    await conn.query('INSERT INTO hsbc_cellNumber_link(cell_number) VALUES (?)', [cellNumber]);
    await conn.close();
  }

  Future<List<Map<String, dynamic>>> fetchCellNumbers() async {
    final conn = await _getConnection();
    final results = await conn.query('SELECT * FROM hsbc_cellNumber_link');
    final cellNumbers = results.map((result) => {
          'id': result['id'],
          'cell_number': result['cell_number'],
        }).toList();
    await conn.close();
    return cellNumbers;
  }

  Future<void> updateCellNumber(int id, String cellNumber) async {
    final conn = await _getConnection();
    await conn.query('UPDATE hsbc_cellNumber_link SET cell_number = ? WHERE id = ?', [cellNumber, id]);
    await conn.close();
  }

  Future<void> deleteCellNumber(int id) async {
    final conn = await _getConnection();
    await conn.query('DELETE FROM hsbc_cellNumber_link WHERE id = ?', [id]);
    await conn.close();
  }
}
