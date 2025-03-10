import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasebak_app/_base/widgets/base_stateful_screen_widget.dart';
import 'package:nasebak_app/features/notifications/bloc/notifications_bloc.dart';
import 'package:nasebak_app/features/notifications/bloc/notifications_repository.dart';
import 'package:nasebak_app/features/notifications/model/notification_ui_model.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/empty/empty_widgets.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => NotificationsBloc(
            notificationsRepository: NotificationsRepository(),
          ),
      child: const NotificationScreenWithBloc(),
    );
  }
}

class NotificationScreenWithBloc extends BaseStatefulScreenWidget {
  const NotificationScreenWithBloc({super.key});

  @override
  BaseScreenState<NotificationScreenWithBloc> baseScreenCreateState() =>
      _NotificationScreenWithBlocState();
}

class _NotificationScreenWithBlocState
    extends BaseScreenState<NotificationScreenWithBloc> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_getVipMembershipDataEvent);
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        scrolledUnderElevation: .1,
      ),
      body: BlocListener<NotificationsBloc, NotificationsState>(
        listener: (context, state) {
          if (state is NotificationsLoadingState) {
            showLoading();
          } else {
            hideLoading();
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
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        if (state is LoadedNotificationsSuccessfullyState) {
          return _pageContent(state.notificationsList);
        } else {
          return const EmptyWidget();
        }
      },
    );
  }

  Widget _pageContent(List<NotificationUiModel> notifications) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                notifications.isNotEmpty
                    ? ListView.separated(
                      itemCount: notifications.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return _notificationTile(notification);
                      },
                    )
                    : _noNotificationsWidget(),
          ),
        ],
      ),
    );
  }

  Widget _notificationTile(NotificationUiModel notification) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: notification.readAt == null ? Colors.white : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.message,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.time,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (notification.readAt == null)
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.colorPrimary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _noNotificationsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssetPaths.noNotifications),
          SizedBox(height: 32),
          Text(
            context.translate(LocalizationKeys.noNotifications),
            style: context.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            context.translate(LocalizationKeys.dearClientNoNotifications),
            style: context.bodyLarge!.copyWith(
              color: Colors.white.withValues(alpha: 0.67),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Helper methods ///////////////////////
  ///////////////////////////////////////////////////////////

  NotificationsBloc get currentBloc => context.read<NotificationsBloc>();

  void _getVipMembershipDataEvent() {
    currentBloc.add(GetNotificationsDataEvent());
  }
}
