import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/ftp_viewmodel.dart';
import 'file_transfer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FTP Client')),
      body: Consumer<FTPViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () => viewModel.detectServers(),
                child: Text('Detect FTP Servers'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.servers.length,
                  itemBuilder: (context, index) {
                    final server = viewModel.servers[index];
                    return ListTile(
                      title: Text(server.ip),
                      subtitle: Text('Username: ${server.username}'),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FileTransferScreen(server),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
