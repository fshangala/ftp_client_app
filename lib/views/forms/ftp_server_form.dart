import 'package:flutter/material.dart';
import 'package:ftp_client_app/models/ftp_server.dart';

class FtpServerForm extends StatefulWidget {
  final void Function(FTPServer ftpServer) onSave;
  const FtpServerForm({super.key, required this.onSave});

  @override
  State<StatefulWidget> createState() => _FtpServerForm();
}

class _FtpServerForm extends State<FtpServerForm> {
  var ipController = TextEditingController(text: '192.168.0.1');
  var portController = TextEditingController(text: '21');
  var usernameController = TextEditingController(text: 'anonymous');
  var passwordController = TextEditingController(text: '');

  void save() {
    var ftpServer = FTPServer(
      ip: ipController.text,
      port: int.parse(portController.text),
      username: usernameController.text,
      password: passwordController.text,
    );
    widget.onSave(ftpServer);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        spacing: 16.0,
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.network_wifi_rounded),
              labelText: "IP Adress",
            ),
            controller: ipController,
            keyboardType: TextInputType.text,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_tree),
              labelText: "Port",
            ),
            controller: portController,
            keyboardType: TextInputType.number,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: "Username",
            ),
            controller: usernameController,
            keyboardType: TextInputType.name,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.password),
              labelText: "Password",
            ),
            controller: passwordController,
            keyboardType: TextInputType.text,
          ),
          TextButton.icon(
            onPressed: () => save(),
            label: Text("Save"),
            icon: Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
