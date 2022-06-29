import 'package:flutter/material.dart';
import 'package:clean_app/bloc/search_staff_provider.dart';
import 'package:clean_app/bloc/staff_provider.dart';
import 'package:clean_app/model/search_staff_model.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/ui/widget/component/app_bar_widget.dart';
import 'package:provider/provider.dart';

import '../widget/employee_item_card.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key, required this.screenName, required this.startDate, required this.endDate,}): super(key: key);
  final String screenName;
  final String startDate, endDate;

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {

  @override
  void initState() {
    super.initState();
    context.read<SearchStaffProvider>().searchStaffByStartEndDate(widget.startDate, widget.endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.screenName,),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SearchStaffProvider>().searchStaffByStartEndDate(widget.startDate, widget.endDate);
        },
        child: Consumer<SearchStaffProvider>(
          builder: (context, provider, child) {
            if( provider.staffListResult.status == ApiStatus.loaded ) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: provider.staffListResult.data?.length,
                  itemBuilder: (_, index) {
                    return BuildItemEmployeeListView(
                      date: provider.staffListResult.data![index].date.toString(),
                      startTime: provider.staffListResult.data![index].image!.startTime.toString() ,
                      endTime: provider.staffListResult.data![index].image!.endTime.toString(),
                      staffInfoList: provider.staffListResult.data![index].staffInfo,
                      timeId:  provider.staffListResult.data![index].timeId!,
                    );
                  }
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}


class BuildItemEmployeeListView extends StatelessWidget {
  const BuildItemEmployeeListView({Key? key, this.date, this.startTime, this.endTime, required this.staffInfoList, required this.timeId}) : super(key: key);
  final date, startTime, endTime;
  final int timeId;
  final List<StaffInfo>? staffInfoList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Container(
         margin: EdgeInsets.symmetric(vertical: 5),
         child:  Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text("Date: $date", style: Theme.of(context).textTheme.headline6,),
             Text("Time.: $startTime - $endTime", style: Theme.of(context).textTheme.bodyLarge,),
           ],
         ),
       ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: staffInfoList!.length,
            itemBuilder: (_, item) {
              return EmployeeItemCard(staffInfo: staffInfoList![item], startTime: startTime, endTime: endTime, date: date, timeId: timeId ,);
            }
        ),
      ],
    );
  }
}
