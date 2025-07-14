import 'package:assessment/presentation/success.dart';
import 'package:assessment/utils/dummy_data.dart';
import 'package:assessment/widget/calendar_bottomsheet.dart';
import 'package:assessment/widget/calendar_horizontal_listview.dart';
import 'package:assessment/widget/turf_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int teamSize = 12;
  late TurfBookingData turfData;
  int selectedTurfIndex = 0;
  String? selectedTimeSlot;
  DateTime? selectedDate;

  List<Turf> shuffledTurfs = [];

  void _shuffleTurfs() {
    setState(() {
      shuffledTurfs.shuffle();
      selectedTurfIndex = 0;
      selectedTimeSlot = null;
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    turfData = TurfDataService.getSampleData();
    shuffledTurfs = List.from(turfData.turfs);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back),
                    const SizedBox(width: 20),
                    Text(
                      "Book your slot",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade500),
              noOfPlayersWidget(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: const Divider(),
              ),
              SizedBox(
                height: 180,
                width: double.infinity,
                child: HorizontalCalendar(
                  onDateTapped: _shuffleTurfs,
                  onDateSelected: _onDateSelected,
                ),
              ),
              Divider(color: Colors.grey.shade500),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: shuffledTurfs.length,
                itemBuilder: (context, index) {
                  final turf = shuffledTurfs[index];
                  return TurfCard(
                    turf: turf,
                    isSelected: selectedTurfIndex == index,
                    onTap: () {
                      setState(() {
                        selectedTurfIndex = index;
                        selectedTimeSlot = null;
                      });
                    },
                    selectedTimeSlot: selectedTimeSlot,
                    onTimeSlotSelected: (timeSlot) {
                      setState(() {
                        selectedTimeSlot = timeSlot;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: selectedTimeSlot?.isNotEmpty ?? false
            ? Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.black)),
                ),
                height: 110,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (selectedTimeSlot?.isNotEmpty ?? false)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Team Size: $teamSize players",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            if (selectedTimeSlot != null) ...[
                              SizedBox(height: 4),
                              Text(
                                "Time Slot: $selectedTimeSlot",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ],
                            if (selectedDate != null) ...[
                              SizedBox(height: 4),
                              Text(
                                "Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ],
                        ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessScreen(),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red[400],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Reserve Slot",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SizedBox(),
      ),
    );
  }

  Padding noOfPlayersWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: ListTile(
        title: Text(
          "No of players",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Team of $teamSize"),
        trailing: GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, setDialogState) => AlertDialog(
                title: Text("Adjust your team size"),
                content: Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Your current team is sized to"),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (teamSize > 1) {
                                setDialogState(() {
                                  teamSize = teamSize - 1;
                                });
                                setState(() {});
                              }
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.remove_outlined),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Text(
                            teamSize.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                teamSize = teamSize + 1;
                              });
                              setState(() {});
                            },
                            child: CircleAvatar(child: Icon(Icons.add)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Done"),
                  ),
                ],
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.grey.shade500),
            ),
            child: Center(child: Icon(Icons.tune)),
          ),
        ),
      ),
    );
  }
}
