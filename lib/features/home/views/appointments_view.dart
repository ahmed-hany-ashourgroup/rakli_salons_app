import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';
import 'package:rakli_salons_app/features/home/manager/get_appointments_cubit/get_appointments_cubit.dart';
import 'package:rakli_salons_app/features/home/views/widgets/appointment_item.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  _AppointmentsViewState createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  late GetAppointmentsCubit _appointmentsCubit;
  ViewPeriod selectedPeriod = ViewPeriod.daily;

  @override
  void initState() {
    super.initState();
    _appointmentsCubit = GetAppointmentsCubit()..fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Expanded(child: CustomSearchField()),
            //     const SizedBox(width: 12),
            //     CircleAvatar(
            //       backgroundColor: kSecondaryColor,
            //       child: IconButton(
            //         onPressed: () {},
            //         icon:
            //             Icon(Icons.filter_alt, color: kPrimaryColor, size: 28),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 32),
            PopupMenuButton<ViewPeriod>(
              initialValue: ViewPeriod.daily,
              color: kPrimaryColor,
              onSelected: (ViewPeriod period) {
                setState(() {
                  selectedPeriod = period;
                });
              },
              itemBuilder: (BuildContext context) {
                return ViewPeriod.values.map((ViewPeriod period) {
                  return PopupMenuItem<ViewPeriod>(
                    value: period,
                    child: Text(
                      _getViewPeriodText(period),
                      style: AppStyles.regular16.copyWith(color: Colors.white),
                    ),
                  );
                }).toList();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_getPeriodText(selectedPeriod), style: AppStyles.bold20),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_drop_down, size: 24),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<GetAppointmentsCubit, GetAppointmentsState>(
                bloc: _appointmentsCubit,
                builder: (context, state) {
                  if (state is GetAppointmentsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetAppointmentsFailed) {
                    return Center(child: Text(state.errMessage));
                  } else if (state is GetAppointmentsSuccess) {
                    return Column(
                      children: [
                        SizedBox(
                          height: SizeConfig.screenhieght! * 0.7,
                          child: ListView.builder(
                            itemCount: state.appointments.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return AppointmentItem(
                                  appointment: state.appointments[index]);
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Center(child: Text(S.of(context).noAppointmentsFound));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPeriodText(ViewPeriod period) {
    switch (period) {
      case ViewPeriod.daily:
        return S.of(context).todaysAppointments;
      case ViewPeriod.weekly:
        return S.of(context).thisWeeksAppointments;
      case ViewPeriod.monthly:
        return S.of(context).thisMonthsAppointments;
      case ViewPeriod.yearly:
        return S.of(context).thisYearsAppointments;
    }
  }

  String _getViewPeriodText(ViewPeriod period) {
    switch (period) {
      case ViewPeriod.daily:
        return S.of(context).daily;
      case ViewPeriod.weekly:
        return S.of(context).weekly;
      case ViewPeriod.monthly:
        return S.of(context).monthly;
      case ViewPeriod.yearly:
        return S.of(context).yearly;
    }
  }
}

enum ViewPeriod { daily, weekly, monthly, yearly }
