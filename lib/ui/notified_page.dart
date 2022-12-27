import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifiedPage extends StatelessWidget {

  final String? label;

  const NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          onPressed: ()=> Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
          color: Get.isDarkMode ? Colors.white : Colors.grey,
        ),
        title: Text("Your Task",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📌 " + this.label.toString().split("|")[0],
              style: GoogleFonts.lato(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Text("📋 Note :",
              style: GoogleFonts.lato(
                fontSize: 16,
              ),),
            SizedBox(height: 5,),
            Text(this.label.toString().split("|")[1],
              style: GoogleFonts.lato(
                fontSize: 16,
              ),),
          ],
        ),
      ),
    );
  }
}
