import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clean_app/bloc/KProvider.dart';
import 'package:clean_app/model/booked_record_by_id_model.dart';
import 'package:clean_app/model/booked_record_model.dart';
import 'package:clean_app/model/employee.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/repository/booking_repository.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/service/kresult.dart';
import 'package:clean_app/ui/screen/booking_invoice_screen.dart';

class BookingProvider extends KProvider {
  KResult employeeList  = KResult(ApiStatus.empty, {});
  KResult<BookedRecordModel>  bookedRecordResult    = KResult(ApiStatus.empty, {});
  KResult<BookedRecordByIdModel> bookedIdRecord    = KResult(ApiStatus.empty, {});
  BookingRepository bookingRepository = BookingRepository();

  Future<ApiStatus?> getEmployee() async {
    employeeList.status = ApiStatus.loading;

    KData data = await bookingRepository.getEmployeeList();
    employeeList.status = data.status;

    if( data.status == ApiStatus.loaded ) {
       data.response.data.map((e) => Employee.fromJson(e) ).toList();
    }
    update();
  }

  Future<ApiStatus?> bookingStaffCleanService(BuildContext context,String date, String start, String end, String name, String? phoneNum, String nation, int staffId,int timeId,{int? userId}) async {
    bookedIdRecord.status = ApiStatus.loading;
    showLoading(context, 'loading... ');
    
    KData data    = await bookingRepository.bookingStaffCleanService(date, start, end, name, phoneNum, nation, staffId, timeId);
    bookedIdRecord.status = data.status;

    if( data.status == ApiStatus.loaded ) {
      hideLoading(context);
      bookedIdRecord.data     = BookedRecordByIdModel.fromJson(data.response.data);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BookingInvoiceScreen(bookedRecordByIdModel: bookedIdRecord.data!)), (route) =>route.isFirst
      );
      update();
      return data.status;
    }
    update();
    return bookedIdRecord.status;
  }
}