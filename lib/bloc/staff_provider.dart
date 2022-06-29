import 'package:clean_app/model/comment_rating_review.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/model/staff_detail_model.dart';
import 'package:clean_app/repository/staff_repository.dart';
import 'package:clean_app/service/kresult.dart';

import '../repository/repository.dart';
import 'KProvider.dart';

class StaffProvider extends KProvider {
  KResult<StaffDetailModel> staffDetailResult  = KResult(ApiStatus.empty, {});
  KResult<List<StaffDetailModel>> staffListResult  = KResult(ApiStatus.empty, {});

  KResult<List<CommentRatingReview>> commentRatingReview  = KResult(ApiStatus.empty, {});

  StaffRepository staffRepository = StaffRepository();

  Future<ApiStatus> getStaffDetail(int id) async {
    staffDetailResult.status = ApiStatus.loading;

    KData data = await staffRepository.getStaffDetail(id);

    /// after response
    staffDetailResult.status = data.status;
    if( data.status == ApiStatus.loaded ) {
      // StaffDetailModel.fromJson(data.response.data);
      staffDetailResult.data      = StaffDetailModel.fromJson(data.response.data);
      update();
    }

    update();
    return data.status;
  }

  Future<ApiStatus> getCommentRatingReviewList(int id) async {
    commentRatingReview.status = ApiStatus.loading;

    KData data = await staffRepository.getCommentRatingReviewList(id);

    commentRatingReview.status = data.status;
    if( data.status == ApiStatus.loaded ) {
      commentRatingReview.data    = List<CommentRatingReview>.from(data.response.data.map((x) => CommentRatingReview.fromJson(x)));
      update();
    }

    update();
    return data.status;
  }

  Future<ApiStatus?> getStaffList() async {
    staffListResult.status = ApiStatus.loading;
    KData data = await staffRepository.getStaffList();
    staffListResult.status = data.status;

    if( data.status == ApiStatus.loaded ) {
      staffListResult.data      = List<StaffDetailModel>.from(data.response.data.map((x) => StaffDetailModel.fromJson(x)));

      print(staffListResult.data);
      update();
    }
    update();
  }
}