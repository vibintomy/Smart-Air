import 'package:counter_app/home/home.dart';
import 'package:counter_app/login/database/database.dart';
import 'package:counter_app/login/signup.dart';
import 'package:counter_app/utils/app_colors.dart';
import 'package:counter_app/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Login({super.key});
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
                  text: 'Welcome Back! ',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightText,
                ),
                kheight10,
                CustomText(
                  text: 'Login to continue',
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
                          controller: passController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Add Password';
                            } else if (value.length <= 2) {
                              return 'Password is too short';
                            }
                            return null;
                          },
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
                  label: 'LOGIN',
                  labelColor: AppColors.lightText,
                  onPressed: () async {
                    final id = idController.text.trim();
                    final password = passController.text.trim();
                    final db = await DBHelper().database;
                    final pref = await SharedPreferences.getInstance();

                    if (formkey.currentState!.validate()) {
                      List<Map<String, dynamic>> results = await db.query(
                        'users',
                        where: 'userId = ? AND password = ?',
                        whereArgs: [id, password],
                      );
                      if (results.isNotEmpty) {
                        pref.setBool('IsLogged', true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: CustomText(
                              text: 'Successfully Logged In',
                              fontSize: 12,
                            ),
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      }
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
                      text: "Don't have an account?",
                      color: AppColors.lightText,
                    ),
                    kwidth10,
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: CustomText(
                        text: 'Sign Up',
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
