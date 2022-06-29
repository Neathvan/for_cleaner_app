import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/extention/style.dart';
import 'package:clean_app/extention/text_extension.dart';
import 'package:clean_app/ui/widget/setting_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/user_provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

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
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: defaultColor.appColor,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          height: 120,
          child: buildDetailHeaderCardItem(context,
              '', _name),
        ),

        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingWidget()));
          },
          child: Card(
            child: ListTile(
              leading:  Icon(Icons.person, size: 40,),
              title: Text('View profile'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Provider.of<UserProvider>(context, listen: false).logout(context);
          },
          child: Card(
            child: ListTile(
              leading: Icon(Icons.outbond_outlined, size: 40,),
              title: Text('Logout'),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        )
      ],
    );
  }

  Row buildDetailHeaderCardItem(BuildContext context, String image, String? name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Color(0xffE6E6E6),
          radius: 40,
          child: Icon(
            Icons.person,
            color: Color(0xffCCCCCC),
            size: 50,
          ),
        ),
       SizedBox(width: 10,),
       Expanded(child: Align(
         alignment: Alignment.centerLeft,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Text(name!.toUpperCase(), style: KtextTheme(textTheme).krDateItemTitle,),
           ],
         )
       ))
      ],
    );
  }
}