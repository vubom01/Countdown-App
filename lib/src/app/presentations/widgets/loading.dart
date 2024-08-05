import 'package:flutter/material.dart';
import 'package:tekflat_design/tekflat_design.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: context.theme.colorScheme.background,
        width: double.infinity,
        child: const TekLoadingWidget(),
      ),
    );
  }
}
