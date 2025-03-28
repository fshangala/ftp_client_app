import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ftp_server.dart';
import '../viewmodels/ftp_viewmodel.dart';

class FileTransferScreen extends StatelessWidget {
  final FTPServer server;

  FileTransferScreen(this.server);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FTPViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Transfer File')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Connected to ${server.ip}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => viewModel.transferFile(
                server, '/path/to/local/file.txt', '/path/to/remote/file.txt'),
            child: Text('Upload File'),
          ),
          if (viewModel.isTransferring)
            Column(
              children: [
                SizedBox(height: 20),
                LinearProgressIndicator(value: viewModel.progress),
              ],
            ),
        ],
      ),
    );
  }
}
