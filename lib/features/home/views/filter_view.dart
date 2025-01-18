import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rakli_salons_app/core/utils/app_styles.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  DateTime selectedDate = DateTime.now();
  String selectedDateRange = 'daily'; // daily, weekly, monthly, yearly
  List<String> selectedServices = ['Skin Care', 'Body Treatments'];
  String selectedState = 'Pending';
  String selectedGender = 'female';

  // Generate days for the selected date range
  List<DateTime> _getDaysInRange() {
    final List<DateTime> days = [];
    DateTime startDate;

    switch (selectedDateRange) {
      case 'daily':
        startDate = selectedDate.subtract(Duration(days: 2));
        for (int i = 0; i < 5; i++) {
          days.add(startDate.add(Duration(days: i)));
        }
        break;
      case 'weekly':
        startDate =
            selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        for (int i = 0; i < 7; i++) {
          days.add(startDate.add(Duration(days: i)));
        }
        break;
      case 'monthly':
        startDate = DateTime(selectedDate.year, selectedDate.month, 1);
        final lastDay =
            DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
        for (int i = 1; i <= lastDay; i++) {
          days.add(DateTime(selectedDate.year, selectedDate.month, i));
        }
        break;
      case 'yearly':
        for (int i = 1; i <= 12; i++) {
          days.add(DateTime(selectedDate.year, i, 1));
        }
        break;
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Bar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Filter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedServices = [];
                        selectedState = '';
                        selectedGender = '';
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),

              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 20),

                    // Date Section
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Date display
                    Row(
                      children: [
                        Text(
                          DateFormat('yyyy / MM / dd').format(selectedDate),
                          style: const TextStyle(fontSize: 14),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () {
                            setState(() {
                              selectedDate = selectedDate
                                  .subtract(const Duration(days: 1));
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            setState(() {
                              selectedDate =
                                  selectedDate.add(const Duration(days: 1));
                            });
                          },
                        ),
                      ],
                    ),

                    // Date selection
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _getDaysInRange().map((date) {
                          final bool isSelected =
                              DateUtils.isSameDay(date, selectedDate);
                          final dayLabel = selectedDateRange == 'yearly'
                              ? DateFormat('MMM').format(date)
                              : selectedDateRange == 'monthly'
                                  ? date.day.toString()
                                  : DateFormat('EEE\nd').format(date);

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF8B1F1F)
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    dayLabel,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Services Section
                    Text('Services', style: AppStyles.bold22),
                    _buildCheckboxListTile('Skin Care'),
                    _buildCheckboxListTile('Hair Services'),
                    _buildCheckboxListTile('Makeup Services'),
                    _buildCheckboxListTile('Body Treatments'),
                    _buildCheckboxListTile('Nail Services'),

                    const SizedBox(height: 24),

                    // State Section
                    Text('State', style: AppStyles.bold22),
                    _buildRadioListTile('Pending', 'state'),
                    _buildRadioListTile('Confirmed', 'state'),
                    _buildRadioListTile('Completed', 'state'),
                    _buildRadioListTile('Cancelled', 'state'),

                    const SizedBox(height: 24),

                    // Gender Section
                    Text('Gender', style: AppStyles.bold22),
                    Row(
                      children: [
                        _buildRadioOption('Male', 'gender'),
                        const SizedBox(width: 20),
                        _buildRadioOption('female', 'gender'),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Apply Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    // Apply filters action
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B1F1F),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckboxListTile(String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            if (selectedServices.contains(title)) {
              selectedServices.remove(title);
            } else {
              selectedServices.add(title);
            }
          });
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selectedServices.contains(title)
                  ? Colors.transparent
                  : Colors.grey,
            ),
            color: selectedServices.contains(title)
                ? const Color(0xFF8B1F1F)
                : Colors.transparent,
          ),
          child: selectedServices.contains(title)
              ? const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildRadioListTile(String title, String group) {
    final isSelected =
        group == 'state' ? selectedState == title : selectedGender == title;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: GestureDetector(
        onTap: () {
          setState(() {
            if (group == 'state') {
              selectedState = title;
            } else {
              selectedGender = title;
            }
          });
        },
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey,
            ),
            color: isSelected ? const Color(0xFF8B1F1F) : Colors.transparent,
          ),
          child: isSelected
              ? const Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title, String group) {
    final isSelected = group == 'gender' ? selectedGender == title : false;

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (group == 'gender') {
                selectedGender = title;
              }
            });
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.grey,
              ),
              color: isSelected ? const Color(0xFF8B1F1F) : Colors.transparent,
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }
}
