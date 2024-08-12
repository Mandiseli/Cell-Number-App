import 'package:mysql1/mysql1.dart';

class ApiService {
  static const String _host = 'srv1475.hstgr.io';
  static const int _port = 3306;  // Default MySQL port
  static const String _user = 'u296730420_siluxcontrol';
  static const String _password = '!Q1w2e3q1w2e3';
  static const String _database = 'u296730420_siluxcontrol';

  static Future<MySqlConnection> _connect() async {
    try {
      final conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: _host,
          port: _port,
          user: _user,
          password: _password,
          db: _database,
        ),
      );
      return conn;
    } catch (e) {
      throw Exception('Failed to connect to database: $e');
    }
  }

  // Fetch cell numbers from MySQL
  static Future<List<Map<String, dynamic>>> fetchCellNumbers() async {
    final conn = await _connect();
    try {
      final results = await conn.query('SELECT * FROM hsbc_cellNumber_link');
      final List<Map<String, dynamic>> cellNumbers = [];
      for (var row in results) {
        cellNumbers.add({
          'id': row[0],
          'cell_number': row[1],
          'expiry_date': row[2],
          'hub': row[3],
        });
      }
      return cellNumbers;
    } catch (e) {
      throw Exception('Failed to fetch cell numbers: $e');
    } finally {
      await conn.close();
    }
  }

  // Update a cell number in MySQL
  static Future<void> updateCellNumber(int id, String cellNumber, String expiryDate, String hub) async {
    final conn = await _connect();
    try {
      await conn.query(
        'UPDATE hsbc_cellNumber_link SET cell_number = ?, expiry_date = ?, hub = ? WHERE id = ?',
        [cellNumber, expiryDate, hub, id],
      );
    } catch (e) {
      throw Exception('Failed to update cell number: $e');
    } finally {
      await conn.close();
    }
  }

  // Assign a cell number in MySQL
  static Future<void> assignCellNumber(String cellNumber, String expiryDate, String hub) async {
    final conn = await _connect();
    try {
      await conn.query(
        'INSERT INTO hsbc_cellNumber_link (cell_number, expiry_date, hub) VALUES (?, ?, ?)',
        [cellNumber, expiryDate, hub],
      );
    } catch (e) {
      throw Exception('Failed to assign cell number: $e');
    } finally {
      await conn.close();
    }
  }
}
