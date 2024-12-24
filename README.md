# EasyCLIyt-dlpDownloader 🎥🎶

**EasyCLIyt-dlpDownloader** is a simple, command-line tool for downloading YouTube and other media files using [yt-dlp](https://github.com/yt-dlp/yt-dlp) and [ffmpeg](https://www.gyan.dev/ffmpeg/builds/) with a batch script interface. It provides an easy way to download videos, audio, and manage media files directly from the command line.

## Features ✨
- **🎯 Quick Download**: Download a single media file from a URL in the desired format (mp4, mp3, etc.).
- **📂 Batch Download**: Add multiple URLs to a file and download them all at once.
- **🎥 View and Play Files**: List media files in the folder and play them using `ffplay`.
- **⌨️ Keyboard Shortcuts**: View a list of useful `ffplay` keyboard shortcuts for playback control.

## Installation ⚙️

1. **Download or Update yt-dlp and ffmpeg**:
   - Double-click or run the _`installer or updater.bat`[Installer.bat](Installer.bat)_ file to download or update the latest versions of `yt-dlp` and `ffmpeg`.
   - Please remain patient while the download/update is in progress.
   - Once prompted with **'Download Completed.'**, press any key to close the window.

## How to Use the Downloader 🛠️

1. **Open the Downloader**: Double-click or open the _`cliytdlp.bat`[cliytdlp.bat](cliytdlp.bat)_ file to start the tool.
2. **Menu Options**: Upon opening, you'll be presented with the following options:

Depending on the option you choose, you can:

### 1. Quick Download a Single File 🚀
- You will be prompted to enter the file format and URL:   `Enter the file format and URL ([Format]-[URL], default format is mp4):`
- Example: `mp4-https://youtube.com/video_url`
- The tool will download the file in the specified format (e.g., `mp4`, `mp3`, etc.).

### 2. Add URLs to File and Download Them 📥
- You can add URLs to a file (`urls.txt`) one per line.
- The prompt will look like this:

- After adding URLs, the script will begin downloading all the files listed in `urls.txt`.

### 3. View Files in Folder and Play a File 🎧
- You will see a list of available media files (e.g., `.mp4`, `.mp3`) in the current folder:

- You can enter the filename of the media file to play (e.g., `video1.mp4`).

### 4. Show ffplay Keyboard Shortcuts ⌨️
- View a list of keyboard shortcuts for controlling playback in `ffplay`, such as:

### 5. Exit ❌
- Exit the program and close the command-line window.

## Contributing 🤝
If you'd like to contribute to this project, feel free to open an issue or submit a pull request. All contributions are welcome!

## License 📄
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
👨‍💻 **Made with ❤️ by github.com/DoctorRon64**
