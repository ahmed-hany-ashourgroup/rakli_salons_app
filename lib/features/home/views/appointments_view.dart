import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_search_field.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';
import 'package:rakli_salons_app/features/home/views/widgets/appointment_item.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  _AppointmentsViewState createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  List<Appointment> appointments = [
    Appointment(
      requestUserName: "Saud Karim",
      status: AppointmentStatus.pending,
      price: 130,
      date: DateTime.now(),
      comment: null,
    ),
    Appointment(
      requestUserName: "Saud Karim",
      status: AppointmentStatus.cancelled,
      price: 130,
      date: DateTime.now(),
      comment: null,
    ),
    Appointment(
      requestUserName: "Saud Karim",
      status: AppointmentStatus.confirmed,
      price: 130,
      date: DateTime.now(),
      comment:
          "Lorem LoremLoremLorem loremIoremLoremLorem IoremIorem LoremLoremLoremLorem loremIoremLoremLoremLorem",
    ),
  ];

  ViewPeriod selectedPeriod = ViewPeriod.daily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEFEFEF),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Wrap CustomSearchField with Expanded
                Expanded(
                  child: CustomSearchField(),
                ),
                const SizedBox(
                    width: 12), // Add spacing between search field and button
                CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context).push(AppRouter.kFilterView);
                    },
                    icon: Icon(
                      Icons.filter_alt,
                      color: kPrimaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Clickable Text with Dropdown Menu
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
                      period.toString().split('.').last,
                      style: AppStyles.regular16.copyWith(color: Colors.white),
                    ),
                  );
                }).toList();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _getPeriodText(selectedPeriod),
                    style: AppStyles.bold20,
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_drop_down, size: 24),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return AppointmentItem(appointment: appointments[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to get the display text for the selected period
  String _getPeriodText(ViewPeriod period) {
    switch (period) {
      case ViewPeriod.daily:
        return "Today's Appointments";
      case ViewPeriod.weekly:
        return "This Week's Appointments";
      case ViewPeriod.monthly:
        return "This Month's Appointments";
      case ViewPeriod.yearly:
        return "This Year's Appointments";
    }
  }
}

enum ViewPeriod { daily, weekly, monthly, yearly }
