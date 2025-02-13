import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';
import 'package:rakli_salons_app/features/home/manager/get_appointments_cubit/get_appointments_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/update_appointment_state_cubit/update_appointment_state_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class AppointmentItem extends StatefulWidget {
  final AppointmentsModel appointment;

  const AppointmentItem({super.key, required this.appointment});

  @override
  State<AppointmentItem> createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  late AppointmentStatus currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.appointment.status;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateAppointmentStateCubit(),
        ),
        BlocProvider(
          create: (context) => GetAppointmentsCubit(),
        ),
      ],
      child: BlocConsumer<UpdateAppointmentStateCubit,
          UpdateAppointmentStateState>(
        listener: (context, state) {
          if (state is UpdateAppointmentStateSuccess) {
            // Update the local state immediately
            setState(() {
              currentStatus = state.updatedState == 'accepted'
                  ? AppointmentStatus.accepted
                  : AppointmentStatus.rejected;
            });

            Fluttertoast.showToast(
              msg: S.of(context).appointmentStatusUpdated,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            // Refresh appointments list in background
            context.read<GetAppointmentsCubit>().fetchAppointments();
          } else if (state is UpdateAppointmentStateFailed) {
            Fluttertoast.showToast(
              msg: state.errMessage,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
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
                            widget.appointment.requestUserName ??
                                S.of(context).unknownCustomer,
                            style: AppStyles.bold16,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            S
                                .of(context)
                                .bookingId(widget.appointment.id.toString()),
                            style: AppStyles.regular14
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      if (currentStatus == AppointmentStatus.pending)
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: state is UpdateAppointmentStateLoading
                                  ? null
                                  : () {
                                      context
                                          .read<UpdateAppointmentStateCubit>()
                                          .updateState(
                                            appointmentId: widget.appointment.id
                                                .toString(),
                                            state: 'accepted',
                                          );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                S.of(context).accept,
                                style: AppStyles.medium14
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: state is UpdateAppointmentStateLoading
                                  ? null
                                  : () {
                                      context
                                          .read<UpdateAppointmentStateCubit>()
                                          .updateState(
                                            appointmentId: widget.appointment.id
                                                .toString(),
                                            state: 'rejected',
                                          );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                S.of(context).reject,
                                style: AppStyles.medium14
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color:
                                _getStatusColor(currentStatus).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStatusText(currentStatus),
                            style: AppStyles.medium14.copyWith(
                                color: _getStatusColor(currentStatus)),
                          ),
                        ),
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

  Widget _buildAppointmentDetails() {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
          icon: Icons.calendar_today,
          label: S.of(context).dateLabel,
          value: dateFormat.format(widget.appointment.date),
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          icon: Icons.access_time,
          label: S.of(context).time,
          value: timeFormat.format(widget.appointment.date),
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          icon: Icons.attach_money,
          label: S.of(context).total,
          value:
              '${S.of(context).currencySymbol}${widget.appointment.price.toStringAsFixed(2)}',
        ),
        if (widget.appointment.comment != null) ...[
          const SizedBox(height: 8),
          _buildDetailRow(
            icon: Icons.comment,
            label: S.of(context).comment,
            value: widget.appointment.comment!,
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

  String _getStatusText(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return S.of(context).pending.toUpperCase();
      case AppointmentStatus.accepted:
        return S.of(context).completed.toUpperCase();
      case AppointmentStatus.rejected:
        return S.of(context).canceled.toUpperCase();
    }
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Colors.orange;
      case AppointmentStatus.accepted:
        return Colors.blue;
      case AppointmentStatus.rejected:
        return Colors.red;
    }
  }
}
