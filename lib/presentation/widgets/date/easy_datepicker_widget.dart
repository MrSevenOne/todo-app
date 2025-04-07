import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class EasyDatePickerWidget extends StatefulWidget {
  final Function onDateSelected;

  const EasyDatePickerWidget({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<EasyDatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.only(bottom: 8.0),
      child: EasyDateTimeLine(
        initialDate: selectedDate,
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
          });
          widget.onDateSelected(selectedDate);
        },
        activeColor: Theme.of(context).primaryColor,
        headerProps: const EasyHeaderProps(
          dateFormatter: DateFormatter.monthOnly(),
        ),
        dayProps: const EasyDayProps(
          height: 56.0,
          width: 56.0,
          dayStructure: DayStructure.dayNumDayStr,
          inactiveDayStyle: DayStyle(
            borderRadius: 8.0,
            dayNumStyle: TextStyle(
              fontSize: 18.0,

            ),
          ),
          activeDayStyle: DayStyle(
            dayNumStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
