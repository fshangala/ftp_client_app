import 'package:flutter/material.dart';
import '../models/ftp_server.dart';
import '../services/ftp_service.dart';

class FTPViewModel extends ChangeNotifier {
  List<FTPServer> _servers = [];
  bool _isTransferring = false;
  double _progress = 0.0;

  List<FTPServer> get servers => _servers;
  bool get isTransferring => _isTransferring;
  double get progress => _progress;

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
