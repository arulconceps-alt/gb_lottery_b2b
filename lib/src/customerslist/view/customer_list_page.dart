import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:gb_lottery_b2b/src/common/widgets/common_app_bar.dart';
import 'package:gb_lottery_b2b/src/common/widgets/custom_drawer.dart'
    show CustomDrawer;
import 'package:gb_lottery_b2b/src/customerslist/view/widgtes/customer_radio_button.dart';
import 'package:gb_lottery_b2b/src/customerslist/view/widgtes/customer_top_section.dart';
import 'package:gb_lottery_b2b/src/customerslist/view/widgtes/customer_user_list_section.dart';
import 'package:gb_lottery_b2b/src/customerslist/bloc/customer_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScrollController _scrollController;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1B20),
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: CommonAppBar(
        amount: "₹200",
        onLeadingTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: s(20)),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: s(21)),
                  CustomerTopSection(
                    title: "Customer List",
                    subtitle: "Customer Details",
                    buttonText: "Add New",
                    onButtonTap: () async {
                      await context.push('/addcustomer');
                      if (context.mounted) {
                        context.read<CustomerListBloc>().add(const FetchCustomers());
                      }
                    },
                  ),
                  SizedBox(height: s(17)),
                  Container(
                    height: s(50),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: s(16),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A33),
                      borderRadius: BorderRadius.circular(s(8)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/customer_list/search.png",
                          height: s(24),
                          width: s(24),
                          color: ColorPalette.darktext,
                        ),
                        SizedBox(width: s(9)),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (query) => context
                                .read<CustomerListBloc>()
                                .add(SearchChanged(query)),
                            style: GoogleFonts.dmSans(
                              fontSize: s(16),
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.whitetext,
                            ),
                            decoration: InputDecoration(
                              hintText: "Search by customer",
                              hintStyle: GoogleFonts.dmSans(
                                fontSize: s(16),
                                fontWeight: FontWeight.w400,
                                color: ColorPalette.darktext,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              suffixIconConstraints: BoxConstraints(
                                maxHeight: s(24),
                                maxWidth: s(24),
                              ),
                              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _searchController,
                                builder: (context, value, _) {
                                  if (value.text.isEmpty) return const SizedBox.shrink();
                                  return GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      context.read<CustomerListBloc>().add(const SearchChanged(""));
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: ColorPalette.darktext,
                                      size: s(20),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: s(12)),
                      BlocBuilder<CustomerListBloc, CustomerListState>(
                        buildWhen: (previous, current) =>
                            previous.totalCount != current.totalCount,
                        builder: (context, state) {
                          return Text(
                            "Total Customer (${state.totalCount})",
                            style: GoogleFonts.dmSans(
                              fontSize: s(16),
                              fontWeight: FontWeight.w400,
                              color: ColorPalette.darktext.withOpacity(0.60),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: s(19)),
                      const UserTypeSelector(),
                      SizedBox(height: s(27)),
                    ],
                  ),
                ),
                
                const CustomerUserListSection(),
                
                SliverToBoxAdapter(
                  child: SizedBox(height: s(100)),
                ),
              ],
            ),
          ),
        );
  }
}
