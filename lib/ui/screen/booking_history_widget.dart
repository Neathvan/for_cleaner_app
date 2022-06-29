import 'package:flutter/material.dart';
import 'package:clean_app/bloc/booked_record_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/ui/screen/booked_detail_screen.dart';
import 'package:provider/provider.dart';

class BookingHistoryWidget extends StatefulWidget {
  const BookingHistoryWidget({Key? key}) : super(key: key);

  @override
  State<BookingHistoryWidget> createState() => _BookingHistoryWidgetState();
}

class _BookingHistoryWidgetState extends State<BookingHistoryWidget> {

  Future<void> _pullRefresh() async {
    context.read<BookedRecordProvider>().getBookedRecordList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Consumer<BookedRecordProvider>(
        builder: (_, provider, child)  {
          if( provider.bookedRecord.data == null ) {
            return Center(child: CircularProgressIndicator(),);
          }

          return ListView.builder(
            itemCount: provider.bookedRecord.data?.length,
            itemBuilder: (_, index) {

              return InkWell(child: buildCardBookedItem( provider.bookedRecord.data![index].date!,  provider.bookedRecord.data![index].startTime!,provider.bookedRecord.data![index].endTime!, provider.bookedRecord.data![index].status!), onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookedDetailScreen(id: provider.bookedRecord.data![index].id!,)),
                );
              },);
            },
          );
        },
      ),
    );
  }

  Card buildCardBookedItem(String? date, String start, String end, String status) {
    Color statusColor;

    switch(status) {
      case 'missed':
        {
          statusColor = Colors.red;
        }
        break;
      case 'process':
        {
          statusColor = Colors.lightGreen;
        }
        break;
      default:
        {
          statusColor = defaultColor.appColor;
        }
        break;
    }

      return Card(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
              backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundColor: Color(0xffE6E6E6),
                  radius: 30,
                  child: Icon(
                    Icons.cleaning_services,
                    color: defaultColor.appColor,
                  ),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              title: Text("Cleaning date  : $date"),
              subtitle: Text("Time        : $start - $end"),
              trailing: Text(status.toUpperCase(), style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),),
            )
          ],
        )
      );
  }

  @override
  void initState() {
    context.read<BookedRecordProvider>().getBookedRecordList();
    super.initState();
  }
}


