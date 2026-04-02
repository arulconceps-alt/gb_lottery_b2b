import 'package:flutter/material.dart';

class NotificationFilterChips extends StatefulWidget {
  final double Function(double) s;
  final List<String> filters;
  final Function(String) onChanged;

  const NotificationFilterChips({
    super.key,
    required this.s,
    required this.filters,
    required this.onChanged,
  });

  @override
  State<NotificationFilterChips> createState() =>
      _NotificationFilterChipsState();
}

class _NotificationFilterChipsState
    extends State<NotificationFilterChips> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.s(60),
      padding: EdgeInsets.only(
        top: widget.s(12),
        left: widget.s(16),
        right: widget.s(12),
        bottom: widget.s(12),
      ),
     // color: const Color(0xFF1B1A1F),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.filters.length,
        separatorBuilder: (_, __) =>
            SizedBox(width: widget.s(10)),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onChanged(widget.filters[index]);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: widget.s(14),
                vertical: widget.s(9),
              ),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xFFDFC45C),
                    Color(0xFFA89A5F),
                  ],
                )
                    : null,
                color: isSelected
                    ? null
                    : const Color(0xFF24232A),
                borderRadius:
                BorderRadius.circular(widget.s(8)),
              ),
              child: Center(
                child: Text(
                  widget.filters[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: widget.s(14),
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    letterSpacing: -0.14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}