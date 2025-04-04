import 'package:flutter/material.dart';
import 'package:ftp_client_app/models/directory_entry.dart';
import 'package:ftp_client_app/models/ftp_server.dart';
import 'package:ftp_client_app/services/ftp_service.dart';
import 'package:logger/logger.dart' as logger;

class FileExplorerViewmodel extends ChangeNotifier {
  FTPServer? _currentServer;
  List<DirectoryEntry> _entries = [];
  List<Exception> _exceptions = [];
  String _currentDirectory = '.';
  List<String> _currentPath = [''];
  bool _loading = false;

  FTPServer? get currentServer => _currentServer;
  List<DirectoryEntry> get entries => _entries;
  List<Exception> get exceptions => _exceptions;
  String get currentDirectory => _currentDirectory;
  List<String> get currentPath => _currentPath;
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

  Future<void> openDirectory(String name) async {
    _currentPath.add(name);
    notifyListeners();

    listDirectory();
  }

  Future<void> goBack() async {
    if (_currentPath.length > 1) {
      _currentPath.removeLast();
      notifyListeners();

      listDirectory();
    }
  }

  Future<void> goHome() async {
    _currentPath = [''];
    notifyListeners();

    listDirectory();
  }

  void refresh() {
    _loading = true;
    notifyListeners();

    listDirectory();
  }

  @Deprecated("use path related methods instead!")
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
        var thePath = "/";
        if (_currentPath.length > 1) {
          thePath = _currentPath.join('/');
        }
        _entries = await ftpService.listDirectory(thePath);
        logger.Logger().i(thePath);
      } on Exception catch (e, trace) {
        logger.Logger().e(
          "Failed to list directory: $_currentPath",
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
