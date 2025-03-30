import 'package:flutter/material.dart';
import 'package:ftp_client_app/viewmodels/ftp_viewmodel.dart';
import 'package:ftp_client_app/views/forms/ftp_server_form.dart';
import 'package:provider/provider.dart';

class AddFtpServerScreen extends StatelessWidget {
  const AddFtpServerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FTPViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FTP Server"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: FtpServerForm(onSave: (ftpServer) {
          viewModel.addServer(ftpServer);
          Navigator.pop(context);
        }),
      ),
    );
  }
}
