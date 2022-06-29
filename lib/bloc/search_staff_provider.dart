import 'package:clean_app/bloc/KProvider.dart';
import 'package:clean_app/model/employee.dart';
import 'package:clean_app/model/response_data.dart';
import 'package:clean_app/model/schedule_staff_model.dart';
import 'package:clean_app/model/search_staff_model.dart';
import 'package:clean_app/repository/repository.dart';
import 'package:clean_app/repository/search_staff_repository.dart';
import 'package:clean_app/service/kresult.dart';

class SearchStaffProvider extends KProvider {
  KResult<List<SearchStaff>> staffListResult  = KResult(ApiStatus.empty, {});
  KResult<List<ScheduleStaff>> scheduleList  = KResult(ApiStatus.empty, {});
  SearchStaffRepository searchStaffRepository = SearchStaffRepository();

  Future<ApiStatus> searchStaffByStartEndDate(String startDate, String endDate) async {
    staffListResult.status = ApiStatus.loading;

    KData data = await searchStaffRepository.searchStaffByStartEndDate(startDate.replaceAll(' ', ''), endDate.replaceAll(' ', ''));

    /// after response
    staffListResult.status = data.status;
    if( data.status == ApiStatus.loaded ) {
      staffListResult.data      = List<SearchStaff>.from(data.response.data.map((x) => SearchStaff.fromJson(x)));
      update();
    }

    update();
    return data.status;
  }

  Future<ApiStatus> viewScheduleList(int id) async {
    scheduleList.status = ApiStatus.loading;

    KData data = await searchStaffRepository.viewScheduleStaff(id);

    /// after response
    scheduleList.status = data.status;
    if( data.status == ApiStatus.loaded ) {
      scheduleList.data      = List<ScheduleStaff>.from(data.response.data.map((x) => ScheduleStaff.fromJson(x)));
      update();
    }

    update();
    return data.status;
  }
}