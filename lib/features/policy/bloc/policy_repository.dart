import 'package:nasebak_app/features/policy/bloc/policy_bloc.dart';
import 'package:nasebak_app/features/policy/model/policy_ui_model.dart';

abstract class BasePolicyRepository {
  Future<PolicyState> policyData();
}

class PolicyRepository implements BasePolicyRepository {
  @override
  Future<PolicyState> policyData() async {
    return LoadedPolicyDataSuccessfullyState(
      policyUiModel: PolicyUiModel.dummyPolicies,
    );
  }
}
