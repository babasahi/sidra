import 'package:sidra/models/mock.dart';
import 'package:sidra/models/sidr.dart';

Future<List<Sidr>> sidrs() async {
  return await Future.delayed(const Duration(seconds: 1), () => mockSidrs);
}
