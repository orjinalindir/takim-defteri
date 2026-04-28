import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/currency_utils.dart';
import '../../../domain/entities/guest.dart';
import '../../common/native_ad_banner.dart';
import '../../providers/app_providers.dart';

class ReturnListScreen extends ConsumerStatefulWidget {
  const ReturnListScreen({super.key});

  @override
  ConsumerState<ReturnListScreen> createState() => _ReturnListScreenState();
}

class _ReturnListScreenState extends ConsumerState<ReturnListScreen> {
  String _searchQuery = '';
  String? _selectedCity;
  String? _selectedRelationship;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final guestsAsync = ref.watch(guestsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.returnList),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingM),
            child: TextFormField(
              controller: _searchController,
              style: const TextStyle(fontSize: AppSizes.fontL),
              decoration: InputDecoration(
                hintText: AppStrings.search,
                prefixIcon: const Icon(Icons.search, size: 28),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // Filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingM),
            child: Row(
              children: [
                Expanded(
                  child: _buildFilterChip(
                    label: _selectedCity ?? AppStrings.allCities,
                    isActive: _selectedCity != null,
                    onTap: () => _showCityFilter(guestsAsync.valueOrNull ?? []),
                  ),
                ),
                const SizedBox(width: AppSizes.paddingS),
                Expanded(
                  child: _buildFilterChip(
                    label: _selectedRelationship != null
                        ? _relationshipLabel(_selectedRelationship!)
                        : AppStrings.allRelationships,
                    isActive: _selectedRelationship != null,
                    onTap: () => _showRelationshipFilter(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.paddingS),

          // Guest list
          Expanded(
            child: guestsAsync.when(
              data: (guests) {
                var filtered = guests.where((g) {
                  if (_searchQuery.isNotEmpty) {
                    if (!g.fullName.toLowerCase().contains(_searchQuery.toLowerCase())) {
                      return false;
                    }
                  }
                  if (_selectedCity != null && g.city != _selectedCity) return false;
                  if (_selectedRelationship != null && g.relationship != _selectedRelationship) {
                    return false;
                  }
                  return true;
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noData,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length + (filtered.length ~/ 5),
                  itemBuilder: (context, index) {
                    // Insert ad every 5 items
                    final adCount = index ~/ 6;
                    if (index > 0 && index % 6 == 5) {
                      return const NativeAdBanner(placement: 'list_inline');
                    }
                    final guestIndex = index - adCount;
                    if (guestIndex >= filtered.length) return const SizedBox.shrink();

                    return _buildGuestCard(filtered[guestIndex]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Hata: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestCard(Guest guest) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingM,
        vertical: AppSizes.paddingXS,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.paddingM),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primaryGoldLight,
              child: Text(
                guest.fullName.isNotEmpty ? guest.fullName[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: AppSizes.fontXL,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryNavy,
                ),
              ),
            ),
            const SizedBox(width: AppSizes.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    guest.fullName,
                    style: const TextStyle(
                      fontSize: AppSizes.fontL,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      if (guest.city != null) ...[
                        const Icon(Icons.location_on, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 2),
                        Text(
                          guest.city!,
                          style: const TextStyle(
                            fontSize: AppSizes.fontS,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingS),
                      ],
                      if (guest.relationship != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGoldLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _relationshipLabel(guest.relationship!),
                            style: const TextStyle(
                              fontSize: AppSizes.fontXS,
                              color: AppColors.secondaryNavy,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder<double>(
              future: ref.read(giftRepositoryProvider)?.getTotalGiftValueByGuest(guest.id),
              builder: (context, snapshot) {
                final value = snapshot.data ?? 0;
                if (value == 0) return const SizedBox.shrink();
                return Text(
                  CurrencyUtils.formatTRY(value),
                  style: const TextStyle(
                    fontSize: AppSizes.fontL,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingS,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGold : AppColors.surfaceGold,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: Border.all(
            color: isActive ? AppColors.primaryGold : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: AppSizes.fontM,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.arrow_drop_down,
              color: isActive ? Colors.white : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  void _showCityFilter(List<Guest> guests) {
    final cities = guests
        .where((g) => g.city != null && g.city!.isNotEmpty)
        .map((g) => g.city!)
        .toSet()
        .toList()
      ..sort();

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: [
          ListTile(
            title: const Text(AppStrings.allCities, style: TextStyle(fontSize: AppSizes.fontL)),
            onTap: () {
              setState(() => _selectedCity = null);
              Navigator.pop(context);
            },
          ),
          ...cities.map(
            (city) => ListTile(
              title: Text(city, style: const TextStyle(fontSize: AppSizes.fontL)),
              onTap: () {
                setState(() => _selectedCity = city);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showRelationshipFilter() {
    final relationships = ['family', 'neighbor', 'coworker', 'friend'];

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: [
          ListTile(
            title: const Text(AppStrings.allRelationships, style: TextStyle(fontSize: AppSizes.fontL)),
            onTap: () {
              setState(() => _selectedRelationship = null);
              Navigator.pop(context);
            },
          ),
          ...relationships.map(
            (rel) => ListTile(
              title: Text(_relationshipLabel(rel), style: const TextStyle(fontSize: AppSizes.fontL)),
              onTap: () {
                setState(() => _selectedRelationship = rel);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  String _relationshipLabel(String relationship) {
    switch (relationship) {
      case 'family':
        return AppStrings.family;
      case 'neighbor':
        return AppStrings.neighbor;
      case 'coworker':
        return AppStrings.coworker;
      case 'friend':
        return AppStrings.friend;
      default:
        return relationship;
    }
  }
}
