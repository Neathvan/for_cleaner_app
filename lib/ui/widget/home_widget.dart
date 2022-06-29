import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_app/bloc/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/staff_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/ui/screen/employee_list_screen.dart';
import 'package:clean_app/ui/screen/option_booking_screen.dart';
import 'package:clean_app/ultis/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/employee_profile_screen.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  String? _name = 'name';

  Future getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("userName");
    });
    return prefs.getString("userName");
  }

  @override
  void initState() {
    getSharedPrefs();
    super.initState();
    Provider.of<StaffProvider>(context, listen: false).getStaffList();
  }

  Future<ApiStatus?> _fetchData() async {
    ApiStatus? apiStatus = await Provider.of<StaffProvider>(context).getStaffList();
    return apiStatus;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      children: [
        Text("Hello ${_name!}!", style: TextStyle(color: defaultColor.appColor, fontSize: 30, fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text('Service', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
        cardBuilder(defaultColor.appColor, 'Cleaning service', Icons.cleaning_services, context),
        Text('Staff', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),

        Consumer<StaffProvider>(
          builder: (_, provider, item) {
            if( provider.staffListResult.data != null ) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.staffListResult.data != null ? provider.staffListResult.data!.length :0 ,
                itemBuilder: (_, item) {
                  if( provider.staffListResult.data == null ) {
                    return Container();
                  }
                  return cardStaffBuilder(defaultColor.appColor, provider.staffListResult.data![item].firstName!,provider.staffListResult.data![item].name!, provider.staffListResult.data![item].rating,provider.staffListResult.data![item].id!,provider.staffListResult.data![item].profileImage!, context);
                },
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },
        )
      ],
    );
  }

  Widget cardStaffBuilder(bgColor,String firstname,  String name, int rating, int id, String image,  BuildContext context) {
    return Container(
      height: 100,
      width: 180,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => EmployeeProfileScreen(id: id, firstName: firstname, lastName: name, )
          ),
          );
        } ,
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
                    child: CachedNetworkImage(
                      imageUrl: image,
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
                title: Text(name),
                subtitle: RatingBarIndicator(
                  rating: rating.toDouble(),
                  itemBuilder: (context, index) => Icon(
                    Icons.star_outlined,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardBuilder(bgColor, String title, IconData icons, BuildContext context) {
    return Container(
      height: 193,
      width: 180,

      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OptionBookingScreen(nameBooking: title,)),
          );
        } ,
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          color: bgColor,
          shape: RoundedRectangleBorder(
            // side: BorderSide(
            //   color: bgColor,
            //   width: 4
            // ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(icons,color:Colors.white70, size: 40),
                title: Text(title, style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
