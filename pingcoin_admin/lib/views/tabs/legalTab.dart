import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingcoin_admin/views/tabs/legalTabs/aboutTab.dart';
import 'package:pingcoin_admin/views/tabs/legalTabs/faqTab.dart';
import 'package:pingcoin_admin/views/tabs/legalTabs/privacyPolicyTab.dart';
import 'package:pingcoin_admin/views/tabs/legalTabs/termsTab.dart';
import 'package:pingcoin_admin/widgets/topBar.dart';

import '../../constants/colors.dart';

class LegalTab extends StatefulWidget {
  const LegalTab({super.key});

  @override
  State<LegalTab> createState() => _LegalTabState();
}

class _LegalTabState extends State<LegalTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rBlack,
      body: DefaultTabController(
        length: 4,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBar(title: "Legal"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: rGreen,
                      width: 2,
                    ),
                  ),
                  dividerColor: rHint,
                  unselectedLabelColor: rHint,
                  labelColor: rGreen,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: 'About'),
                    Tab(text: 'FAQs'),
                    Tab(text: 'Privacy Policy'),
                    Tab(text: 'Terms and Conditions'),
                  ],
                ),
              ).marginOnly(top: 12),

              Container(
                height: MediaQuery.of(context).size.height * 0.78,
                child: TabBarView(
                  children: [
                    AboutTab(),
                    FAQsTab(),
                    PrivacyPolicyTab(),
                    TermsTab()
                  ],
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}
