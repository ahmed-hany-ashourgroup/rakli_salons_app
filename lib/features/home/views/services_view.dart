// Updated ServicesView
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/manager/get_services_cubit/get_services_cubit.dart';
import 'package:rakli_salons_app/features/home/views/widgets/service_item.dart';
import 'package:rakli_salons_app/generated/l10n.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<GetServicesCubit>().fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     const Expanded(
            //       child: CustomSearchField(),
            //     ),
            //     const SizedBox(width: 12),
            //     CircleAvatar(
            //       backgroundColor: kSecondaryColor,
            //       child: IconButton(
            //         onPressed: () {
            //           GoRouter.of(context).push(AppRouter.kFilterView);
            //         },
            //         icon: Icon(
            //           Icons.filter_alt,
            //           color: kPrimaryColor,
            //           size: 28,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 32),
            Text(
              S.of(context).services,
              style: AppStyles.bold20,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<GetServicesCubit, GetServicesState>(
                builder: (context, state) {
                  if (state is GetServicesLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is GetServicesFailed) {
                    return Center(
                      child: Text(state.errMessage),
                    );
                  }

                  if (state is GetServicesSuccess) {
                    return state.services.isEmpty
                        ? Center(
                            child: Text(S.of(context).noServicesAvailable),
                          )
                        : ListView.builder(
                            itemCount: state.services.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FittedBox(
                                child: ServicetItem(
                                  serviceModel: state.services[index],
                                ),
                              );
                            },
                          );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 82),
        child: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push(
              AppRouter.kAddEditServiceView,
              extra: {'isEditMode': false},
            );
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
