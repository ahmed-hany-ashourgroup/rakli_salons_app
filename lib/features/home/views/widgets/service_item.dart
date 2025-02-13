import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_confirmation_dialog.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/core/utils/size_config.dart';
import 'package:rakli_salons_app/features/home/data/models/appointment_model.dart';
import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';
import 'package:rakli_salons_app/features/home/manager/delete_service_cubit/delete_service_cubit.dart';
import 'package:rakli_salons_app/features/home/manager/get_services_cubit/get_services_cubit.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

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
    return BlocProvider(
      create: (context) => DeleteServiceCubit(),
      child: BlocConsumer<DeleteServiceCubit, DeleteServiceState>(
        listener: (context, state) {
          if (state is DeleteServiceSuccess) {
            Fluttertoast.showToast(
              msg: S.of(context).serviceDeletedSuccessfully,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            // Refresh services list
            context.read<GetServicesCubit>().fetchServices();
            Navigator.pop(context); // Close the confirmation dialog
          } else if (state is DeleteServiceFailed) {
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
            margin: const EdgeInsets.only(bottom: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                            widget.serviceModel.title ?? S.of(context).unknown,
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
                                title: S.of(context).deleteService,
                                message:
                                    S.of(context).deleteServiceConfirmation,
                                confirmButtonText: S.of(context).deleteService,
                                onConfirm: () {
                                  if (widget.serviceModel.id != null) {
                                    context
                                        .read<DeleteServiceCubit>()
                                        .deleteService(
                                            widget.serviceModel.id.toString());
                                  }
                                },
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
                        S.of(context).state,
                        style: AppStyles.regular14,
                      ),
                      Icon(
                        Icons.circle,
                        size: 12,
                        color: _getStatusColor(widget.serviceModel.state),
                      ),
                      const SizedBox(width: 4),
                      DropdownButton<ServiceState>(
                        alignment: AlignmentDirectional.centerStart,
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.black,
                        selectedItemBuilder: (context) =>
                            List.generate(4, (index) {
                          return DropdownMenuItem<AppointmentStatus>(
                            child: Text(
                              widget.serviceModel.state.name,
                              style: AppStyles.regular14
                                  .copyWith(color: Colors.black),
                            ),
                          );
                        }),
                        iconSize: 24,
                        value: widget.serviceModel.state,
                        underline:
                            const SizedBox(), // Removes the default underline
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
        },
      ),
    );
  }
}
