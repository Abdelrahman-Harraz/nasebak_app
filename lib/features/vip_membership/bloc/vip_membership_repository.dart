import 'package:nasebak_app/features/vip_membership/bloc/vip_membership_bloc.dart';
import 'package:nasebak_app/features/vip_membership/model/vip_membership_ui_model.dart';

abstract class BaseVipMembershipRepository {
  Future<VipMembershipState> vipMembershipData();
}

class VipMembershipRepository implements BaseVipMembershipRepository {
  @override
  Future<VipMembershipState> vipMembershipData() async {
    return VipMembershipDataLoadedSuccessfullyState(
      vipMembershipUiModel: VipMembershipUiModel.dummy(),
    );
  }
}
