import '../../utils/imports.dart';

class DownloadIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DownloadIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.download,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Download',
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ShareIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ShareIconButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Icon(
            Icons.share,
            color: Colors.blue[900],
            size: 40,
          ),
        ),
        Text(
          'Share',
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

