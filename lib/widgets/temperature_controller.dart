import 'package:counter_app/bloc/temperature_bloc.dart';
import 'package:counter_app/login/database/database.dart';
import 'package:counter_app/utils/app_colors.dart';
import 'package:counter_app/widgets/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemperatureController extends StatelessWidget {
  const TemperatureController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureCubit, double>(
      builder: (context, temp) {
        return Column(
          children: [
            SleekCircularSlider(
              initialValue: temp,
              min: 16,
              max: 30,
              appearance: CircularSliderAppearance(
                customWidths: CustomSliderWidths(
                  progressBarWidth: 12,
                  trackWidth: 12,
                ),
                customColors: CustomSliderColors(
                  progressBarColor: Colors.orange,
                  trackColor: Colors.grey.shade800,
                ),
                infoProperties: InfoProperties(
                  modifier: (double value) => '${value.toInt()} °C',
                  mainLabelStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              onChange: (value) {
                context.read<TemperatureCubit>().updateTemperature(value);
              },
              onChangeEnd: (value) async {
                await DBHelper().saveTemperature(value);
              },
            ),

            kheight20,
 CustomText(text: 'Remote Control',fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.lightText,),
 kheight20,
            // Slider
            Slider(
              value: temp,
              min: 16,
              max: 30,
              activeColor: AppColors.accent,
              onChanged: (value) {
                context.read<TemperatureCubit>().updateTemperature(value);
              },
              onChangeEnd: (value) async {
                await DBHelper().saveTemperature(value);
              },
            ),
               kheight20,
            CustomText(text: 'Dimensions',fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.lightText,)
          ],
        );
      },
    );
  }
}
