import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/extention/text_extension.dart';
import 'package:clean_app/model/search_staff_model.dart';
import 'package:clean_app/ui/screen/booking_form_screen.dart';
import 'package:clean_app/ui/screen/employee_profile_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class EmployeeItemCard extends StatefulWidget {
  const EmployeeItemCard({Key? key,required this.staffInfo, required this.startTime, required this.endTime, required this.date, required this.timeId}) : super(key: key);
  final String startTime, endTime, date;
  final StaffInfo staffInfo;
  final int timeId;

  @override
  State<EmployeeItemCard> createState() => _EmployeeItemCardState();
}

class _EmployeeItemCardState extends State<EmployeeItemCard> {
  late StaffInfo staffInfo;

  @override
  void initState() {
    staffInfo = widget.staffInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        elevation: 0,
        color: Colors.blue[50],
       shape: RoundedRectangleBorder(
           side: BorderSide(color: Colors.grey.shade200, width: 1.0),
           borderRadius: BorderRadius.circular(15.0)
       ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 0, right: 0, top: 0,bottom: 10),
                child: buildDetailHeaderCardItem(context),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text('View Profile'),
                      onPressed: () => {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => EmployeeProfileScreen(id: staffInfo.id!, firstName: staffInfo.firstName!, lastName: staffInfo.name!, )
                        ),
                        )
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.shade900,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Book'),
                      onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => BookingFormScreen(
                              id: staffInfo.id!,
                              start: widget.startTime,
                              end: widget.endTime,
                              date: widget.date,
                            timeId: widget.timeId,
                              )
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildDetailHeaderCardItem(BuildContext context) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: staffInfo.profileImage ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(staffInfo.name!.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54 ),),
                       widgetReturnMargin( RatingBarIndicator(
                         rating: staffInfo.rating!.toDouble(),
                         itemBuilder: (context, index) => Icon(
                           Icons.star_outlined,
                           color: Colors.amber,
                         ),
                         itemCount: 5,
                         itemSize: 20.0,
                         direction: Axis.horizontal,
                       ),),
                        Text("Time.: ${widget.startTime} - ${widget.endTime}", style: Theme.of(context).textTheme.subtitle1,),
                      ],
                    ),
                  ),
                )
              ],
            );
  }

  Container widgetReturnMargin(Widget widget ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: widget
    );
  }
}
