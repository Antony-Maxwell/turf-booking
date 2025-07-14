import 'package:assessment/utils/dummy_data.dart';
import 'package:flutter/material.dart';

class TurfCard extends StatelessWidget {
  final Turf turf;
  final bool isSelected;
  final VoidCallback onTap;
  final String? selectedTimeSlot;
  final Function(String) onTimeSlotSelected;

  const TurfCard({
    Key? key,
    required this.turf,
    required this.isSelected,
    required this.onTap,
    this.selectedTimeSlot,
    required this.onTimeSlotSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                turf.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox()
            ],
          ),
          const SizedBox(height: 8),
          
          Text(
            turf.formattedPrice,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          
          
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: turf.timeSlots.length,
                itemBuilder: (context, index) {
                  final timeSlot = turf.timeSlots[index];
                  final isSlotSelected = selectedTimeSlot == timeSlot.time;
                  
                  return GestureDetector(
                    onTap: timeSlot.isAvailable 
                        ? () => onTimeSlotSelected(timeSlot.time)
                        : null,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSlotSelected 
                            ? Colors.blue
                            : timeSlot.isAvailable 
                                ? Colors.white
                                : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSlotSelected
                              ? Colors.blue
                              : timeSlot.isAvailable
                                  ? Colors.grey[300]!
                                  : Colors.grey[400]!,
                        ),
                      ),
                      child: Text(
                        timeSlot.time,
                        style: TextStyle(
                          color: isSlotSelected
                              ? Colors.white
                              : timeSlot.isAvailable
                                  ? Colors.black
                                  : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
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