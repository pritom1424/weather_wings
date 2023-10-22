import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://www.vecteezy.com');
    var screenSize = MediaQuery.of(context).size;
    Future<void> _launchUrl() async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Container(
      width: screenSize.width * 0.6,
      height: screenSize.height * 0.05,
      color: Colors.transparent, // Set your preferred background color
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Assets provided in part by",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: _launchUrl,
              child: const Text(
                "Vecteezy", // Replace with the website name
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
