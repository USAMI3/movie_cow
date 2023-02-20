import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardFragment extends ConsumerStatefulWidget {
  const DashboardFragment({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardFragmentState();
}

class _DashboardFragmentState extends ConsumerState<DashboardFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
