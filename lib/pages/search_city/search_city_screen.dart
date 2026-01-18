import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/weather/weather_state.dart';
import '../../shared/theme/colors.dart';

class SearchCityScreen extends StatefulWidget {
  const SearchCityScreen({super.key});

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredCities = [];

  final List<String> _popularCities = [
    'Moscow',
    'London',
    'New York',
    'Paris',
    'Tokyo',
    'Berlin',
    'Rome',
    'Madrid',
    'Dubai',
    'Sydney',
    'Los Angeles',
    'Singapore',
    'Istanbul',
    'Bangkok',
    'Amsterdam',
    'Barcelona',
    'Miami',
    'San Francisco',
    'Toronto',
    'Seoul',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCities = [];
      } else {
        _filteredCities = _popularCities
            .where((city) => city.toLowerCase().startsWith(query))
            .toList();
      }
    });
  }

  Future<void> _selectCity(String cityName) async {
    final weatherState = context.read<WeatherState>();
    await weatherState.searchCity(cityName);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(
              child: _searchController.text.isEmpty
                  ? _buildSearchHistory()
                  : _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, size: 24, color: Color(AppColors.textSecondary)),
          ),
          const SizedBox(height: 24),
          const Text(
            'Get Weather',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Enter city name',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(AppColors.lightGrey)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(AppColors.lightGrey)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(AppColors.primary)),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchHistory() {
    return Consumer<WeatherState>(
      builder: (context, weatherState, child) {
        final history = weatherState.searchHistory;

        if (history.isEmpty) {
          return const Center(
            child: Text(
              'No search history',
              style: TextStyle(
                color: Color(AppColors.textSecondary),
                fontSize: 16,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Past Search',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(AppColors.textPrimary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      weatherState.clearSearchHistory();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(AppColors.clearBlue),
                    ),
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final city = history[index];
                  return InkWell(
                    onTap: () => _selectCity(city),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              city,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color(AppColors.textPrimary),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            color: const Color(AppColors.textSecondary),
                            onPressed: () {
                              weatherState.removeFromSearchHistory(city);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults() {
    if (_filteredCities.isEmpty) {
      return const Center(
        child: Text(
          'No cities found',
          style: TextStyle(
            color: Color(AppColors.textSecondary),
            fontSize: 16,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filteredCities.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final city = _filteredCities[index];
        final country = _getCityCountry(city);
        
        return InkWell(
          onTap: () => _selectCity(city),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 17,
                  color: Color(AppColors.textPrimary),
                ),
                children: [
                  TextSpan(
                    text: city,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: ' • ',
                    style: TextStyle(
                      color: const Color(AppColors.textSecondary).withValues(alpha: 0.5),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextSpan(
                    text: country,
                    style: const TextStyle(
                      color: Color(AppColors.textSecondary),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getCityCountry(String city) {
    final countries = {
      'Moscow': 'Russia',
      'London': 'United Kingdom',
      'New York': 'USA',
      'Paris': 'France',
      'Tokyo': 'Japan',
      'Berlin': 'Germany',
      'Rome': 'Italy',
      'Madrid': 'Spain',
      'Dubai': 'UAE',
      'Sydney': 'Australia',
      'Los Angeles': 'USA',
      'Singapore': 'Singapore',
      'Istanbul': 'Turkey',
      'Bangkok': 'Thailand',
      'Amsterdam': 'Netherlands',
      'Barcelona': 'Spain',
      'Miami': 'USA',
      'San Francisco': 'USA',
      'Toronto': 'Canada',
      'Seoul': 'South Korea',
    };
    return countries[city] ?? '';
  }
}
