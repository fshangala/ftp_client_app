import 'package:flutter/material.dart';
import 'package:ftp_client_app/models/directory_entry_type.dart';

class DirectoryEntry {
  String name;
  late IconData icon;
  late DirectoryEntryType type;

  DirectoryEntry({required this.name}) {
    final parts = name.split(".");
    if (parts.length == 1) {
      type = DirectoryEntryType.directory;
    } else {
      type = DirectoryEntryType.file;
    }
    switch (parts.last) {
      case "zip":
        icon = Icons.folder_zip;
        break;
      case "mp4":
        icon = Icons.video_file;
        break;
      case "mp3":
        icon = Icons.audio_file;
        break;
      default:
        icon = Icons.file_open;
        break;
    }
  }

  @override
  String toString() {
    return name;
  }
}
