import 'package:counter/source/core/services/api/network_response/result.dart';

class ParallelModel {
  final Future<FinalResult> service;
  final String name;

  ParallelModel({
    required this.service,
    required this.name,
  });
}
