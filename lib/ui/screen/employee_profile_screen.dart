import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/staff_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/model/staff_detail_model.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/ui/screen/schedule_staff_screen.dart';
import 'package:clean_app/ui/widget/component/app_bar_widget.dart';
import 'package:clean_app/ui/widget/component/description_text_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class EmployeeProfileScreen extends StatefulWidget {
  const EmployeeProfileScreen({Key? key, required this.id,  this.firstName,  this.lastName, this.parentPage}) : super(key: key);
  final int id;
  final String? firstName, lastName;
  final String? parentPage;

  @override
  _EmployeeProfileScreenState createState() => _EmployeeProfileScreenState();
}

class _EmployeeProfileScreenState extends State<EmployeeProfileScreen> {
  
  @override
  void initState() {
    context.read<StaffProvider>().getStaffDetail(widget.id);
    context.read<StaffProvider>().getCommentRatingReviewList(widget.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.firstName!, title2:  widget.lastName,),
      body: Consumer<StaffProvider>(
        builder: (context, provider, child) {
          if ( provider.staffDetailResult.status == ApiStatus.loaded ) {
            StaffDetailModel?  _staffDetail  = provider.staffDetailResult.data;
            return ListView(
              padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              children: [
                Container(
                  width: 50,
                  height: 200,
                  child: CachedNetworkImage(
                    imageUrl: provider.staffDetailResult.data!.profileImage ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Center(
                  child: RatingBarIndicator(
                    rating: _staffDetail!.rating.toDouble(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star_outlined,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 30.0,
                    direction: Axis.horizontal,
                  ),
                ),
                detailItemText('Firstname', _staffDetail.firstName!),
                detailItemText('Name', _staffDetail.name!),
                detailItemText('Email', _staffDetail.email!),
                detailItemText('Phone number', _staffDetail.phoneNumber!.toString()),
                detailItemText('Bio', _staffDetail.bio.toString()),
                bookingButton("${ _staffDetail.firstName!} ${ _staffDetail.name!}",  _staffDetail.id!),

                /// comment section
                SizedBox(height: 10,),
                Text("Comment", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Consumer<StaffProvider>(builder: (_, provider, child) {
                  if( provider.commentRatingReview.status != ApiStatus.loaded) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: provider.commentRatingReview.data!.length,
                    itemBuilder: (_, index) {
                      return commentCard(provider.commentRatingReview.data![index].user!.name!, provider.commentRatingReview.data![index].comment!, provider.commentRatingReview.data![index].rating!);
                    },
                  );
                })
              ],
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }


  Widget commentCard(String firstname, String comment,  int rating,{String? name} ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: CircleAvatar(
            backgroundColor: Color(0xffE6E6E6),
            radius: 30,
              child: Icon(
              Icons.person,
              color: Color(0xffCCCCCC),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: new EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(firstname, style: TextStyle( fontWeight: FontWeight.bold),),
                      SizedBox(width: 3,),
                      Center(
                        child: RatingBarIndicator(
                          rating: rating.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star_outlined,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 15,
                          direction: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                  DescriptionTextWidget(
                    text: comment
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //         OutlinedButton(
                  //           onPressed: () {
                  //             // Navigator.push(
                  //             //   context, MaterialPageRoute(builder: (context) => EmployeeProfileScreen(id: bookedRecordByIdModel!.bookedRecord!.staffId!, firstName: bookedRecordByIdModel!.firstName, lastName: bookedRecordByIdModel!.name, )
                  //             // ),
                  //             // );
                  //           },
                  //           child: Row(
                  //             children: [
                  //               Icon(Icons.thumb_up_alt_outlined,color: Colors.black,),
                  //               SizedBox(width: 5,),
                  //               Text("Helpful" , style: TextStyle(color: Colors.black,),)
                  //             ],
                  //           ),
                  //           style: OutlinedButton.styleFrom(
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(15.0),
                  //             ),
                  //           ),
                  //       ),
                  //       SizedBox(width: 50,),
                  //       OutlinedButton(
                  //         onPressed: () {
                  //           // Navigator.push(
                  //           //   context, MaterialPageRoute(builder: (context) => EmployeeProfileScreen(id: bookedRecordByIdModel!.bookedRecord!.staffId!, firstName: bookedRecordByIdModel!.firstName, lastName: bookedRecordByIdModel!.name, )
                  //           // ),
                  //           // );
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.thumb_down_alt_outlined, color: Colors.black,),
                  //           ],
                  //          ),
                  //         style: OutlinedButton.styleFrom(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(15.0),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile detailItemText(String title, String data) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text (
        title, style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
      ),
      subtitle:Container(
        child:  Text (
          data == 'null' ? 'N/A' : data, style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        decoration:  BoxDecoration (
            borderRadius:  BorderRadius.all( Radius.circular(5.0)),
            color: Colors.grey.shade200
        ),
        padding:  EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 5),
      ),
    );
  }

  Widget bookingButton(String name,int id) {
    return Container(
      // alignment: Alignment.bottomRight,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: CupertinoButton(
        color: defaultColor.appColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScheduleStaffScreen(name: name, id: id,)),
          );
        },
        child: const Text('View schedule '),
      ),
    );
  }
}
