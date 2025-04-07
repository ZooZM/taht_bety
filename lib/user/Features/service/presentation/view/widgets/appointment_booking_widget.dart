import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taht_bety/constants.dart';
import 'package:taht_bety/user/Features/service/presentation/view/widgets/book_service.dart';

class AppointmentBookingWidget extends StatefulWidget {
  final Function(DateTime, String) onBookAppointment;
  final bool isLoading;

  const AppointmentBookingWidget({
    Key? key,
    required this.onBookAppointment,
    required this.isLoading,
  }) : super(key: key);

  @override
  _AppointmentBookingWidgetState createState() =>
      _AppointmentBookingWidgetState();
}

class _AppointmentBookingWidgetState extends State<AppointmentBookingWidget> {
  DateTime? _selectedDate;
  String? _selectedTime;
  final List<String> _availableTimes = [
    '8:00 AM',
    '10:00 AM',
    '12:00 PM',
    '2:00 PM',
    '4:00 PM',
    '6:00 PM',
  ];
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildDateSelector(),
          const SizedBox(height: 20),
          _buildTimeSelector(),
          const SizedBox(height: 30),
          _buildBookButton(),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a Day',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300, // Fixed height for the calendar view
          child: PageView(
            controller: _pageController,
            children: [
              _buildMonthCalendar(DateTime.now()),
              _buildMonthCalendar(
                  DateTime(DateTime.now().year, DateTime.now().month + 1, 1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthCalendar(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday;
    final monthName = DateFormat('MMMM yyyy').format(firstDayOfMonth);
    final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    List<Widget> dayWidgets = [];

    // Add empty spaces for days before the 1st of the month
    for (int i = 1; i < startingWeekday; i++) {
      dayWidgets.add(const SizedBox(width: 40, height: 40));
    }

    // Add day numbers
    for (int day = 1; day <= daysInMonth; day++) {
      final currentDate = DateTime(month.year, month.month, day);
      final isSelected = _selectedDate != null &&
          _selectedDate!.year == currentDate.year &&
          _selectedDate!.month == currentDate.month &&
          _selectedDate!.day == currentDate.day;

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = currentDate;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? kLightBlue : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Text(
          monthName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekdays.map((day) {
            return SizedBox(
              width: 40,
              child: Center(
                child: Text(
                  day,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: dayWidgets,
        ),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a Time',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _availableTimes.length - 1,
            itemBuilder: (context, index) {
              final time = _availableTimes[index];
              final nTime = _availableTimes[index + 1];
              final isSelected = _selectedTime == time;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.black : kLightBlue,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "$time   $nTime",
                        style: TextStyle(
                          color: isSelected ? Colors.black : kLightBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    final isEnabled = _selectedDate != null && _selectedTime != null;

    return SizedBox(
      width: double.infinity,
      child: BookService(
        price: "123",
        onTap: isEnabled
            ? () {
                widget.onBookAppointment(_selectedDate!, _selectedTime!);
              }
            : () {},
        isEnable: isEnabled,
        isLoading: widget.isLoading,
      ),
    );
  }
}
