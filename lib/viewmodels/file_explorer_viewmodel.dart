import 'package:flutter/material.dart';
import 'package:ftp_client_app/models/ftp_server.dart';
import 'package:ftp_client_app/services/ftp_service.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:logger/logger.dart' as logger;

class FileExplorerViewmodel extends ChangeNotifier {
  FTPServer? _currentServer;
  List<FTPEntry> _entries = [];
  List<Exception> _exceptions = [];
  String _currentDirectory = '.';
  bool _loading = false;

  FTPServer? get currentServer => _currentServer;
  List<FTPEntry> get entries => _entries;
  List<Exception> get exceptions => _exceptions;
  String get currentDirectory => _currentDirectory;
  bool get loading => _loading;

  Future<void> setCurrentServer(FTPServer server) async {
    _loading = true;
    notifyListeners();

    try {
      await server.connect();
      _currentServer = server;
    } on Exception catch (e, trace) {
      logger.Logger().e(
        "Failed to connect to server: ${server.ip}:${server.port}",
        error: e,
        stackTrace: trace,
      );
      _exceptions.add(e);
    }

    _loading = false;
    notifyListeners();

    listDirectory();
  }

  Future<void> changeDirectory(String newDirectory) async {
    _currentDirectory = newDirectory;
    notifyListeners();

    listDirectory();
  }

  Future<void> listDirectory() async {
    if (_currentServer == null) {
      return;
    } else {
      final ftpService = FTPService(_currentServer!);
      _loading = true;
      notifyListeners();

      try {
        _entries = await ftpService.listDirectory(_currentDirectory);
      } on Exception catch (e, trace) {
        logger.Logger().e(
          "Failed to list directory: $_currentDirectory",
          error: e,
          stackTrace: trace,
        );
        _exceptions.add(e);
      }

      _loading = false;
      notifyListeners();
    }
  }
}
