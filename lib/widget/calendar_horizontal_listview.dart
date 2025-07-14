import 'package:assessment/widget/calendar_bottomsheet.dart';
import 'package:flutter/material.dart';

class HorizontalCalendar extends StatefulWidget {
 final VoidCallback? onDateTapped;
  final Function(DateTime)? onDateSelected; 

  const HorizontalCalendar({
    Key? key, 
    this.onDateTapped,
    this.onDateSelected, 
  }) : super(key: key);

  @override
  State<HorizontalCalendar> createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  int selectedDay = 1;
  final DateTime currentDate = DateTime(2025, 7, 14);
  DateTime selectedDate = DateTime.now();

  void _showCalendarBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CalendarBottomSheet(
        selectedDate: selectedDate,
        onDateSelected: (date) {
          setState(() {
            selectedDate = date;
          });
          widget.onDateSelected?.call(date);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month/Year Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'July 2025',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: _showCalendarBottomSheet,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Horizontal Calendar
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 30,
              itemBuilder: (context, index) {
                final day = index + 1;
                final dayOfWeek = DateTime(2025, 6, day).weekday;
                final dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                final dayName = dayNames[dayOfWeek - 1];

                final isSelected = day == selectedDay;
                final isToday = day == 8;

                return GestureDetector(
                  onTap: () {
                    if (selectedDay != day) {
                      setState(() {
                        selectedDay = day;
                      });
                      final selectedDateTime = DateTime(2025, 7, day);
            
            widget.onDateTapped?.call();
            widget.onDateSelected?.call(selectedDateTime);
                    } else {
                      setState(() {
                        selectedDay = day;
                      });
                    }
                  },
                  child: Container(
                    width: 50,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black87 : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayName,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$day',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
