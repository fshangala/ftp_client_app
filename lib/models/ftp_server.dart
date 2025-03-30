import 'package:ftpconnect/ftpconnect.dart';

class FTPServer {
  String ip;
  int port;
  String username;
  String password;
  late FTPConnect connection;

  FTPServer({
    required this.ip,
    this.port = 21, // default FTP port
    this.username = 'anonymous',
    this.password = '',
  });

  factory FTPServer.fromMap(Map<String, dynamic> map) {
    return FTPServer(
      ip: map['ip'],
      port: map['port'],
      username: map['username'],
      password: map['password'],
    );
  }

  toMap() {
    return {
      "ip": ip,
      "port": port,
      "username": username,
      "password": password,
    };
  }

  Future<void> connect() async {
    connection = FTPConnect(
      ip,
      port: port,
      user: username,
      pass: password,
    );
    await connection.connect();
  }
}
