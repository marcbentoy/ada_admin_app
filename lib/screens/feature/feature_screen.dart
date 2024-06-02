import 'package:ada_admin_app/screens/register_student/register_student_screen.dart';
import 'package:ada_admin_app/screens/view_records/view_records_screen.dart';
import 'package:ada_admin_app/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_filled_button.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ada logo
              Image.asset(
                "assets/images/logo_full.png",
                width: 72,
              ),

              const Spacer(),

              // view records option
              CustomFilledButton(
                click: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const ViewRecordsScreen(
                          studentId: 'all',
                        );
                      },
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                backgroundColor: klightblue,
                borderRadius: 8,
                child:
                    Image.asset("assets/images/view_records_illustration.png"),
              ),

              const SizedBox(
                height: 16,
              ),

              // register student option
              CustomFilledButton(
                click: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const RegisterStudentScreen();
                      },
                    ),
                  );
                },
                padding: EdgeInsets.zero,
                backgroundColor: klightgreen,
                borderRadius: 8,
                child: Image.asset(
                    "assets/images/register_student_illustration.png"),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
