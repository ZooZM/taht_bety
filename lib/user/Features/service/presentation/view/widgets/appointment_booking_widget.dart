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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.02,
        horizontal: screenWidth * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.02),
          _buildDateSelector(screenHeight),
          SizedBox(height: screenHeight * 0.02),
          _buildTimeSelector(screenWidth),
          SizedBox(height: screenHeight * 0.03),
          _buildBookButton(),
        ],
      ),
    );
  }

  Widget _buildDateSelector(double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a Day',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: screenHeight * 0.01),
        SizedBox(
          height: screenHeight * 0.4, // Adjust height dynamically
          child: PageView(
            controller: _pageController,
            children: [
              _buildMonthCalendar(DateTime.now(), screenHeight),
              _buildMonthCalendar(
                  DateTime(DateTime.now().year, DateTime.now().month + 1, 1),
                  screenHeight),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthCalendar(DateTime month, double screenHeight) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday;
    final monthName = DateFormat('MMMM yyyy').format(firstDayOfMonth);
    final weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

    List<Widget> dayWidgets = [];

    // Add empty spaces for days before the 1st of the month
    for (int i = 1; i < startingWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Add day numbers
    for (int day = 1; day <= daysInMonth; day++) {
      final currentDate = DateTime(month.year, month.month, day);
      final isSelected = _selectedDate != null &&
          _selectedDate!.year == currentDate.year &&
          _selectedDate!.month == currentDate.month &&
          _selectedDate!.day == currentDate.day;

      final isPastDate = currentDate
          .isBefore(DateTime.now().subtract(const Duration(days: 1)));

      dayWidgets.add(
        GestureDetector(
          onTap: isPastDate
              ? null // إذا كان اليوم في الماضي، اجعل العنصر غير قابل للنقر
              : () {
                  setState(() {
                    _selectedDate = currentDate;
                  });
                },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? kLightBlue
                  : isPastDate
                      ? Colors.grey.shade300 // لون مختلف للأيام السابقة
                      : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : isPastDate
                          ? Colors.grey // لون النص للأيام السابقة
                          : Colors.black,
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 7 أيام في الأسبوع
            childAspectRatio: 38 * 38 / screenHeight, // نسبة العرض إلى الارتفاع
          ),
          itemCount: weekdays.length + dayWidgets.length,
          itemBuilder: (context, index) {
            if (index < weekdays.length) {
              // عرض أسماء الأيام في الصف الأول
              return Center(
                child: Text(
                  weekdays[index],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              );
            } else {
              // عرض الأيام
              return dayWidgets[index - weekdays.length];
            }
          },
        ),
      ],
    );
  }

  Widget _buildTimeSelector(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select a Time',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _availableTimes.length,
            itemBuilder: (context, index) {
              final time = _availableTimes[index];
              final isSelected = _selectedTime == time;
              return Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.03),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
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
                        time,
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
