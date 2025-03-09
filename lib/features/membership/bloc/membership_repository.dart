import 'package:nasebak_app/features/membership/bloc/membership_bloc.dart';
import 'package:nasebak_app/features/membership/model/membership_ui_model.dart';

abstract class BaseMembershipRepository {
  Future<MembershipState> membershipData();
}

class MembershipRepository implements BaseMembershipRepository {
  @override
  Future<MembershipState> membershipData() async {
    return MembershipDataLoadedSuccessfullyState(
      model: MembershipUiModel.dummyMemberships(),
    );
  }
}
