import 'package:flutter/material.dart';
import 'package:ftp_client_app/viewmodels/ftp_viewmodel.dart';
import 'package:provider/provider.dart';

class FileExplorerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileExplorerScreenState();
}

class _FileExplorerScreenState extends State<FileExplorerScreen> {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<FTPViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("File Explorer - ${viewModel.currentServer?.ip}"),
      ),
    );
  }
}
