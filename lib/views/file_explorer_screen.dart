import 'package:flutter/material.dart';
import 'package:ftp_client_app/viewmodels/file_explorer_viewmodel.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:provider/provider.dart';

class FileExplorerScreen extends StatefulWidget {
  const FileExplorerScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FileExplorerScreenState();
}

class _FileExplorerScreenState extends State<FileExplorerScreen> {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<FileExplorerViewmodel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("File Explorer - ${viewModel.currentServer?.ip}"),
      ),
      body: viewModel.loading
          ? Center(child: CircularProgressIndicator())
          : viewModel.entries.isEmpty
              ? Center(child: Text("No entries found."))
              : ListView.builder(
                  itemCount: viewModel.entries.length,
                  itemBuilder: (context, index) {
                    final entry = viewModel.entries[index];
                    return ListTile(
                      leading: entry.type == FTPEntryType.DIR
                          ? Icon(Icons.folder)
                          : Icon(Icons.insert_drive_file),
                      trailing: Row(
                        children: [
                          entry.type == FTPEntryType.DIR
                              ? IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    viewModel.changeDirectory(entry.name);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.download),
                                  onPressed: () {
                                    // Handle open action
                                  },
                                ),
                        ],
                      ),
                      title: Text(entry.name),
                      onTap: () {
                        if (entry.type == FTPEntryType.DIR) {
                          viewModel.changeDirectory(entry.name);
                        } else {
                          // Handle file click
                        }
                      },
                    );
                  },
                ),
    );
  }
}
