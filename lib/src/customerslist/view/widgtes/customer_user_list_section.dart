import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/customerslist/bloc/customer_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CustomerUserListSection extends StatelessWidget {
  const CustomerUserListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return BlocBuilder<CustomerListBloc, CustomerListState>(
      builder: (context, state) {
        final customers = state.customers;
        final isLoading = state.status == CustomerListStatus.loading;

        if (isLoading && customers.isEmpty) {
          return SliverToBoxAdapter(child: _buildShimmer(s));
        }

        if (customers.isEmpty && !isLoading) {
          final isFailure = state.status == CustomerListStatus.failure;
          return SliverToBoxAdapter(
            child: Container(
              height: s(200),
              margin: EdgeInsets.symmetric(vertical: s(20)),
              decoration: BoxDecoration(
                color: ColorPalette.backgroundDark,
                borderRadius: BorderRadius.circular(s(10)),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFailure ? Icons.error_outline : Icons.person_search_outlined,
                    color: isFailure ? Colors.redAccent : ColorPalette.darktext,
                    size: s(48),
                  ),
                  SizedBox(height: s(16)),
                  Text(
                    isFailure 
                        ? "Failed to load customers\n${state.message}"
                        : "No agents found for '${state.selectedRole}'",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      color: isFailure ? Colors.redAccent : ColorPalette.whitetext,
                      fontSize: s(14),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Replacing SliverMainAxisGroup with standard Multi-Sliver pattern for better compatibility
        return SliverList(
          delegate: SliverChildListDelegate([
            Container(
              width: s(344),
              decoration: BoxDecoration(
                color: ColorPalette.backgroundDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(s(10)),
                  topLeft: Radius.circular(s(10)),
                  bottomLeft: Radius.circular(s(10)),
                  bottomRight: Radius.circular(s(10)),
                ),
              ),
              child: Column(
                children: List.generate(customers.length, (index) {
                  final customer = customers[index];
                  return _customerItem(customer, index, customers.length, s, context, state);
                }),
              ),
            ),
            SizedBox(height: s(44)),
            _buildPagination(state, s, context),
            SizedBox(height: s(20)),
          ]),
        );
      },
    );
  }

  Widget _customerItem(dynamic customer, int index, int total, double Function(double) s, BuildContext context, CustomerListState state) {
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
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1F1E24),
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
                      overflow: TextOverflow.ellipsis,
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
                      const PopupMenuItem(
                        enabled: false,
                        padding: EdgeInsets.zero,
                        height: 1,
                        child: Divider(height: 1, thickness: 0.5, color: Color(0x33FFFFFF)),
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
                    context.push('/customerinformation', extra: customer);
                  } else if (selected == "edit") {
                    final result = await context.push('/customer_edit', extra: customer);
                    if (result == true && context.mounted) {
                      context.read<CustomerListBloc>().add(FetchCustomers(page: state.currentPage));
                    }
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(right: s(20)),
                  child: Icon(
                    Icons.more_vert,
                    color: ColorPalette.buttoncolor.withOpacity(0.80),
                    size: s(23.9),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (index != total - 1)
          Divider(
            color: ColorPalette.darktext,
            thickness: 0.5,
            height: 0.5,
          ),
      ],
    );
  }

  Widget _buildPagination(CustomerListState state, double Function(double) s, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Total ${state.totalCount}",
          style: GoogleFonts.dmSans(
            fontSize: s(14),
            fontWeight: FontWeight.w600,
            color: ColorPalette.darktext,
          ),
        ),
        SizedBox(width: s(24)),
        Row(
          children: [
            _pageNumber("1", state.currentPage == 1, s, context),
            if (state.totalCount > 10) ...[
              SizedBox(width: s(24)),
              _pageNumber("2", state.currentPage == 2, s, context),
            ],
            if (state.totalCount > 20) ...[
              SizedBox(width: s(24)),
              _pageNumber("3", state.currentPage == 3, s, context),
            ],
            SizedBox(width: s(24)),
            _navButton(Icons.chevron_left, s, context),
            SizedBox(width: s(7)),
            _navButton(Icons.chevron_right, s, context),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmer(double Function(double) s) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.05),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Column(
        children: List.generate(5, (index) => Padding(
          padding: EdgeInsets.symmetric(vertical: s(10), horizontal: s(10)),
          child: Row(
            children: [
              Container(height: s(50), width: s(50), decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
              SizedBox(width: s(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: s(16), width: s(150), color: Colors.white),
                    SizedBox(height: s(6)),
                    Container(height: s(14), width: s(100), color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _pageNumber(String text, bool isSelected, double Function(double) s, BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<CustomerListBloc>().add(FetchCustomers(page: int.parse(text))),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: s(14),
          fontWeight: FontWeight.w600,
          color: isSelected ? ColorPalette.whitetext : ColorPalette.darktext,
        ),
      ),
    );
  }

  Widget _navButton(IconData icon, double Function(double) s, BuildContext context) {
    return GestureDetector(
      onTap: () {
        final state = context.read<CustomerListBloc>().state;
        int targetPage = state.currentPage;
        final maxPage = (state.totalCount / 10).ceil().clamp(1, 999);
        if (icon == Icons.chevron_left && targetPage > 1) targetPage--;
        else if (icon == Icons.chevron_right && targetPage < maxPage) targetPage++;
        if (targetPage != state.currentPage) {
          context.read<CustomerListBloc>().add(FetchCustomers(page: targetPage));
        }
      },
      child: Container(
        height: s(26), width: s(26),
        decoration: BoxDecoration(color: const Color(0xFF313038), borderRadius: BorderRadius.circular(s(6))),
        child: Icon(icon, size: s(12), color: ColorPalette.whitetext),
      ),
    );
  }
}