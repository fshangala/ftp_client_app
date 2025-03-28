class FTPServer {
  String ip;
  int port;
  String username;
  String password;

  FTPServer({
    required this.ip,
    this.port = 21, // default FTP port
    this.username = 'anonymous',
    this.password = '',
  });
}
