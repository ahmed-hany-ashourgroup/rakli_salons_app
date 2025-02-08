import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';
import 'package:rakli_salons_app/features/home/manager/get_appointments_cubit/get_appointments_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/update_appointment_state_cubit/update_appointment_state_cubit.dart';

class AppointmentItem extends StatelessWidget {
  final AppointmentsModel appointment;

  const AppointmentItem({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateAppointmentStateCubit(),
      child: BlocConsumer<UpdateAppointmentStateCubit,
          UpdateAppointmentStateState>(
        listener: (context, state) {
          if (state is UpdateAppointmentStateSuccess) {
            // Refresh appointments list
            context.read<GetAppointmentsCubit>().fetchAppointments();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Appointment status updated successfully')),
            );
          } else if (state is UpdateAppointmentStateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.requestUserName ?? 'Unknown Customer',
                            style: AppStyles.bold16,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Booking ID: #${appointment.id}',
                            style: AppStyles.regular14
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      _buildStatusDropdown(context, state),
                    ],
                  ),
                  const Divider(height: 24),
                  _buildAppointmentDetails(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusDropdown(
      BuildContext context, UpdateAppointmentStateState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: appointment.status.name.toLowerCase() ?? 'pending',
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: AppStyles.medium14.copyWith(color: _getStatusColor()),
          onChanged: (state is UpdateAppointmentStateLoading)
              ? null
              : (String? newValue) {
                  if (newValue != null) {
                    context.read<UpdateAppointmentStateCubit>().updateState(
                          appointmentId: appointment.id.toString(),
                          state: newValue,
                        );
                  }
                },
          items: ['pending', 'confirmed', 'completed', 'cancelled']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.toUpperCase()),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAppointmentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          icon: Icons.calendar_today,
          label: 'Date',
          value: DateFormat('MMM dd, yyyy').format(appointment.date),
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          icon: Icons.access_time,
          label: 'Time',
          value: DateFormat('hh:mm a').format(appointment.date),
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          icon: Icons.attach_money,
          label: 'Total',
          value: '\$${appointment.price.toStringAsFixed(2)}',
        ),
        if (appointment.comment != null) ...[
          const SizedBox(height: 8),
          _buildDetailRow(
            icon: Icons.comment,
            label: 'Comment',
            value: appointment.comment!,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: AppStyles.regular14.copyWith(color: Colors.grey),
        ),
        Expanded(
          child: Text(
            value,
            style: AppStyles.medium14,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (appointment.status.name.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
