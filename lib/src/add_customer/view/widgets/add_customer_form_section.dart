import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gb_lottery_b2b/src/add_customer/bloc/add_customer_bloc.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/models/customer_model.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCustomerFormSection extends StatelessWidget {
  final ScrollController controller;

  const AddCustomerFormSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return BlocSelector<AddCustomerBloc, AddCustomerState, int>(
      selector: (state) => state.customers.length,
      builder: (context, customerCount) {
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customerCount,
              itemBuilder: (context, index) {
                return _buildForm(context, s, index);
              },
            ),
            _addButton(context, s),
          ],
        );
      },
    );
  }

  Widget _addButton(BuildContext context, double Function(double) s) {
    return Padding(
      padding: EdgeInsets.only(bottom: s(16)),
      child: GestureDetector(
        onTap: () {
          context.read<AddCustomerBloc>().add(const AddFormEntry());

          Future.delayed(const Duration(milliseconds: 300), () {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          });
        },
        child: Image.asset(
          "assets/images/add_customer/add.png",
          height: s(50),
          width: s(50),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, double Function(double) s, int index) {
    return BlocSelector<AddCustomerBloc, AddCustomerState, bool>(
      selector: (state) => index < state.expandedIndices.length ? state.expandedIndices[index] : false,
      builder: (context, isExpanded) {
        return BlocSelector<AddCustomerBloc, AddCustomerState, CustomerModel?>(
          selector: (state) =>
              index < state.customers.length ? state.customers[index] : null,
          builder: (context, customer) {
            if (customer == null) return const SizedBox.shrink();

            return Stack(
              key: ValueKey(customer.id),
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: s(16)),
                  decoration: BoxDecoration(
                    color: ColorPalette.backgroundDark,
                    borderRadius: BorderRadius.circular(s(8)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(s(15)),
                        child: Column(
                          children: [
                            _field(
                              hint: "Enter Name*",
                              s: s,
                              initialValue: customer.name,
                              onChanged: (v) => context
                                  .read<AddCustomerBloc>()
                                  .add(UpdateFormEntry(index: index, name: v)),
                            ),
                            SizedBox(height: s(11)),
                            _field(
                              hint: "Enter Phone Number*",
                              s: s,
                              initialValue: customer.phone,
                              keyboardType: TextInputType.phone,
                              onChanged: (v) => context
                                  .read<AddCustomerBloc>()
                                  .add(UpdateFormEntry(index: index, phone: v)),
                            ),
                            SizedBox(height: s(11)),
                            _field(
                              hint: "Enter Pincode*",
                              s: s,
                              initialValue: customer.pincode,
                              keyboardType: TextInputType.number,
                              onChanged: (v) => context
                                  .read<AddCustomerBloc>()
                                  .add(UpdateFormEntry(index: index, pincode: v)),
                            ),
                            if (isExpanded) ...[
                              SizedBox(height: s(11)),
                              _field(
                                hint: "Enter Email",
                                s: s,
                                initialValue: customer.email ?? '',
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (v) => context
                                    .read<AddCustomerBloc>()
                                    .add(UpdateFormEntry(index: index, email: v)),
                              ),
                              SizedBox(height: s(11)),
                              _field(
                                hint: "Enter Address",
                                s: s,
                                initialValue: customer.address ?? '',
                                maxLines: 3,
                                onChanged: (v) => context
                                    .read<AddCustomerBloc>()
                                    .add(UpdateFormEntry(index: index, address: v)),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: s(10)),
                      GestureDetector(
                        onTap: () => context
                            .read<AddCustomerBloc>()
                            .add(ToggleExpansion(index)),
                        child: Container(
                          height: s(40),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF313038),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(s(8)),
                              bottomRight: Radius.circular(s(8)),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                isExpanded ? "View Less" : "View More",
                                style: GoogleFonts.dmSans(
                                  color: ColorPalette.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: s(16),
                                ),
                              ),
                              Positioned(
                                right: s(10),
                                child: Image.asset(
                                  "assets/images/add_customer/down_arrow.png",
                                  height: s(16),
                                  width: s(16),
                                  color: ColorPalette.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (index != 0)
                  Positioned(
                    top: -s(6),
                    right: -s(0),
                    child: GestureDetector(
                      onTap: () => context
                          .read<AddCustomerBloc>()
                          .add(RemoveFormEntry(index)),
                      child: Container(
                        width: s(20),
                        height: s(20),
                        decoration: const BoxDecoration(
                            color: Color(0xFFD9D9D9), shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            "assets/images/add_customer/cross.png",
                            width: s(11),
                            height: s(11),
                            color: Colors.black,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _field({
    required String hint,
    required double Function(double) s,
    required String initialValue,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: maxLines == 1 ? s(48) : s(87),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1E24),
        borderRadius: BorderRadius.circular(s(10)),
      ),
      alignment: maxLines > 1 ? Alignment.topLeft : Alignment.centerLeft,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: s(17), vertical: maxLines > 1 ? s(10) : 0),
        child: TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.dmSans(
            color: ColorPalette.whitetext,
            fontWeight: FontWeight.w400,
            fontSize: s(14),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.dmSans(
              color: ColorPalette.darktext,
              fontWeight: FontWeight.w400,
              fontSize: s(14),
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
