import 'package:counter_app/login/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TemperatureCubit extends Cubit<double> {
  TemperatureCubit() : super(25.0);

  /// 🔥 Load last temperature from SQLite
  Future<void> loadSavedTemperature() async {
    final lastTemp = await DBHelper().getLastTemperature();

    if (lastTemp != null) {
      emit(lastTemp);
    } else {
      emit(25.0); // default temperature
    }
  }

  /// 🔥 Update temperature + Save to SQLite
  Future<void> updateTemperature(double value) async {
    emit(value);
    await DBHelper().saveTemperature(value);
  }

  /// 🔥 Optional: Reset temperature
  Future<void> resetTemperature() async {
    emit(25.0);
    await DBHelper().saveTemperature(25.0);
  }
}
