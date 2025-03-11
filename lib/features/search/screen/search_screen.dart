import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/app_router.dart';
import 'package:nasebak_app/features/search/bloc/search_bloc.dart';
import 'package:nasebak_app/features/search/bloc/search_repository.dart';
import 'package:nasebak_app/features/search/model/search_ui_model.dart';
import 'package:nasebak_app/features/user_info/model/user_info_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/feedback/feedback_message.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(searchRepository: SearchRepository()),
      child: const SearchScreenWithBloc(),
    );
  }
}

class SearchScreenWithBloc extends BaseStatefulScreenWidget {
  const SearchScreenWithBloc({super.key});

  @override
  BaseScreenState<SearchScreenWithBloc> baseScreenCreateState() =>
      _SearchScreenWithBlocState();
}

class _SearchScreenWithBlocState extends BaseScreenState<SearchScreenWithBloc> {
  final Map<String, String> selectedValues = {};
  @override
  void initState() {
    super.initState();
    Future.microtask(_getSearchResultEvent);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        scrolledUnderElevation: .1,
        centerTitle: true,
        title: Text(context.translate(LocalizationKeys.search)),
        actions: [
          IconButton(
            onPressed: _openNotificationsScreen,
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.menuIcon),
          ),
        ],
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is SearchErrorState) {
            showFeedbackMessage(
              state.isLocalizationKey
                  ? context.translate(state.errorMessage)
                  : state.errorMessage,
            );
          }
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssetPaths.homeBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: _buildPageContent(),
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildPageContent() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is LoadedSearchResultDateSuccessfullyState) {
          return _pageContent(state.searchUiModel);
        } else {
          return EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(SearchUiModel searchScreenUiModel) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(height: 100),
          _buildPersonalInformation(searchScreenUiModel.userInfo.first),
        ],
      ),
    );
  }

  Widget _buildPersonalInformation(UserInfoUiModel model) {
    return _buildInfoSection([
      _buildInfoRow(
        context.translate(LocalizationKeys.age),

        context,
        AppAssetPaths.ageIcon,
        ["18-25", "26-35", "36-45", "46+"],
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.weight),

        context,
        AppAssetPaths.weightIcon,
        _weight,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.tall),

        context,
        AppAssetPaths.tallIcon,
        _height,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.income),

        context,
        "",
        _income,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.whatAreYouLookingFor),

        context,
        AppAssetPaths.lensIcon,
        _whatAreYouLookingFor,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouDrink),

        context,
        AppAssetPaths.cupIcon,
        _drink,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.smokeCount),

        context,
        AppAssetPaths.smokeIcon,
        _smoke,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.exerciseCount),

        context,
        AppAssetPaths.gymIcon,
        _exercise,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.havePets),

        context,
        AppAssetPaths.pawIcon,
        _pets,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.education),

        context,
        AppAssetPaths.educationIcon,
        _education,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.consistency),

        context,
        AppAssetPaths.masjidIcon,
        _islam,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.perspective),

        context,
        AppAssetPaths.smileIcon,
        _perspective,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.nationality),

        context,
        AppAssetPaths.nationalityIcon,
        _nationalities,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.countryOfResidence),

        context,
        AppAssetPaths.countryIcon,
        _countries,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.city),

        context,
        AppAssetPaths.cityIcon,
        _cities,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.skin),

        context,
        AppAssetPaths.skinIcon,
        _skin,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.tribe),

        context,
        AppAssetPaths.tribeIcon,
        [],
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.doYouAcceptNationality),

        context,
        AppAssetPaths.acceptNationalityIcon,
        [],
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.maritalStatus),

        context,
        AppAssetPaths.ringIcon,
        _martialStatus,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.haveKids),

        context,
        AppAssetPaths.babyCarIcon,
        _kids,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.look),

        context,
        AppAssetPaths.faceIcon,
        _look,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.hair),

        context,
        AppAssetPaths.hairIcon,
        _hair,
      ),
      _buildInfoRow(
        context.translate(LocalizationKeys.health),

        context,
        AppAssetPaths.bedIcon,
        _health,
      ),
    ]);
  }

  Widget _buildInfoSection(List<Widget> rows) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...rows],
    );
  }

  Widget _buildInfoRow(
    String key,
    BuildContext context,
    String? icon,
    List<String>? choices,
  ) {
    bool hasSelection = selectedValues.containsKey(key);

    return GestureDetector(
      onTap:
          choices != null && choices.isNotEmpty
              ? () => _showBottomSheet(context, key, choices)
              : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.userInfoContainerBackground,
            border: Border.all(
              color: AppColors.userInfoCardBorder.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (icon?.isNotEmpty ?? false) ...[
                      SvgPicture.asset(
                        icon!,
                        width: 21,
                        height: 21,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 9),
                    ],
                    Expanded(
                      child: Text(
                        key, // Key used as the label
                        style: context.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              if (hasSelection)
                Flexible(
                  child: Text(
                    selectedValues[key]!,
                    style: context.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              else if (choices != null && choices.isNotEmpty)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(
    BuildContext context,
    String key,
    List<String> choices,
  ) {
    String? tempSelectedValue = selectedValues[key];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bottomSheetBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder:
              (context, setState) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.bottomSheetDrawer,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    SizedBox(height: 16),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key,
                          style: context.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        ...choices.map((choice) {
                          return RadioListTile<String>(
                            value: choice,
                            groupValue: tempSelectedValue,
                            title: Text(
                              choice,
                              style: context.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            activeColor: Colors.white,
                            onChanged: (newValue) {
                              setState(() => tempSelectedValue = newValue);
                            },
                          );
                        }).toList(),

                        const SizedBox(height: 16),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: () {
                              if (tempSelectedValue != null) {
                                this.setState(() {
                                  selectedValues[key] = tempSelectedValue!;
                                });
                              }
                              Navigator.pop(context);
                            },
                            child: Text(
                              "تأكيد",
                              style: context.bodyLarge?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
        );
      },
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  SearchBloc get currentBloc => context.read<SearchBloc>();

  void _getSearchResultEvent() {
    currentBloc.add(GetSearchResultEvent());
  }

  void _openNotificationsScreen() {
    context.push(AppRouter.notificationsScreen);
  }

  final List<String> _countries = [
    'مصر',
    'المملكة العربية السعودية',
    'الإمارات العربية المتحدة',
    'قطر',
    'الكويت',
  ];
  final List<String> _cities = ['القاهرة', 'جدة', 'دبي', 'الدوحة', 'الكويت'];
  final List<String> _nationalities = [
    'مصري',
    'سعودي',
    'إماراتي',
    'قطري',
    'كويتي',
  ];

  final List<String> _skin = [
    'أبيض',
    'بياض شامي',
    'حنطي',
    ' حنطي فاتح',
    'أسمر',
  ];
  final List<String> _martialStatus = [
    'أعزب',
    'عزباء',
    'أرمل',
    'أرملة',
    'متزوج',
    'متزوجة',
    'بكر',
    'مطلق',
    'مطلقة',
  ];
  final List<String> _kids = [
    'مع والدهم',
    'مع والدتهم',
    'ليس لدي أطفال',
    'لدي أطفال وسيظلون معي',
  ];
  final List<String> _look = [
    'جميلـ / ـة',
    'وسيم',
    'متوسط / ـة الجمال',
    'مقبولـ / ـة',
    'عاديـ / ـة',
    'أقل من العادي',
  ];
  final List<String> _hair = ['ناعم', 'مجعد', 'كيرلي', 'طويل', 'قصير'];
  final List<String> _health = [
    'سليمـ / ـة',
    'ذوي احتياجات خاصة',
    'مرض مزمن',
    'عقيمـ / ـة',
  ];
  final List<String> _drink = [
    'لا أشرب',
    'احيانا',
    'من فترة لأخرى',
    'أحيانا في الليل',
    'بشكل متكرر',
  ];
  final List<String> _smoke = [
    'غير مدخن',
    'غير منتظم',
    'بانتظام',
    'أحاول تركه',
  ];
  final List<String> _exercise = ['كل يوم', 'غالبا', 'أحيانا', 'غير رياضي'];
  final List<String> _pets = [
    'قطط',
    'زواحف',
    'سمك',
    'سنجاب',
    'هامستر',
    'طيور',
    'سلحفاة',
  ];

  final List<String> _education = [
    'البكالوريوس',
    'الدبلوم',
    'الماجستير',
    'الدكتوراه',
    'بروفيسور',
    'ثانوية',
    'ابتدائي',
    'متوسط',
    'أمي',
  ];
  final List<String> _islam = [
    'ملتزمـ / ـة جدا',
    'ملتزمـ / ـة',
    'محافظ  / ـة',
    'وسطي / ـة التدين',
    'غير ملتزمـ / ـة',
  ];
  final List<String> _perspective = ['نعم', 'لا', 'بعد مقابلة الأهل'];
  final List<String> _weight = ["50-60", "61-70", "71-80", "81-90", "91-100"];
  final List<String> _height = [
    "150-160 cm",
    "161-170 cm",
    "171-180 cm",
    "181-190 cm",
    "191-200 cm",
  ];
  final List<String> _income = [
    "0-5000 SAR",
    "5001-10000 SAR",
    "10001-15000 SAR",
    "15001-20000 SAR",
    "20001+",
  ];
  final List<String> _whatAreYouLookingFor = [
    "معلن",
    "غير معلن",
    "حسب رغبة الطرف الاخر",
  ];
}
