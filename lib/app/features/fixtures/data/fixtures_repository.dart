import '../../../core/networks/dio_client.dart';
import '../models/match_model.dart';

class FixturesRepository {
  final DioClient dioClient;

  FixturesRepository({required this.dioClient});

  Future<List<MatchModel>> getMatchesByDate(
      DateTime date, {
        bool forceRefresh = false,
      }) async {
    final formattedDate = _formatDate(date);

    final data = await dioClient.get(
      '/matches',
      queryParameters: {
        'dateFrom': formattedDate,
        'dateTo': formattedDate,
      },
    );

    final matches =
        (data['matches'] as List<dynamic>?)
            ?.map((json) => MatchModel.fromJson(json as Map<String, dynamic>))
            .toList() ??
            [];

    return matches;
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
}