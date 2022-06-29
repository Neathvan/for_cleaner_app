import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/search_staff_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/ui/screen/booking_form_screen.dart';
import 'package:clean_app/ui/widget/component/app_bar_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ScheduleStaffScreen extends StatefulWidget {
  const ScheduleStaffScreen({Key? key, required this.name, required this.id}) : super(key: key);
  final String name;
  final int id;
  @override
  _ScheduleStaffScreenState createState() => _ScheduleStaffScreenState();
}

class _ScheduleStaffScreenState extends State<ScheduleStaffScreen> {

  @override
  void initState() {
    context.read<SearchStaffProvider>().viewScheduleList(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: "${widget.name}'s schedule",),
      body: Consumer<SearchStaffProvider>(
        builder: (_, provider, index) {
          return ListView.builder(
            itemCount: provider.scheduleList.data?.length,
            itemBuilder: (_, index) {
              return  cardStaffBuilder(
                  defaultColor.appColor,
                  provider.scheduleList.data![index].scheduleInfor!.date!,
                  provider.scheduleList.data![index].scheduleInfor!.times!.startTime!,
                  provider.scheduleList.data![index].scheduleInfor!.times!.endTime!,
                  provider.scheduleList.data![index].scheduleInfor!.timeId!,
                  provider.scheduleList.data![index].status!,
                  context);
            },
          );
        },
      )
    );
  }

  Widget cardStaffBuilder(bgColor,String date,  String startTime, String endTime, int timeId, String status,  BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: status == 'avaiable' ? () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => BookingFormScreen(date: date, start: startTime, end: endTime, id: widget.id, timeId: timeId)
          ),
          );
        } : null,
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: bgColor,
                width: 2
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading:  CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: Icon(Icons.timer),
                  ),
                ),
                title: Text(date),
                subtitle: Text("${startTime} - ${endTime}"),
                trailing: status == 'avaiable' ? Icon(Icons.arrow_forward_ios_rounded) : Text(status.toUpperCase(),style:  TextStyle( color: Colors.red, fontSize: 10),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
