import 'package:ada_admin_app/screens/feature/feature_screen.dart';
import 'package:ada_admin_app/screens/login/admin_login_screen.dart';
import 'package:ada_admin_app/screens/view_records/view_records_screen.dart';
import 'package:ada_admin_app/shared/constants.dart';
import 'package:ada_admin_app/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/custom_filled_button.dart';
import 'custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailCtrlr = TextEditingController();
  TextEditingController passwdCtrlr = TextEditingController();
  TextEditingController pbUrlCtrlr = TextEditingController();

  TextEditingController schoolIdCtrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            // logo
            Image.asset("assets/images/logo_full.png"),
            const SizedBox(height: 24),

            // sub headline
            Text(
              "Student App",
              style: GoogleFonts.inter(),
            ),

            const SizedBox(height: 64),

            // email entry
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Student ID",
                  style: GoogleFonts.inter(),
                ),
                const SizedBox(height: 4),
                CustomTextField(
                  controller: schoolIdCtrlr,
                  hintText: "school id",
                ),
              ],
            ),

            const SizedBox(height: 32),

            // view records button
            CustomFilledButton(
              click: () async {
                final pbUrl = await getPbUrl();
                final pb = PocketBase(pbUrl);
                try {
                  final response = await pb.collection('students').getList(
                        filter: 'schoolId = "${schoolIdCtrlr.text}"',
                      );

                  debugPrint(response.toString());

                  if (response.items.isEmpty) {
                    showInvalidSB();
                  }

                  navigateToViewRecordsScreen(response.items.first.id);
                  showSuccessSB();
                } catch (e) {
                  debugPrint(e.toString());
                  showInvalidSB();
                }
              },
              width: double.infinity,
              child: Text(
                "View Records",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            Text(
              "or",
              style: GoogleFonts.inter(),
            ),

            TextButton(
              onPressed: () async {
                navigateToAdminLoginScreen();
              },
              child: Text(
                "Login as admin",
                style: GoogleFonts.inter(
                  color: kblue,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void showSuccessSB() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kgreen,
        content: const Text("Logged in"),
      ),
    );
  }

  void showInvalidSB() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kred,
        content: const Text("Invalid credentials"),
      ),
    );
  }

  void navigateToFeatureScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const FeatureScreen();
        },
      ),
    );
  }

  void popLoginScreen() {
    Navigator.of(context).pop();
  }

  void navigateToViewRecordsScreen(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ViewRecordsScreen(studentId: id);
        },
      ),
    );
  }

  void navigateToAdminLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const AdminLoginScreen();
        },
      ),
    );
  }

  void promptChangePbUrl() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: kwhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width < 400
                  ? MediaQuery.of(context).size.width - 24
                  : 400,
              height: 200,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // headline
                  Text(
                    "Update Pocketbase URL",
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),

                  // text field
                  CustomTextField(
                    controller: pbUrlCtrlr,
                    hintText: "new pb url",
                  ),

                  // save button
                  CustomFilledButton(
                    width: double.infinity,
                    click: () async {
                      // update shared prefs
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString("pbUrl", pbUrlCtrlr.text);

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "SAVE URL",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
