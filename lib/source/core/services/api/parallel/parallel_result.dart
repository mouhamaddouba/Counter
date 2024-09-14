import 'package:counter/source/core/services/api/network_response/result.dart';

class ParallelResult {
  final FinalResult finalResult;
  final String name;

  ParallelResult({
    required this.finalResult,
    required this.name,
  });
}
