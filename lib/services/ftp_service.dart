import 'dart:io';

import 'package:ftpconnect/ftpconnect.dart';
import 'package:ftp_client_app/models/ftp_server.dart';

class FTPService {
  FTPServer server;

  FTPService(this.server);

  @Deprecated("User listDirectory() instead")
  Future<List<FTPEntry>> dir() async {
    List<FTPEntry> dir = [];
    dir = await server.connection.listDirectoryContent();
    return dir;
  }

  Future<List<FTPEntry>> listDirectory(String path) async {
    server.connection.listCommand = ListCommand.NLST;
    await server.connection.changeDirectory(path);
    return await server.connection.listDirectoryContent();
  }

  // Method to connect to the FTP server
  Future<bool> connect() async {
    FTPConnect ftpClient = FTPConnect(
      server.ip,
      user: server.username,
      pass: server.password,
      port: server.port,
    );

    try {
      await ftpClient.connect();
      return true;
    } catch (e) {
      print('Failed to connect: $e');
      return false;
    }
  }

  // Method to upload a file
  Future<bool> uploadFile(String localFilePath, String remoteFilePath) async {
    FTPConnect ftpClient = FTPConnect(
      server.ip,
      user: server.username,
      pass: server.password,
      port: server.port,
    );
    try {
      await ftpClient.connect();
      await ftpClient.uploadFile(File(localFilePath));
      return true;
    } catch (e) {
      print('Failed to upload: $e');
      return false;
    } finally {
      ftpClient.disconnect();
    }
  }

  // Method to download a file
  Future<bool> downloadFile(String remoteFilePath, String localFilePath) async {
    FTPConnect ftpClient = FTPConnect(server.ip,
        user: server.username, pass: server.password, port: server.port);
    try {
      await ftpClient.connect();
      await ftpClient.downloadFile(remoteFilePath, File(localFilePath));
      return true;
    } catch (e) {
      print('Failed to download: $e');
      return false;
    } finally {
      ftpClient.disconnect();
    }
  }
}
