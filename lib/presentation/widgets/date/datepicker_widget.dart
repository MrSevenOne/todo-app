import 'package:flutter/material.dart';

class DatePickerWidget {
  /// Sana va vaqtni tanlash va `DateTime` sifatida qaytarish
  static Future<DateTime?> selectDeadline(BuildContext context) async {
    // Sana tanlash
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (selectedDate == null) return null; // Agar sana tanlanmasa

    // Vaqt tanlash
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime == null) return null; // Agar vaqt tanlanmasa

    // Sana va vaqtni birlashtirish
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }
}
