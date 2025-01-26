import 'package:flutter/material.dart';
import 'package:rakli_salons_app/core/theme/theme_constants.dart';

class CustomSearchField extends StatelessWidget {
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CustomSearchField({
    super.key,
    this.onTap,
    this.controller,
    this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF841919),
              Color(0xFFF0ECD7),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.search,
                  color: kSecondaryColor,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  enabled: onTap == null,
                  controller: controller,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 16,
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
