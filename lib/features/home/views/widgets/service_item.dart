import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_confirmation_dialog.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';
import 'package:rakli_salons_app/features/home/data/models/service_model.dart';

class ServicetItem extends StatefulWidget {
  final ServiceModel serviceModel;

  const ServicetItem({super.key, required this.serviceModel});

  @override
  _AppointmentItemState createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<ServicetItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color _getStatusColor(ServiceState status) {
    switch (status) {
      case ServiceState.active:
        return Colors.green;
      case ServiceState.inactive:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Service Name, Price, and Icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Service Name and Price
                Row(
                  children: [
                    Text(
                      widget.serviceModel.title ?? "Unknown",
                      style: AppStyles.bold22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "\$${widget.serviceModel.price?.toStringAsFixed(0) ?? "0"}",
                      style: AppStyles.bold16,
                    ),
                  ],
                ),
                // Icons (Edit and Close)
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        GoRouter.of(context).push(
                          AppRouter.kAddEditServiceView,
                          extra: {
                            "service": widget.serviceModel,
                            "isEditMode": true
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        showCustomConfirmationDialog(
                          context: context,
                          title: "Delete Service",
                          message:
                              "Are you sure you want to delete this service? This action is permanent and cannot be undone. All associated data will be permanently removed.",
                          confirmButtonText: "Delete Service",
                          onConfirm: () {},
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            // Service Description
            SizedBox(
              width: SizeConfig.screenwidth! * 0.8,
              child: Text(
                widget.serviceModel.description ?? "Unknown",
                style: AppStyles.regular14,
                maxLines: 4,
              ),
            ),
            // Service State
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
                      widget.serviceModel.state ?? ServiceState.inactive),
                ),
                const SizedBox(width: 4),
                DropdownButton<ServiceState>(
                  alignment: AlignmentDirectional.centerStart,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.black,
                  selectedItemBuilder: (context) => List.generate(4, (index) {
                    return DropdownMenuItem<AppointmentStatus>(
                      child: Text(
                        widget.serviceModel.state?.name ?? "",
                        style:
                            AppStyles.regular14.copyWith(color: Colors.black),
                      ),
                    );
                  }),
                  iconSize: 24,
                  value: widget.serviceModel.state,
                  underline: const SizedBox(), // Removes the default underline
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: const Color(0xFF8B1818),
                  style: AppStyles.regular14,
                  items: ServiceState.values.map((status) {
                    return DropdownMenuItem<ServiceState>(
                      value: status,
                      child: Text(
                        status.name,
                        style: AppStyles.regular14.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (ServiceState? newStatus) {
                    if (newStatus != null) {
                      setState(() {
                        widget.serviceModel.state = newStatus;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
