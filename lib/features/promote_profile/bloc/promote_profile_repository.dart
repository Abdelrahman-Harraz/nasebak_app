import 'package:nasebak_app/features/promote_profile/bloc/promote_profile_bloc.dart';
import 'package:nasebak_app/features/promote_profile/model/promote_profile_ui_model.dart';

abstract class BasePromoteProfileRepository {
  Future<PromoteProfileState> promoteProfileData();
}

class PromoteProfileRepository implements BasePromoteProfileRepository {
  @override
  Future<PromoteProfileState> promoteProfileData() async {
    return PromoteProfileDataLoadedSuccessfullyState(
      promoteProfileUiModel: PromoteProfileUiModel.dummy(),
    );
  }
}
