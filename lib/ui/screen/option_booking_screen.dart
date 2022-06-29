import 'package:clean_app/ui/screen/employee_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../widget/component/app_bar_widget.dart';

class OptionBookingScreen extends StatelessWidget {
  final String nameBooking;
  const OptionBookingScreen({Key? key,required this.nameBooking}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: nameBooking,),
      body: DateTimePicker(nameBooking: nameBooking,),
    );
  }
}

class DateTimePicker extends StatefulWidget {
  final String nameBooking;

  const DateTimePicker({Key? key,required this.nameBooking}) : super(key: key);
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  String _startDate = "Not set";
  String _toDate = "Not set";
  var weekDay;
  var firstDayOfWeek;
  DateTime currentDate = DateTime.now();
  late int pickDay, pickMonth, pickYear;

  @override
  void initState() {
    super.initState();

    pickDay = 0;
    pickMonth = 0;
    pickYear = 0;
  }


  Future search(start, end ) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmployeeListScreen(screenName: widget.nameBooking, startDate: _startDate, endDate: _toDate,)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("City/Province"),
          optionProvince(),
          Text("From"),
          startDate(context),
          Text("To"),
          endDate(),
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              alignment: Alignment.topCenter,
              child: CupertinoButton(
                color: _startDate == 'Not set' || _toDate == "Not set" ? Colors.grey : Colors.red,
                onPressed: _startDate == 'Not set' || _toDate == "Not set" ? null :  () {

                  /// search ing
                  search(_startDate, _toDate);
                  },
                child: const Text('Next'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionProvince() {
    // ignore: deprecated_member_use
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(5.0)),
        // elevation: 4.0,
        onPressed: null,
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 18.0,
                        ),
                        Text("Phnom Penh",),
                      ],
                    ),
                  )
                ],
              ),
              Text(" Change"),
            ],
          ),
        ),
        // color: Colors.white,
      ),
    );
  }

  Widget startDate(BuildContext context) {
    // ignore: deprecated_member_use
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(5.0)),
        // elevation: 4.0,
        onPressed: () {
          DatePicker.showDatePicker(context,
              theme: DatePickerTheme(
                containerHeight: 210.0,
              ),
              showTitleActions: true,
              minTime: DateTime.now(),
              maxTime: DateTime(currentDate.year, currentDate.month, currentDate.day+3),
              onConfirm: (date) {
                print('confirm $date');
                setState(() {
                  pickDay = date.day;
                  pickMonth = date.month;
                  pickYear = date.year;
                });

                _startDate = '$pickYear - $pickMonth - $pickDay';
              },
              locale: LocaleType.en);
        },
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: 18.0,
                        ),
                        Text(" $_startDate",),
                      ],
                    ),
                  )
                ],
              ),
              Text("  Change"),
            ],
          ),
        ),
        // color: Colors.white,
      ),
    );
  }

  Widget endDate() {
    // ignore: deprecated_member_use
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(5.0)),
        // elevation: 4.0,
        onPressed: () {
          DatePicker.showDatePicker(context,
              theme: DatePickerTheme(
                containerHeight: 210.0,
              ),
              showTitleActions: true,
              minTime: pickDay == 0 ? DateTime.now() : DateTime(pickYear, pickMonth, pickDay),
              maxTime: pickDay == 0 ? DateTime(currentDate.year, currentDate.month, currentDate.day+3) : DateTime(pickYear, pickMonth, pickDay+(3-(pickDay-currentDate.day))),
              onConfirm: (date) {
                _toDate = '${date.year} - ${date.month} - ${date.day}';
                setState(() {});
              },
              currentTime: DateTime.now(),
              locale: LocaleType.en);
        },
        child: Container(
          alignment: Alignment.center,
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          size: 18.0,
                        ),
                        Text(
                          " $_toDate",
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                "  Change",
              ),
            ],
          ),
        ),
        // color: Colors.white,
      ),
    );
  }
}

