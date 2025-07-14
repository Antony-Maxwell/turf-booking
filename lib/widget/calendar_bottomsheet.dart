
import 'package:flutter/material.dart';

class CalendarBottomSheet extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const CalendarBottomSheet({
    Key? key,
    this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  late DateTime selectedDate;
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate ?? DateTime.now();
    currentMonth = DateTime(selectedDate.year, selectedDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Header with close button
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 24), // For balance
                Text(
                  'Select Date',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close, size: 24),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Build multiple months
                  _buildMonth(currentMonth),
                  _buildMonth(DateTime(currentMonth.year, currentMonth.month + 1)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonth(DateTime month) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month header
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              '${_getMonthName(month.month)} ${month.year}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Days of week header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                .map((day) => Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ))
                .toList(),
          ),
          
          // Calendar grid
          _buildCalendarGrid(month),
          
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(DateTime month) {
    List<Widget> rows = [];
    
    // Get first day of month and number of days
    DateTime firstDay = DateTime(month.year, month.month, 1);
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    int startingWeekday = firstDay.weekday % 7; // Sunday = 0
    
    List<Widget> currentRow = [];
    
    // Add empty cells for days before the first day
    for (int i = 0; i < startingWeekday; i++) {
      currentRow.add(Container(width: 40, height: 40));
    }
    
    // Add days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDate = DateTime(month.year, month.month, day);
      bool isSelected = currentDate.day == selectedDate.day &&
          currentDate.month == selectedDate.month &&
          currentDate.year == selectedDate.year;
      
      currentRow.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = currentDate;
            });
            widget.onDateSelected(currentDate);
            Navigator.pop(context);
          },
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              '$day',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
      
      // If we have 7 days in the current row, add it to rows and start new row
      if (currentRow.length == 7) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: currentRow,
        ));
        currentRow = [];
      }
    }
    
    // Add remaining empty cells to complete the last row
    while (currentRow.length < 7) {
      currentRow.add(Container(width: 40, height: 40));
    }
    
    if (currentRow.isNotEmpty) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: currentRow,
      ));
    }
    
    return Column(children: rows);
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}