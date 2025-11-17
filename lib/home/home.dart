import 'package:counter_app/bloc/temperature_bloc.dart';
import 'package:counter_app/login/database/database.dart';
import 'package:counter_app/utils/app_colors.dart';
import 'package:counter_app/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/temperature_controller.dart'; // path may differ

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TemperatureCubit()..loadSavedTemperature(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomText(text: 'Temperature',fontSize: 30,fontWeight: FontWeight.bold,color: AppColors.lightText,),
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
                    SizedBox(
                      width: 110,
                      height: 150,
                      child: CustomCard(
                        color: AppColors.card,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thunderstorm),
                          kheight10,
                          CustomText(text: 'Energy Save',color: AppColors.dimText,fontWeight: FontWeight.bold,)
                        ],
                      ),)),
                       SizedBox(
                      width: 110,
                      height: 150,
                      child: CustomCard(
                        color: AppColors.card,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thunderstorm),
                          kheight10,
                          CustomText(text: 'Settings',color: AppColors.dimText,fontWeight: FontWeight.bold,)
                        ],
                      ),)),
                       SizedBox(
                      width: 110,
                      height: 150,
                      child: CustomCard(
                        color: AppColors.card,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout),
                          kheight10,
                          CustomText(text: 'LogOut',color: AppColors.dimText,fontWeight: FontWeight.bold,)
                        ],
                      ),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
