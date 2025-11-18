import 'package:counter_app/bloc/temperature_bloc.dart';
import 'package:counter_app/login/database/database.dart';
import 'package:counter_app/login/login.dart';
import 'package:counter_app/utils/app_colors.dart';
import 'package:counter_app/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/temperature_controller.dart'; // path may differ

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => TemperatureCubit()..loadSavedTemperature()),
    BlocProvider(create: (_) => PowerSavingCubit()..loadPowerSaving()),
  ],
  child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomText(
                  text: 'Temperature',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightText,
                ),
                kheight20,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TemperatureController(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  BlocConsumer<PowerSavingCubit,bool>(builder: (context,isEnabled){
                   return   SizedBox(
                      width: 110,
                      height: 150,
                      child: InkWell(
                        onTap: () {
                           context.read<PowerSavingCubit>().togglePowerSaving();
                        },
                        child: CustomCard(
                           color: isEnabled ? Colors.green : AppColors.card,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.energy_savings_leaf_outlined,
                                color: AppColors.dimText,
                              ),
                              kheight10,
                              CustomText(
                                text: 'Energy Save',
                                color: AppColors.dimText,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }, listener: (context, state) {
                   if (state == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Power Saving Enabled'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Power Saving Disabled'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
                  },),
                    SizedBox(
                      width: 110,
                      height: 150,
                      child: CustomCard(
                        color: AppColors.card,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.settings, color: AppColors.dimText),
                            kheight10,
                            CustomText(
                              text: 'Settings',
                              color: AppColors.dimText,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      height: 150,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: AppColors.card,
                                title: CustomText(text: 'Log Out!',color: AppColors.dimText,),
                                content: CustomText(
                                  text: 'Are you sure you want to exit',color: AppColors.dimText,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Login(),
                                        ),
                                      );
                                      final pref =
                                          await SharedPreferences.getInstance();
                                      pref.setBool('IsLogged', false);
                                    },
                                    child: CustomText(text: 'Yes',color: AppColors.lightText,),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: CustomText(text: 'No',color: AppColors.lightText,),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: CustomCard(
                          color: AppColors.card,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout, color: AppColors.dimText),
                              kheight10,
                              CustomText(
                                text: 'LogOut',
                                color: AppColors.dimText,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
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
