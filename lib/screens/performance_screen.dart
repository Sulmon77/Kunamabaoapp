import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PerformanceScreen extends StatelessWidget {
  final int rank;
  
  const PerformanceScreen({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    // Get performance data based on rank
    final performanceData = _getPerformanceData(rank);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF37003C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'YOUR PERFORMANCE',
          style: TextStyle(
            color: Color(0xFF37003C),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rank Card
              _buildRankCard(context, rank),
              
              const SizedBox(height: 24),
              
              // Stats Section Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Performance Stats',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37003C),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Stats Cards
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildStatCard(
                        icon: Icons.trending_up,
                        title: 'Season Points',
                        value: performanceData['totalPoints'].toString(),
                        color: const Color(0xFF37003C),
                      ),
                      _buildStatCard(
                        icon: Icons.star,
                        title: 'Gameweek Points',
                        value: performanceData['gameweekPoints'].toString(),
                        color: const Color(0xFF00FF87),
                        textColor: Colors.black87,
                      ),
                      _buildStatCard(
                        icon: Icons.show_chart,
                        title: 'Overall Rank',
                        value: '${performanceData['overallRank']}',
                        color: const Color(0xFF2B81CB),
                      ),
                      _buildStatCard(
                        icon: Icons.emoji_events,
                        title: 'Top Performer',
                        value: performanceData['topPerformer'],
                        color: const Color(0xFFE90052),
                      ),
                      _buildStatCard(
                        icon: Icons.groups,
                        title: 'League Average',
                        value: '${performanceData['leagueAverage']} pts',
                        color: const Color(0xFF04F5FF),
                        textColor: Colors.black87,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Bottom Action Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Share functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Sharing functionality will be added soon'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF37003C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 8),
                      Text(
                        'SHARE MY PERFORMANCE',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildRankCard(BuildContext context, int rank) {
    String rankText = 'LEAGUE RANK';
    String message = '';
    Color cardColor = const Color(0xFF37003C);
    
    if (rank <= 10) {
      message = 'Congratulations! You\'re in the top tier.';
      cardColor = const Color(0xFF00FF87);
    } else if (rank <= 50) {
      message = 'Well done! You\'re performing above average.';
      cardColor = const Color(0xFF04F5FF);
    } else {
      message = 'Keep going! There\'s room for improvement.';
      cardColor = const Color(0xFFE90052);
    }
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            rankText,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: rank <= 10 || rank <= 50 ? Colors.black87 : Colors.white70,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            rank.toString(),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: rank <= 10 || rank <= 50 ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: rank <= 10 || rank <= 50 ? Colors.black87 : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    Color textColor = Colors.white,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6C7889),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37003C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to get mock performance data
  Map<String, dynamic> _getPerformanceData(int rank) {
    // In a real app, this would come from your API
    return {
      'totalPoints': 1250 + (100 - rank),
      'gameweekPoints': 65 + ((100 - rank) ~/ 10),
      'overallRank': 150000 + (rank * 1000),
      'topPerformer': 'M. Salah',
      'leagueAverage': 55,
    };
  }
}