import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import '../models/ftp_server.dart';
import '../services/ftp_service.dart';

class FTPViewModel extends ChangeNotifier {
  FTPServer? _currentServer;
  List<FTPServer> _servers = [];
  bool _isTransferring = false;
  bool _loading = false;
  double _progress = 0.0;

  List<FTPServer> get servers => _servers;
  bool get isTransferring => _isTransferring;
  bool get loading => _loading;
  double get progress => _progress;
  FTPServer? get currentServer => _currentServer;

  void addServer(FTPServer ftpServer) {
    _servers.add(ftpServer);
    notifyListeners();
  }

  Future<void> selectServer(FTPServer ftpServer) async {
    _loading = true;
    notifyListeners();
    await ftpServer.connect();
    _currentServer = ftpServer;
    _loading = false;
    notifyListeners();
  }

  Future<List<FTPEntry>> listDirectory(FTPServer ftpServer) async {
    var ftpService = FTPService(ftpServer);
    _loading = true;
    notifyListeners();
    var dir = await ftpService.dir();
    _loading = false;
    notifyListeners();
    return dir;
  }

  void detectServers() {
    // TODO: Implement server detection logic (scan local network)
    _servers = [
      FTPServer(ip: '192.168.0.101', username: 'user', password: 'pass'),
      FTPServer(ip: '192.168.0.102', username: 'user', password: 'pass'),
    ];
    notifyListeners();
  }

  Future<void> transferFile(
      FTPServer server, String localPath, String remotePath) async {
    _isTransferring = true;
    _progress = 0.0;
    notifyListeners();

    FTPService ftpService = FTPService(server);
    bool success = await ftpService.uploadFile(localPath, remotePath);

    _isTransferring = false;
    _progress = success ? 1.0 : 0.0;
    notifyListeners();
  }
}
