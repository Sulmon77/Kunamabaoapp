import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final int leagueId = 570722; // Replace with your league ID

  Future<int?> getPerformance(String fplId) async {
    int page = 1;

    while (true) {
      try {
        // Fetch league standings page by page
        final standingsUrl =
            'https://fantasy.premierleague.com/api/leagues-classic/$leagueId/standings/?page_standings=$page';
        final response = await http.get(Uri.parse(standingsUrl)).timeout(Duration(seconds: 10));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final players = data['standings']['results'];

          // Search for the player in the current page
          final player = players.firstWhere(
            (player) => player['entry'].toString() == fplId,
            orElse: () => null,
          );

          if (player != null) {
            return player['rank']; // Return the player's rank
          }

          // If no more pages, stop searching
          if (data['standings']['has_next'] == false) {
            break;
          }

          page++; // Move to the next page
        } else {
          throw Exception('Failed to fetch league standings');
        }
      } catch (e) {
        throw Exception('Failed to load performance data: $e');
      }
    }

    return null; // Return null if FPL ID is not found
  }
}
