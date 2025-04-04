import 'package:flutter_test/flutter_test.dart';
import 'package:ftp_client_app/services/ftp_service.dart';
import 'package:ftp_client_app/models/ftp_server.dart';
import 'package:logger/logger.dart' as logger;

void main() {
  group('FTPService', () {
    test('should connect to the FTP server successfully', () async {
      FTPServer server = FTPServer(ip: '192.168.100.100', port: 21);
      FTPService ftpService = FTPService(server);

      bool connected = await ftpService.connect();
      expect(connected, isTrue);
    });

    test('should fail to connect with incorrect credentials', () async {
      FTPServer server = FTPServer(
        ip: '192.168.100.12',
        username: 'wrongUser',
        password: 'wrongPass',
        port: 2121,
      );
      FTPService ftpService = FTPService(server);

      bool connected = await ftpService.connect();
      expect(connected, isFalse);
    });

    test('should upload a file successfully', () async {
      FTPServer server = FTPServer(ip: '192.168.100.12', port: 2121);
      FTPService ftpService = FTPService(server);

      bool uploaded = await ftpService.uploadFile(
          'c:\\Users\\fshan\\Projects\\ftp_client_app\\test\\test.txt', '/');
      expect(uploaded, isTrue);
    });

    test('should download a file successfully', () async {
      FTPServer server = FTPServer(ip: '192.168.100.12', port: 2121);
      FTPService ftpService = FTPService(server);

      bool downloaded = await ftpService.downloadFile(
          '/test.txt', 'c:\\Users\\fshan\\Projects\\ftp_client_app\\test.txt');
      expect(downloaded, isTrue);
    });

    test('list directory content', () async {
      FTPServer server = FTPServer(ip: 'localhost', port: 21);
      await server.connect();
      FTPService ftpService = FTPService(server);

      final content = await ftpService.listDirectory('.');
      logger.Logger().i(content);
    });
  });
}
