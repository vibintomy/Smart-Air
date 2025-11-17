import 'package:counter_app/login/database/database.dart';
import 'package:counter_app/login/login.dart';
import 'package:counter_app/utils/app_colors.dart';
import 'package:counter_app/widgets/app_widgets.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final TextEditingController idController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Create an Account! ',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightText,
                ),
                kheight10,
                CustomText(
                  text: 'Sign Up to continue',
                  fontSize: 20,
                  color: AppColors.lightText,
                ),
                kheight20,
                Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    color: AppColors.formFieldBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                          label: 'ID',
                          validator: (value) {
                            if (value == null) {
                              return 'Add an proper ID';
                            } else if (value.isEmpty) {
                              return 'Add ID';
                            }
                            return null;
                          },
                          controller: idController,
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.lightText,
                          ),
                        ),
                        Divider(height: 1, color: AppColors.secondaryCard),
                        CustomTextField(
                          label: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Add Password';
                            } else if (value.length <= 2) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          controller: passController,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColors.lightText,
                          ),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: AppColors.lightText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                kheight20,
                CustomButton(
                  backgroundColor: AppColors.accent,
                  label: 'SIGN UP',
                  labelColor: AppColors.lightText,
                  onPressed: () async {
                    final id = idController.text.trim();
                    final password = passController.text.trim();
                    if (formkey.currentState!.validate()) {
                      final db = DBHelper();
                      db.insertUser(id, password);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }
                  },
                ),
                kheight20,
                Divider(height: 1, color: AppColors.secondaryCard),
                kheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Already have an account?",
                      color: AppColors.lightText,
                    ),
                    kwidth10,
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: CustomText(
                        text: 'LogIn',
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
