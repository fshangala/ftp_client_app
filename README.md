# FTP Client App

### 1. **Automatic Server Detection**
   - **Networking**: We can scan the local network for FTP servers using a library like `dart:io` for networking, and `ftpconnect` to test connections to port 21 (the default FTP port).

### 2. **UI Components**
   - **Server List**: Display detected servers in a `ListView`. Each item will show basic details like IP address and hostname.
   - **Server Details**: Once a user selects a server, the app will show input fields for FTP credentials (username and password). If anonymous access is allowed, these fields will be optional.
   - **Transfer Screen**: After selecting a file, there will be a progress bar while transferring. We can use a `LinearProgressIndicator` to show the progress.

### 3. **File Transfers**
   - **Single File Transfer**: The app will allow users to select a single file to transfer at a time. We can use the `ftpconnect` library to handle uploading/downloading.
   - **Progress Bar**: During the transfer, the app will listen to progress updates (like percentage) and update the progress bar accordingly.

### 4. **Local Storage (Saved Servers)**
   - **SharedPreferences**: We'll use the `shared_preferences` package to save the details of frequently used servers. This will include the IP, port, username, and password (if applicable).
   - **Edit/Remove Saved Servers**: Users will be able to modify or delete saved servers from the list.

### 5. **Error Handling and Notifications**
   - **Connection Errors**: If a server can't be reached or credentials are incorrect, the app will show an in-app error message.
   - **Transfer Errors**: If something goes wrong during file transfer, an error message will be displayed, and the transfer will be aborted.

### 6. **Manual Refresh**
   - **Scan Button**: We’ll include a button to manually refresh and scan the network for FTP servers in case any servers were missed.

### 7. **Flutter Specifics**
   - **Responsive UI for TV**: Ensure that the app’s UI is optimized for a TV interface, which means large buttons, clear text, and easy navigation (possibly using the D-pad on a remote).