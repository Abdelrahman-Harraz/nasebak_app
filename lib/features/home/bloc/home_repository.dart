import 'package:nasebak_app/features/home/bloc/home_bloc.dart';
import 'package:nasebak_app/features/home/model/home_ui_model.dart';

abstract class BaseHomeRepository {
  Future<HomeState> homeData();
}

class HomeRepository implements BaseHomeRepository {
  @override
  Future<HomeState> homeData() async {
    return LoadedHomeDataSuccessfullyState(
      myProfile: HomeUiModel.dummy(),
      otherUsersProfiles: HomeUiModel.dummy(),
    );
  }
}
