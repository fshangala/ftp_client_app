import 'package:flutter/material.dart';
import 'package:ftp_client_app/viewmodels/file_explorer_viewmodel.dart';
import 'package:ftp_client_app/viewmodels/global_viewmodel.dart';
import 'package:provider/provider.dart';
import 'viewmodels/ftp_viewmodel.dart';
import 'views/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalViewmodel()),
        ChangeNotifierProvider(create: (_) => FTPViewModel()),
        ChangeNotifierProvider(create: (_) => FileExplorerViewmodel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
