import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/booked_record_provider.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/ui/screen/employee_profile_screen.dart';
import 'package:clean_app/ui/widget/component/app_bar_widget.dart';
import 'package:clean_app/extention/text_extension.dart';
import 'package:clean_app/ui/widget/helper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class BookedDetailScreen extends StatefulWidget {
  const BookedDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _BookedDetailScreenState createState() => _BookedDetailScreenState();
}

class _BookedDetailScreenState extends State<BookedDetailScreen> {

  Future<void> _pullRefresh() async {

  }

  @override
  void initState() {
    context.read<BookedRecordProvider>().getBookedRecordById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Booked Information',),
      body: Consumer<BookedRecordProvider>(
        builder: (_, provider, child) {
          return RefreshIndicator(
            onRefresh: () async{
              await provider.getBookedRecordById(widget.id);
            },
            child: provider.bookedIdRecord.status == ApiStatus.loaded ? ListView(
              children: [
                cardBuilder(
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(provider.bookedIdRecord.data!.bookedRecord!.status.toString().toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Helper.statusCheck(provider.bookedIdRecord.data!.bookedRecord!.status!)),),
                        Text("Price: ...", style: Theme.of(context).textTheme.headlineSmall,),
                        SizedBox(height: 10,),
                        buildRowDetail('Booking Date :', provider.bookedIdRecord.data!.bookedRecord!.createdAt!),
                        buildRowDetail('Cleaning Date :', provider.bookedIdRecord.data!.bookedRecord!.date!),
                        buildRowDetail('Cleaning Time :', provider.bookedIdRecord.data!.bookedRecord!.startTime!, value2:provider.bookedIdRecord.data!.bookedRecord!.endTime!),
                        buildRowDetail('Type                  :', provider.bookedIdRecord.data!.bookedRecord!.createdAt!),
                        buildRowDetail('Staff Name      :', provider.bookedIdRecord.data!.name!),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: () {
                                Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => EmployeeProfileScreen(id:  provider.bookedIdRecord.data!.bookedRecord!.staffId!, firstName:  provider.bookedIdRecord.data!.firstName, lastName:  provider.bookedIdRecord.data!.name, )
                                ),
                                );
                              }, child: Row(
                                children: [
                                  Icon(Icons.open_in_new),
                                  Text("View staff")
                                ],
                              )),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true, // set to false if you want to force a rating
                                      builder: (context) => WidgetHelper().ratingDialog(context, provider.bookedIdRecord.data!.id!, widget.id),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.orange,),
                                      Text("Rating", style: TextStyle(color:  Colors.orangeAccent,),)
                                    ],
                                  ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                ),

                cardBuilder(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Text(provider.bookedIdRecord!.data!.bookedRecord!.status.toString().toUpperCase(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Helper.statusCheck(provider.bookedIdRecord!.data!.bookedRecord!.status!)),),
                      Text("Your Contact", style: Theme.of(context).textTheme.headline6,),
                      SizedBox(height: 10,),
                      buildRowDetail('Name                :', provider.bookedIdRecord.data!.bookedRecord!.name!),
                      buildRowDetail('Phone number :', provider.bookedIdRecord.data!.bookedRecord!.phoneNumber ?? 'N/A'),
                      // buildRowDetail('Gender              :', provider.bookedIdRecord.data!.bookedRecord!.gender!.toString() ?? 'N/A'),
                      buildRowDetail('Nationality       :', provider.bookedIdRecord.data!.bookedRecord!.nationality!),
                    ],
                  ),
                )
              ],
            ) : Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }

  Widget buildRowDetail(String title, String value, {String? value2}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child:  Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.krSubTitleItemGray2,),
            value2 != null ? Text("$value - $value2", style: Theme.of(context).textTheme.krSubTitleItemGray2,) : Text(value.toUpperCase(), style: Theme.of(context).textTheme.krSubTitleItemGray3,)
          ],
        ),
      ),
    );
  }

  Widget cardBuilder( Widget widget) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade200, width: 1.0),
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: Container(
          margin: EdgeInsets.all(10),
          child: widget,
        )
    );
  }

  Row buildDetailHeaderCardItem(BuildContext context, String url, String name, int rating, ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: CachedNetworkImage(
            width: 100,
            height: 100,
            imageUrl: "https://0.soompi.io/wp-content/uploads/2022/02/21094205/iu-3.jpeg",
            placeholder: (context, url) => Container(
              width: 5,
              height: 5,
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54 ),),
                widgetReturnMargin( RatingBarIndicator(
                  rating: rating.toDouble(),
                  itemBuilder: (context, index) => Icon(
                    Icons.star_outlined,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),),

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
