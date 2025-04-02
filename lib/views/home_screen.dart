import 'package:flutter/material.dart';
import 'package:ftp_client_app/viewmodels/file_explorer_viewmodel.dart';
import 'package:ftp_client_app/views/add_ftp_server_screen.dart';
import 'package:ftp_client_app/views/file_explorer_screen.dart';
import 'package:provider/provider.dart';
import '../viewmodels/ftp_viewmodel.dart';
import 'file_transfer_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var fileExplorerViewmodel = Provider.of<FileExplorerViewmodel>(
      context,
      listen: true,
    );
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
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                await viewModel.removeServer(index);
                              },
                            ),
                            fileExplorerViewmodel.currentServer == null
                                ? IconButton(
                                    icon: Icon(Icons.connect_without_contact),
                                    onPressed: () async {
                                      await fileExplorerViewmodel
                                          .setCurrentServer(server);
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(Icons.folder_open),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FileExplorerScreen(),
                                        ),
                                      );
                                    },
                                  ),
                          ],
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
