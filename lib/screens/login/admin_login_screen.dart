import 'package:ada_admin_app/screens/feature/feature_screen.dart';
import 'package:ada_admin_app/screens/login/custom_text_field.dart';
import 'package:ada_admin_app/shared/constants.dart';
import 'package:ada_admin_app/shared/shared.dart';
import 'package:ada_admin_app/shared/utils.dart';
import 'package:ada_admin_app/widgets/custom_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController pbUrlCtrlr = TextEditingController();
  TextEditingController emailCtrlr = TextEditingController();
  TextEditingController passwdCtrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(),
            // logo
            Image.asset("assets/images/logo_full.png"),
            const SizedBox(height: 24),

            Text(
              "Admin Login",
              style: GoogleFonts.inter(),
            ),

            const SizedBox(height: 64),

            // email entry
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: GoogleFonts.inter(),
                ),
                const SizedBox(height: 4),
                CustomTextField(
                  controller: emailCtrlr,
                  hintText: "email",
                ),
              ],
            ),

            const SizedBox(height: 16),

            // password entry
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: GoogleFonts.inter(),
                ),
                const SizedBox(height: 4),
                CustomTextField(
                  controller: passwdCtrlr,
                  hintText: "password",
                  obscure: true,
                ),
              ],
            ),

            const SizedBox(height: 32),

            // login button
            CustomFilledButton(
              click: () async {
                final pbUrl = await getPbUrl();
                final pb = PocketBase(pbUrl);

                try {
                  final _ = await pb.collection('users').authWithPassword(
                        emailCtrlr.text,
                        passwdCtrlr.text,
                      );

                  setState(() {
                    authToken = pb.authStore.token;
                  });

                  debugPrint(pb.authStore.isValid.toString());
                  debugPrint(pb.authStore.token);
                  debugPrint(pb.authStore.model.id);
                } catch (e) {
                  debugPrint(e.toString());
                }

                if (pb.authStore.isValid) {
                  popLoginScreen();
                  navigateToFeatureScreen();
                  showSuccessSB();
                } else {
                  showInvalidSB();
                }
              },
              width: double.infinity,
              child: Text(
                "LOGIN",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Spacer(),
            TextButton(
              onPressed: () async {
                // get pbUrl
                String pbUrl = await getPbUrl();
                pbUrlCtrlr.text = pbUrl;

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
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold),
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
                                  await prefs.setString(
                                      "pbUrl", pbUrlCtrlr.text);

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
              },
              child: Text(
                "pb url",
                style: GoogleFonts.inter(
                  color: kblue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void popLoginScreen() {
    Navigator.of(context).pop();
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
}
