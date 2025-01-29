// Updated ServicesView
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_search_field.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/manager/get_services_cubit/get_services_cubit.dart';
import 'package:rakli_salons_app/features/home/views/widgets/service_item.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetServicesCubit()..fetchServices(),
      child: Scaffold(
        backgroundColor: const Color(0xffEFEFEF),
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: CustomSearchField(),
                  ),
                  const SizedBox(width: 12),
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
              Text(
                "Services",
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
                          ? const Center(
                              child: Text('No services available'),
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
      ),
    );
  }
}
