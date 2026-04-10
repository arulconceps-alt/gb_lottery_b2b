import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/customerslist/bloc/customer_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerUserListSection extends StatefulWidget {
  const CustomerUserListSection({super.key});

  @override
  State<CustomerUserListSection> createState() =>
      _CustomerUserListSectionState();
}

class _CustomerUserListSectionState
    extends State<CustomerUserListSection> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return BlocBuilder<CustomerListBloc, CustomerListState>(
      builder: (context, state) {
        // We use the customers from state, fallback to empty list if loading/failure
        // to avoid breaking the UI layout during transitions.
        final customers = state.customers;

        return Column(
          children: [
            Container(
              width: s(344),
              decoration: BoxDecoration(
                color: ColorPalette.backgroundDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(s(10)),
                  topLeft: Radius.circular(s(10)),
                ),
              ),
              child: Column(
                children: List.generate(customers.length, (index) {
                  final customer = customers[index];

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: s(10),
                          vertical: s(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: s(50),
                              width: s(50),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF1F1E24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                customer.name.isNotEmpty 
                                    ? customer.name[0].toUpperCase()
                                    : "?",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w500,
                                  color: ColorPalette.whitetext,
                                  fontSize: s(24),
                                ),
                              ),
                            ),

                            SizedBox(width: s(12)),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    customer.name,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      color: ColorPalette.whitetext,
                                      fontSize: s(16),
                                    ),
                                  ),
                                  SizedBox(height: s(4)),
                                  Text(
                                    customer.phone,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w400,
                                      color: ColorPalette.darktext,
                                      fontSize: s(14),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            GestureDetector(
                              onTapDown: (details) async {
                                final selected = await showMenu(
                                  context: context,
                                  color: const Color(0xFF313038),
                                  position: RelativeRect.fromLTRB(
                                    details.globalPosition.dx - s(200),
                                    details.globalPosition.dy - s(-8),
                                    s(60),
                                    0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(s(12)),
                                  ),
                                  items: [
                                    PopupMenuItem(
                                      value: "view",
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        height: s(42),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF313038),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(s(10)),
                                            topRight: Radius.circular(s(10)),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: s(13)),
                                        child: Text(
                                          "View",
                                          style: GoogleFonts.dmSans(
                                            color: ColorPalette.whitetext,
                                            fontWeight: FontWeight.w400,
                                            fontSize: s(14),
                                          ),
                                        ),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      enabled: false,
                                      padding: EdgeInsets.zero,
                                      height: s(1),
                                      child: Divider(
                                        height: 1,
                                        thickness: 0.5,
                                        color: ColorPalette.darktext.withOpacity(
                                          0.5,
                                        ),
                                      ),
                                    ),

                                    PopupMenuItem(
                                      value: "edit",
                                      padding: EdgeInsets.zero,
                                      child: Container(
                                        width: s(132),
                                        height: s(42),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF313038),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(s(10)),
                                            bottomRight: Radius.circular(s(10)),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: s(13)),
                                        child: Text(
                                          "Edit",
                                          style: GoogleFonts.dmSans(
                                            color: ColorPalette.whitetext,
                                            fontWeight: FontWeight.w400,
                                            fontSize: s(14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );

                                if (selected == "view") {
                                  context.push('/customerinformation',
                                      extra: customer);
                                } else if (selected == "edit") {
                                  context.push('/customer_edit',
                                      extra: customer);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: s(20)),
                                child: Icon(
                                  Icons.more_vert,
                                  color: ColorPalette.buttoncolor.withValues(alpha: .80),
                                  size: s(23.9),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (index != customers.length - 1)
                        Divider(
                          color: ColorPalette.darktext,
                          thickness: 0.5,
                          height: 0.5,
                        ),
                    ],
                  );
                }),
              ),
            ),

            SizedBox(height: s(44)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: s(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total 25004",
                    style: GoogleFonts.dmSans(
                      fontSize: s(14),
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.darktext,
                    ),
                  ),

                  SizedBox(width: s(24)),

                  Row(
                    children: [
                      _pageNumber("1", state.currentPage == 1, s),
                      SizedBox(width: s(24)),
                      _pageNumber("2", state.currentPage == 2, s),
                      SizedBox(width: s(24)),
                      _pageNumber("3", state.currentPage == 3, s),
                      SizedBox(width: s(24)),
                      _navButton(Icons.chevron_left, s),
                      SizedBox(width: s(7)),
                      _navButton(Icons.chevron_right, s),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: s(10)),
          ],
        );
      },
    );
  }

  Widget _pageNumber(String text, bool isSelected, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        final page = int.parse(text);
        context.read<CustomerListBloc>().add(FetchCustomers(page: page));
      },
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: s(14),
          fontWeight: FontWeight.w600,
          color: isSelected
              ? ColorPalette.whitetext
              : ColorPalette.darktext,
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, double Function(double) s) {
    return GestureDetector(
      onTap: () {
        final currentState = context.read<CustomerListBloc>().state;
        int targetPage = currentState.currentPage;
        if (icon == Icons.chevron_left && targetPage > 1) {
          targetPage--;
        } else if (icon == Icons.chevron_right) {
          targetPage++;
        }
        
        if (targetPage != currentState.currentPage) {
          context.read<CustomerListBloc>().add(FetchCustomers(page: targetPage));
        }
      },
      child: Container(
        height: s(26),
        width: s(26),
        decoration: BoxDecoration(
          color: const Color(0xFF313038),
          borderRadius: BorderRadius.circular(s(6)),
        ),
        child: Icon(icon, size: s(12), color: ColorPalette.whitetext),
      ),
    );
  }
}