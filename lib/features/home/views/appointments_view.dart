import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_search_field.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';
import 'package:rakli_salons_app/features/home/views/widgets/appointment_item.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchField(),
            const SizedBox(height: 32),
            Text(
              "Today’s Appointments  >",
              style: AppStyles.bold20,
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
}
