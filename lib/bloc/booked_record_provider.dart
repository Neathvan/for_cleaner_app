import 'package:clean_app/model/booked_record_by_id_model.dart';
import 'package:clean_app/model/booked_record_model.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/repository/booked_record_repository.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/service/kresult.dart';

import 'KProvider.dart';

class BookedRecordProvider extends KProvider {
  KResult<List<BookedRecordModel>> bookedRecord = KResult(ApiStatus.empty, {});
  KResult<BookedRecordByIdModel> bookedIdRecord    = KResult(ApiStatus.empty, {});
  BookedRecordRepository bookedRecordRepository = BookedRecordRepository();

  Future<ApiStatus?> getBookedRecordList() async {
    bookedRecord.status = ApiStatus.loading;

    KData data = await bookedRecordRepository.getBookedRecord();
    bookedRecord.status = data.status;

    if( data.status == ApiStatus.loaded ) {
      bookedRecord.data   = List<BookedRecordModel>.from(data.response.data.map((x) => BookedRecordModel.fromJson(x)));
      update();
    }
  }

  Future<ApiStatus?> getBookedRecordById( int id) async {
    bookedIdRecord.status = ApiStatus.loading;

    KData data = await bookedRecordRepository.getBookedRecordById(id);
    bookedIdRecord.status = data.status;

    if( data.status ==ApiStatus.loaded ) {
      bookedIdRecord.data   = BookedRecordByIdModel.fromJson(data.response.data);
      print( bookedIdRecord.data?.id);
      update();
    }
  }

  Future<ApiStatus?> insertRating(int id,int bookingId, int rating,{String? comment}) async {
    KData data = await bookedRecordRepository.insertRating(id, bookingId, rating, comment: comment);

    if( data.status ==ApiStatus.loaded ) {
      return data.status;
    }
    return data.status;
  }
}