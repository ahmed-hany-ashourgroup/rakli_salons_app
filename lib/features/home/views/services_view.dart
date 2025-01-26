import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rakli_salons_app/core/customs/custom_search_field.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';
import 'package:rakli_salons_app/core/utils/app_router.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';
import 'package:rakli_salons_app/features/home/data/models/models/service_model.dart';
import 'package:rakli_salons_app/features/home/views/widgets/service_item.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ServiceModel> services = [
      ServiceModel(
        title: "Hair",
        price: 50,
        gender: Gender.male,
        description:
            " Lorem ipsum dolor sit amet consectetur adipisicing elit. Quos, quidem.",
        state: ServiceState.active,
      ),
      ServiceModel(
        title: "Hair",
        price: 50,
        gender: Gender.male,
        description:
            " Lorem ipsum dolor sit amet consectetur adipisicing elit. Quos, quidem.",
        state: ServiceState.active,
      ),
      ServiceModel(
        title: "Hair",
        price: 50,
        gender: Gender.male,
        description:
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quos, quidem.",
        state: ServiceState.active,
      ),
      ServiceModel(
        title: "Hair",
        price: 50,
        gender: Gender.male,
        description:
            "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quos, quidem.",
        state: ServiceState.active,
      ),
    ];
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
            Text(
              "Services",
              style: AppStyles.bold20,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ServicetItem(serviceModel: services[index]);
                },
              ),
            ),
          ],
        ),
      ),
      // Add a Floating Action Button (FAB) to add a new service
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 82),
        child: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).push(
              AppRouter.kAddEditServiceView,
              extra: {'isEditMode': false},
            );
          },
          backgroundColor: kPrimaryColor, // Use your primary color
          child: const Icon(
            Icons.add,
            color: Colors.white, // Icon color
          ),
        ),
      ),
    );
  }
}
