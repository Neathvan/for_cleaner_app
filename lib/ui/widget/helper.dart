
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/booked_record_provider.dart';
import 'package:clean_app/extention/style.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class Helper {

  static statusCheck( String status) {
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

    return statusColor;
  }
}

class WidgetHelper {

  Widget ratingDialog (BuildContext context, int id, int bookingId) {
    return  RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Rating',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Submit',
      commentHint: 'Feedback about our staff',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        context.read<BookedRecordProvider>().insertRating(id,bookingId, response.rating.toInt(), comment: response.comment);
      },
    );
  }
}