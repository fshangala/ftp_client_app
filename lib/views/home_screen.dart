import 'package:flutter/material.dart';
import 'package:ftp_client_app/views/add_ftp_server_screen.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () => viewModel.detectServers(),
                    label: Text("Detect FTP Servers"),
                    icon: Icon(Icons.perm_scan_wifi),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddFtpServerScreen(),
                      ),
                    ),
                    label: Text("Add FTP Server"),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              if (viewModel.loading)
                CircularProgressIndicator()
              else if (viewModel.servers.isEmpty)
                Text("No FTP servers.")
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.servers.length,
                    itemBuilder: (context, index) {
                      final server = viewModel.servers[index];
                      return ListTile(
                        title: Text(server.ip),
                        subtitle: Text('Username: ${server.username}'),
                        onTap: () async {
                          await viewModel.selectServer(server);
                        },
                      );
                    },
                  ),
                ),
              if (viewModel.currentServer != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Connected to ${viewModel.currentServer!.ip}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
