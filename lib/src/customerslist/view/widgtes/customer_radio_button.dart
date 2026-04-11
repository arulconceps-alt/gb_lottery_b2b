import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/customerslist/bloc/customer_list_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioItem extends StatelessWidget {
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;

  const CustomRadioItem({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final isSelected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: s(18),
            width: s(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? ColorPalette.primary
                    : ColorPalette.whitetext,
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      height: s(8),
                      width: s(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorPalette.primary,
                      ),
                    ),
                  )
                : null,
          ),

          SizedBox(width: s(10)),

          Text(
            text,
            style: GoogleFonts.dmSans(
              fontSize: s(16),
              fontWeight: FontWeight.w400,
              color: ColorPalette.whitetext,
            ),
          ),
        ],
      ),
    );
  }
}

class UserTypeSelector extends StatelessWidget {
  const UserTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return BlocBuilder<CustomerListBloc, CustomerListState>(
      buildWhen: (previous, current) => previous.selectedRole != current.selectedRole,
      builder: (context, state) {
        // UI uses internal 'all', 'customer', 'moderator' values
        // We map these to the State's 'All', 'User', 'Moderator'
        String currentUIValue = "all";
        if (state.selectedRole == "User") currentUIValue = "customer";
        else if (state.selectedRole == "Moderator") currentUIValue = "moderator";
        else currentUIValue = "all";

        return Row(
          children: [
            CustomRadioItem(
              text: "All",
              value: "all",
              groupValue: currentUIValue,
              onChanged: (val) {
                context.read<CustomerListBloc>().add(const FetchCustomers(roleName: "All"));
              },
            ),

            SizedBox(width: s(20)),

            CustomRadioItem(
              text: "Customer",
              value: "customer",
              groupValue: currentUIValue,
              onChanged: (val) {
                context.read<CustomerListBloc>().add(const FetchCustomers(roleName: "User"));
              },
            ),

            SizedBox(width: s(20)),

            CustomRadioItem(
              text: "Moderator",
              value: "moderator",
              groupValue: currentUIValue,
              onChanged: (val) {
                context.read<CustomerListBloc>().add(const FetchCustomers(roleName: "Moderator"));
              },
            ),
          ],
        );
      },
    );
  }
}