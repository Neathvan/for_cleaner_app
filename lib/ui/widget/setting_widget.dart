import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/user_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/ui/widget/component/app_bar_widget.dart';
import 'package:clean_app/ui/widget/component/description_text_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  double? _ratingValue;

  @override
  void initState() {
    context.read<UserProvider>().getUserInformation(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Profile',),
      body: Consumer<UserProvider>(
        builder: (_, provider, child) {
          if( provider.userResult.status != ApiStatus.loaded){
            return Center(child: CircularProgressIndicator(),);
          }
          return ListView(
            padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: defaultColor.appColor,
                child: ClipRRect(
                  child: Icon(Icons.person, size: 50, color: Colors.grey[200],)
                ),
              ),
              // detailItemText('Firstname', 'Kim'),
              detailItemText('Name', provider.userResult.data!.name!),
              // detailItemText('ID', 11111.toString()),
              detailItemText('Email', provider.userResult.data!.email!),
              // detailItemText('Phone number', ""),
              // detailItemText('Bio', "jdjfs"),
              // logoutButton(context)
            ],
          );
        },
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: CupertinoButton(
        color: Colors.grey,
        onPressed: () {
          Provider.of<UserProvider>(context, listen: false).logout(context);
        },
        child: const Text('Logout'),
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
          data, style: TextStyle(fontSize: 15, color: Colors.black),
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
}
