import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/booking_provider.dart';
import 'package:clean_app/bloc/staff_provider.dart';
import 'package:clean_app/bloc/user_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/ui/widget/component/app_bar_widget.dart';
import 'package:clean_app/extention/text_extension.dart';
import 'package:flutter_rating_bar/src/rating_bar_indicator.dart';
import 'package:provider/provider.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({required this.date, required this.start, required this.end, required this.id ,Key? key, required this.timeId}) : super(key: key);
  final String date, start, end;
  final int id, timeId;
  @override
  _BookingFormScreenState createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    context.read<StaffProvider>().getStaffDetail(widget.id);
    context.read<UserProvider>().getUserInformation(context);
    context.read<UserProvider>().gender = null;
    context.read<UserProvider>().nationality = null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Booking',),
      body: Container(
        child: ListView(
          children: [
            // Date tiem
            cardBuilder(
                Column(
              children: [
                Text("Date & Time", style: Theme.of(context).textTheme.headline6,),
                widgetReturnMargin( Text(widget.date, style: KtextTheme(textTheme).krSubTitleItemGray,),),
                Text("${widget.start} - ${widget.end}" , style: KtextTheme(textTheme).krSubTitleItemGray)
              ],
            )
            ),


          /// staff information
          Consumer<StaffProvider>(
            builder: (_, provider, child) {
             if( provider.staffDetailResult.status == ApiStatus.loaded ){
               return cardBuilder(Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("Staff Information", style: Theme.of(context).textTheme.headline6,),
                   SizedBox(height: 10,),
                   buildDetailHeaderCardItem(context, provider.staffDetailResult.data!.profileImage!, provider.staffDetailResult.data!.name!, provider.staffDetailResult.data!.rating)
                 ],
               ));
             }
             return Center(child: CircularProgressIndicator(),);
            },
          ),

            /// contact
          Consumer<UserProvider>(builder: (_, provider, child) {
            return cardBuilder(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Contact Information", style: Theme.of(context).textTheme.headline6,),
                    // SizedBox(height: 10,),

                    TextField(
                      decoration: InputDecoration(
                        labelText: "Your name", //babel text
                        hintText: "Enter your name", //hint text
                        hintStyle: TextStyle(fontSize:12), //hint text style
                        labelStyle: KtextTheme(textTheme).krSubTitleItemGray2, //label style
                      ),
                      controller: nameController..text =  provider.userResult.data?.name ?? "",
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Phone number", //babel text
                        hintText: "Enter your phone number", //hint text
                        hintStyle: TextStyle(fontSize: 12,), //hint text style
                        labelStyle: KtextTheme(textTheme).krSubTitleItemGray2, //label style
                      ),
                      keyboardType: TextInputType.number,
                      // controller: phoneController..text = provider.userResult.data!.phoneNumber!.toString(),
                    ),
                    SizedBox(height: 10,),
                    Text("Gender ", style: KtextTheme(textTheme).krSubTitleItemGray2,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          child: Row(
                            children: [
                              context.watch<UserProvider>().gender == null || context.watch<UserProvider>().gender == 'female' ? Container() :  Icon(Icons.done),
                              Text('Man'),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: defaultColor.appColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            context.read<UserProvider>().updateGender(0);
                          },
                        ),
                        OutlinedButton(
                          child: Row(
                            children: [
                              context.watch<UserProvider>().gender == null || context.watch<UserProvider>().gender == 'male' ? Container() : Icon(Icons.done),
                              Text('Female'),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: defaultColor.appColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            context.read<UserProvider>().updateGender(1);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Nationality ", style: KtextTheme(textTheme).krSubTitleItemGray2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          child: Row(
                            children: [
                              context.watch<UserProvider>().nationality == null || context.watch<UserProvider>().nationality == 'foreigner' ? Container() :Icon(Icons.done),
                              Text('Khmer'),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: defaultColor.appColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            context.read<UserProvider>().updateNationality(1);
                          },
                        ),
                        OutlinedButton(
                          child: Row(
                            children: [
                              context.watch<UserProvider>().nationality == null || context.watch<UserProvider>().nationality == 'khmer' ? Container() :Icon(Icons.done),
                              Text('Foreign'),
                            ],
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: defaultColor.appColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            context.read<UserProvider>().updateNationality(0);
                          },
                        ),
                      ],
                    )
                  ],
                )
            );
          }
        ),

           /// book ing
             Container(
             margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
             child:  ElevatedButton(
               child: Text('Book Now'),
               onPressed: context.read<UserProvider>().gender == null && context.read<UserProvider>().nationality == null ? null : () {

                 context.read<BookingProvider>().bookingStaffCleanService(
                   context,
                   widget.date,
                   widget.start,
                   widget.end,
                   nameController.text,
                   phoneController.text,
                   context.read<UserProvider>().nationality!,
                   widget.id,
                   widget.timeId
                 );
               } ,
               style: ElevatedButton.styleFrom(
                 primary: Colors.blue.shade900,
                 padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15.0),
                 ),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }

  void showLoading(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return SimpleDialog(
          backgroundColor: Colors.transparent,//here set the color to transparent
          elevation: 0,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),
                Text(text, textAlign: TextAlign.center),
              ],
            ),
          ],
        );
      },
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
            imageUrl: url,
            placeholder: (context, url) => CircularProgressIndicator(),
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
                // Text("Time.: ${widget.startTime} - ${widget.endTime}", style: Theme.of(context).textTheme.subtitle1,),
              ],
            ),
          ),
        )
      ],
    );
  }

  void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  Container widgetReturnMargin(Widget widget ) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: widget
    );
  }
}