import 'package:ada_admin_app/screens/login/custom_text_field.dart';
import 'package:ada_admin_app/shared/constants.dart';
import 'package:ada_admin_app/shared/shared.dart';
import 'package:ada_admin_app/shared/utils.dart';
import 'package:ada_admin_app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';

class RegisterStudentScreen extends StatefulWidget {
  const RegisterStudentScreen({super.key});

  @override
  State<RegisterStudentScreen> createState() => _RegisterStudentScreenState();
}

class _RegisterStudentScreenState extends State<RegisterStudentScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController schoolIdCtrlr = TextEditingController();
    TextEditingController nameCtrlr = TextEditingController();
    TextEditingController sectionCtrlr = TextEditingController();
    TextEditingController courseCtrlr = TextEditingController();
    TextEditingController collegeCtrlr = TextEditingController();
    TextEditingController rfidCtrlr = TextEditingController();

    return Scaffold(
      backgroundColor: kwhite,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "School ID number",
                style: GoogleFonts.inter(),
              ),
              CustomTextField(controller: schoolIdCtrlr, hintText: "ID number"),
              const SizedBox(height: 16),
              Text(
                "Student name",
                style: GoogleFonts.inter(),
              ),
              CustomTextField(controller: nameCtrlr, hintText: "Name"),
              const SizedBox(height: 16),
              Text(
                "College (COE, CEAS, COT, CME)",
                style: GoogleFonts.inter(),
              ),
              CustomTextField(controller: collegeCtrlr, hintText: "College"),
              const SizedBox(height: 16),
              Text(
                "Course",
                style: GoogleFonts.inter(),
              ),
              CustomTextField(controller: courseCtrlr, hintText: "Course"),
              const SizedBox(height: 16),
              Text(
                "Class section",
                style: GoogleFonts.inter(),
              ),
              CustomTextField(controller: sectionCtrlr, hintText: "Section"),
              const SizedBox(height: 16),
              Text(
                "RFID Value",
                style: GoogleFonts.inter(),
              ),
              CustomTextField(controller: rfidCtrlr, hintText: "RFID"),
              const SizedBox(height: 24),
              CustomFilledButton(
                width: double.infinity,
                click: () async {
                  final pbUrl = await getPbUrl();
                  final pb = PocketBase(pbUrl);

                  debugPrint("Current pb auth token: ${pb.authStore.token}");
                  debugPrint("new created Current pb auth token: $authToken");

                  try {
                    // example create body
                    final body = <String, dynamic>{
                      "name": nameCtrlr.text,
                      "college": collegeCtrlr.text,
                      "section": sectionCtrlr.text,
                      "rfid": rfidCtrlr.text,
                      "schoolId": schoolIdCtrlr.text,
                    };

                    final _ = await pb.collection('students').create(
                      body: body,
                      headers: {
                        'Authorization': 'Bearer $authToken',
                      },
                    );

                    // show success snackbar
                    showSuccessSB();

                    // clear text fields
                    schoolIdCtrlr.clear();
                    nameCtrlr.clear();
                    collegeCtrlr.clear();
                    courseCtrlr.clear();
                    sectionCtrlr.clear();
                    rfidCtrlr.clear();
                  } catch (e) {
                    debugPrint(e.toString());

                    showInvalidSB();
                  }
                },
                child: Text(
                  "REGISTER",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: klightgreen,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kdarkgreen,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Register Student",
          style: GoogleFonts.inter(
            color: kdarkgreen,
            letterSpacing: -0.8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void showSuccessSB() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kgreen,
        content: const Text("Successfully registered"),
      ),
    );
  }

  void showInvalidSB() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kred,
        content: const Text("Invalid student data"),
      ),
    );
  }
}
