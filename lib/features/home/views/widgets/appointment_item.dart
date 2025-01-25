import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/customs/custom_confirmation_dialog.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';

class AppointmentItem extends StatefulWidget {
  final Appointment appointment;

  const AppointmentItem({super.key, required this.appointment});

  @override
  _AppointmentItemState createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController =
        TextEditingController(text: widget.appointment.comment);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.pending:
        return Colors.orange;
      case AppointmentStatus.confirmed:
        return Colors.green;
      case AppointmentStatus.cancelled:
        return Colors.red;
      case AppointmentStatus.completed:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: SizeConfig.screenwidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Request User Name, Price, and Close Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Request User Name and Price
                  Row(
                    children: [
                      Text(
                        widget.appointment.requestUserName ?? "Unknown",
                        style: AppStyles.bold22,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "\$${widget.appointment.price?.toStringAsFixed(0) ?? "0"}",
                        style: AppStyles.bold16,
                      ),
                    ],
                  ),
                  // Close Icon
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      showCustomConfirmationDialog(
                        context: context,
                        title: "Delete Appointment",
                        message:
                            "Are you sure you want to delete this Appointment? This action is permanent and cannot be undone. All associated data will be permanently removed.",
                        confirmButtonText: "Delete Appointment",
                        onConfirm: () {},
                      );
                    },
                  ),
                ],
              ),
              // Services
              Text(
                "Services: Hair, Body Massage",
                style: AppStyles.regular14,
              ),
              // Time
              Text(
                "Time: ${TimeOfDay.fromDateTime(widget.appointment.date ?? DateTime.now()).format(context)}",
                style: AppStyles.regular14,
              ),
              // State and Dropdown
              Row(
                children: [
                  Text(
                    "State: ",
                    style: AppStyles.regular14,
                  ),
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: _getStatusColor(
                        widget.appointment.status ?? AppointmentStatus.pending),
                  ),
                  const SizedBox(width: 4),
                  DropdownButton<AppointmentStatus>(
                    alignment: AlignmentDirectional.centerStart,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.black,
                    selectedItemBuilder: (context) => List.generate(4, (index) {
                      return DropdownMenuItem<AppointmentStatus>(
                        child: Text(
                          widget.appointment.status?.name ?? "",
                          style:
                              AppStyles.regular14.copyWith(color: Colors.black),
                        ),
                      );
                    }),
                    iconSize: 24,
                    value: widget.appointment.status,
                    underline:
                        const SizedBox(), // Removes the default underline
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownColor: const Color(0xFF8B1818),
                    style: AppStyles.regular14,
                    items: AppointmentStatus.values.map((status) {
                      return DropdownMenuItem<AppointmentStatus>(
                        value: status,
                        child: Text(
                          status.name,
                          style: AppStyles.regular14.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (AppointmentStatus? newStatus) {
                      if (newStatus != null) {
                        setState(() {
                          widget.appointment.status = newStatus;
                        });
                      }
                    },
                  ),
                ],
              ),
              // Comment TextField
              TextField(
                controller: _commentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  fillColor: const Color(0xffD9D9D9),
                  suffixIcon: IconButton(
                      onPressed:
                          _commentController.text.isNotEmpty ? () {} : null,
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      )),
                  filled: true,
                  prefixIcon: Icon(Icons.comment, color: Colors.grey),
                  hintText: " Add a comment",
                  hintStyle: AppStyles.regular14.copyWith(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
