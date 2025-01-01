// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:josiah_arising/PAGES/home.dart';



class DevotionalsPage extends StatefulWidget {
  @override
  _DevotionalsPageState createState() => _DevotionalsPageState();
}

class _DevotionalsPageState extends State<DevotionalsPage> with SingleTickerProviderStateMixin {
  String selectedFilter = 'ALL';
  final List<String> filters = ['ALL', 'YEAR', 'MONTH', 'DAY'];
  final List<Color> filterColors = [
    Colors.blue,
    Colors.red,
    Colors.orange,
    Colors.deepOrange
  ];

  // Animation controller
  late AnimationController _controller;
  late Animation<double> _animation;

  // Selected values for dropdowns
  String? selectedYear;
  String? selectedMonth;
  String? selectedDay;

  // Error states
  String? yearError;
  String? monthError;
  String? dayError;

  // Generate list of years from 2014 to 2024
  final List<String> years = List.generate(11, (index) => (2024 - index).toString());
  
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Sample devotionals data
  late List<Devotional> allDevotionals;
  List<Devotional> filteredDevotionals = [];

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Initialize sample data
    allDevotionals = List.generate(20, (index) {
      return Devotional(
        title: 'Devotional ${index + 1}',
        date: DateTime(2024 - (index ~/ 12), (index % 12) + 1, (index % 28) + 1),
        imageUrl: 'assets/devotional$index.jpg',
        content: 'Sample content for devotional ${index + 1}',
      );
    });

    filteredDevotionals = List.from(allDevotionals);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to get days based on selected month and year
  List<String> getDaysInMonth() {
    if (selectedMonth == null || selectedYear == null) return [];

    int daysInMonth = 31;
    int monthIndex = months.indexOf(selectedMonth!) + 1;
    int year = int.parse(selectedYear!);
    
    daysInMonth = DateTime(year, monthIndex + 1, 0).day;
    return List.generate(daysInMonth, (index) => (index + 1).toString().padLeft(2, '0'));
  }

  // Function to filter devotionals
  void filterDevotionals() {
    setState(() {
      if (selectedFilter == 'ALL') {
        filteredDevotionals = List.from(allDevotionals);
        return;
      }

      filteredDevotionals = allDevotionals.where((devotional) {
        bool matches = true;
        
        if (selectedYear != null) {
          matches = matches && devotional.date.year.toString() == selectedYear;
        }
        
        if (selectedMonth != null) {
          matches = matches && months[devotional.date.month - 1] == selectedMonth;
        }
        
        if (selectedDay != null) {
          matches = matches && devotional.date.day.toString().padLeft(2, '0') == selectedDay;
        }
        
        return matches;
      }).toList();
    });
  }

  // Validation function
  bool validateSelections() {
    bool isValid = true;
    
    setState(() {
      yearError = null;
      monthError = null;
      dayError = null;

      if (selectedFilter != 'ALL') {
        if (selectedYear == null) {
          yearError = 'Please select a year';
          isValid = false;
        }

        if ((selectedFilter == 'MONTH' || selectedFilter == 'DAY') && selectedMonth == null) {
          monthError = 'Please select a month';
          isValid = false;
        }

        if (selectedFilter == 'DAY' && selectedDay == null) {
          dayError = 'Please select a day';
          isValid = false;
        }
      }
    });

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Buttons Row with enhanced styling
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                filters.length,
                (index) => Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filters[index]),
                    selected: selectedFilter == filters[index],
                    onSelected: (bool selected) {
                      setState(() {
                        selectedFilter = filters[index];
                        if (filters[index] == 'ALL') {
                          selectedYear = null;
                          selectedMonth = null;
                          selectedDay = null;
                          _controller.reverse();
                        } else {
                          _controller.forward();
                        }
                        filterDevotionals();
                      });
                    },
                    backgroundColor: filterColors[index].withOpacity(0.1),
                    selectedColor: filterColors[index],
                    labelStyle: TextStyle(
                      color: selectedFilter == filters[index] 
                        ? Colors.white 
                        : filterColors[index],
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Animated Dropdown Section
        SizeTransition(
          sizeFactor: _animation,
          child: selectedFilter != 'ALL' ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    // Year Dropdown
                    if (selectedFilter == 'YEAR' || selectedFilter == 'MONTH' || selectedFilter == 'DAY')
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Year',
                                errorText: yearError,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              value: selectedYear,
                              items: years.map((String year) {
                                return DropdownMenuItem<String>(
                                  value: year,
                                  child: Text(year),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedYear = newValue;
                                  selectedMonth = null;
                                  selectedDay = null;
                                  filterDevotionals();
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                    // Month Dropdown
                    if (selectedFilter == 'MONTH' || selectedFilter == 'DAY')
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              inputDecorationTheme: InputDecorationTheme(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue, width: 2),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Month',
                                errorText: monthError,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              ),
                              value: selectedMonth,
                              items: months.map((String month) {
                                return DropdownMenuItem<String>(
                                  value: month,
                                  child: Text(month),
                                );
                              }).toList(),
                              onChanged: selectedYear == null ? null : (String? newValue) {
                                setState(() {
                                  selectedMonth = newValue;
                                  selectedDay = null;
                                  filterDevotionals();
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                    // Day Dropdown
                    if (selectedFilter == 'DAY')
                      Expanded(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.blue, width: 2),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Day',
                              errorText: dayError,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            value: selectedDay,
                            items: getDaysInMonth().map((String day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day),
                              );
                            }).toList(),
                            onChanged: (selectedYear == null || selectedMonth == null) 
                              ? null 
                              : (String? newValue) {
                                setState(() {
                                  selectedDay = newValue;
                                  filterDevotionals();
                                });
                              },
                          ),
                        ),
                      ),
                  ],
                ),
                if (filteredDevotionals.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'No devotionals found for selected date',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ) : SizedBox(),
        ),

        SizedBox(height: 16),

        // Grid of Devotionals
        Expanded(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: GridView.builder(
              key: ValueKey<int>(filteredDevotionals.length),
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredDevotionals.length,
              itemBuilder: (context, index) {
                final devotional = filteredDevotionals[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Handle devotional tap
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Icon(Icons.photo, size: 40, color: Colors.grey[600]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                devotional.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                DateFormat('MMM d, yyyy').format(devotional.date),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}