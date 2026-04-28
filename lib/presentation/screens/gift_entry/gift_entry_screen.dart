import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entities/gift.dart';
import '../../../domain/entities/gift_type.dart';
import '../../../domain/entities/guest.dart';
import '../../../domain/entities/wedding.dart';
import '../../providers/app_providers.dart';

class GiftEntryScreen extends ConsumerStatefulWidget {
  const GiftEntryScreen({super.key});

  @override
  ConsumerState<GiftEntryScreen> createState() => _GiftEntryScreenState();
}

class _GiftEntryScreenState extends ConsumerState<GiftEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _guestNameController = TextEditingController();
  final _quantityController = TextEditingController(text: '1');
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  Wedding? _selectedWedding;
  GiftType? _selectedGiftType;
  Guest? _selectedGuest;
  bool _saving = false;

  @override
  void dispose() {
    _guestNameController.dispose();
    _quantityController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weddingsAsync = ref.watch(weddingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.giftEntry),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.paddingM),
          children: [
            // Wedding Selection
            Text(
              AppStrings.selectWedding,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.paddingS),
            weddingsAsync.when(
              data: (weddings) => _buildWeddingCards(weddings),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => const Text('Düğünler yüklenemedi'),
            ),

            const SizedBox(height: AppSizes.sectionSpacing),

            // Guest Name with Autocomplete
            Text(
              AppStrings.guestName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.paddingS),
            _buildGuestAutocomplete(),

            const SizedBox(height: AppSizes.sectionSpacing),

            // Gift Type Grid
            Text(
              AppStrings.giftType,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.paddingS),
            _buildGiftTypeGrid(),

            const SizedBox(height: AppSizes.sectionSpacing),

            // Quantity
            Text(
              AppStrings.quantity,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.paddingS),
            _buildQuantityInput(),

            const SizedBox(height: AppSizes.sectionSpacing),

            // Amount
            Text(
              '${AppStrings.amount} (TL)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.paddingS),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: AppSizes.fontL),
              decoration: const InputDecoration(
                hintText: '0,00',
                prefixText: '₺ ',
                prefixStyle: TextStyle(
                  fontSize: AppSizes.fontL,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryGold,
                ),
              ),
            ),

            const SizedBox(height: AppSizes.sectionSpacing),

            // Notes
            Text(
              AppStrings.notes,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.paddingS),
            TextFormField(
              controller: _notesController,
              maxLines: 2,
              style: const TextStyle(fontSize: AppSizes.fontL),
              decoration: const InputDecoration(
                hintText: 'Opsiyonel not...',
              ),
            ),

            const SizedBox(height: AppSizes.sectionSpacing),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: _saving ? null : _saveGift,
                child: _saving
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        AppStrings.save,
                        style: TextStyle(fontSize: AppSizes.fontL),
                      ),
              ),
            ),

            const SizedBox(height: AppSizes.paddingXL),
          ],
        ),
      ),
    );
  }

  Widget _buildWeddingCards(List<Wedding> weddings) {
    if (weddings.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingL),
          child: Column(
            children: [
              const Icon(Icons.celebration, size: 48, color: AppColors.primaryGold),
              const SizedBox(height: AppSizes.paddingS),
              const Text(
                'Henüz düğün eklenmedi',
                style: TextStyle(fontSize: AppSizes.fontL),
              ),
              const SizedBox(height: AppSizes.paddingS),
              OutlinedButton(
                onPressed: () => _showAddWeddingDialog(),
                child: const Text(AppStrings.addWedding),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weddings.length,
        itemBuilder: (context, index) {
          final wedding = weddings[index];
          final isSelected = _selectedWedding?.id == wedding.id;
          return GestureDetector(
            onTap: () => setState(() => _selectedWedding = wedding),
            child: Container(
              width: 200,
              margin: const EdgeInsets.only(right: AppSizes.paddingS),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryGold : AppColors.surfaceGold,
                borderRadius: BorderRadius.circular(AppSizes.radiusL),
                border: Border.all(
                  color: isSelected ? AppColors.primaryGold : AppColors.divider,
                  width: isSelected ? 2 : 1,
                ),
              ),
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    wedding.title,
                    style: TextStyle(
                      fontSize: AppSizes.fontL,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${wedding.brideName} & ${wedding.groomName}',
                    style: TextStyle(
                      fontSize: AppSizes.fontS,
                      color: isSelected ? Colors.white70 : AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: isSelected ? Colors.white70 : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${wedding.weddingDate.day}.${wedding.weddingDate.month}.${wedding.weddingDate.year}',
                          style: TextStyle(
                            fontSize: AppSizes.fontS,
                            color: isSelected ? Colors.white70 : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuestAutocomplete() {
    return Consumer(
      builder: (context, ref, _) {
        final guestsAsync = ref.watch(guestsProvider);
        final allGuests = guestsAsync.valueOrNull ?? [];

        return Autocomplete<Guest>(
          optionsBuilder: (textEditingValue) {
            if (textEditingValue.text.isEmpty) return const Iterable.empty();
            final query = textEditingValue.text.toLowerCase();
            return allGuests.where(
              (g) => g.fullName.toLowerCase().contains(query),
            );
          },
          displayStringForOption: (guest) => guest.fullName,
          onSelected: (guest) {
            _selectedGuest = guest;
            _guestNameController.text = guest.fullName;
          },
          fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
            _guestNameController.text = controller.text;
            return TextFormField(
              controller: controller,
              focusNode: focusNode,
              onEditingComplete: onEditingComplete,
              style: const TextStyle(fontSize: AppSizes.fontL),
              decoration: const InputDecoration(
                hintText: 'Misafir adını yazın...',
                prefixIcon: Icon(Icons.person, size: 28),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Misafir adı gerekli';
                }
                return null;
              },
              onChanged: (value) {
                _guestNameController.text = value;
                _selectedGuest = null;
              },
            );
          },
        );
      },
    );
  }

  Widget _buildGiftTypeGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppSizes.giftTypeGridCrossAxisCount,
        childAspectRatio: 2.2,
        crossAxisSpacing: AppSizes.paddingS,
        mainAxisSpacing: AppSizes.paddingS,
      ),
      itemCount: GiftType.defaultTypes.length,
      itemBuilder: (context, index) {
        final type = GiftType.defaultTypes[index];
        final isSelected = _selectedGiftType?.id == type.id;
        return GestureDetector(
          onTap: () => setState(() => _selectedGiftType = type),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryGold : AppColors.surfaceGold,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              border: Border.all(
                color: isSelected ? AppColors.primaryGold : AppColors.divider,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    type.icon,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    type.name,
                    style: TextStyle(
                      fontSize: AppSizes.fontM,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityInput() {
    return Row(
      children: [
        _buildQuantityButton(Icons.remove, () {
          final current = double.tryParse(_quantityController.text) ?? 1;
          if (current > 1) {
            _quantityController.text = (current - 1).toStringAsFixed(
              current - 1 == (current - 1).roundToDouble() ? 0 : 1,
            );
          }
        }),
        const SizedBox(width: AppSizes.paddingM),
        Expanded(
          child: TextFormField(
            controller: _quantityController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: AppSizes.fontXXL,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Miktar gerekli';
              final num = double.tryParse(value);
              if (num == null || num <= 0) return 'Geçerli miktar girin';
              return null;
            },
          ),
        ),
        const SizedBox(width: AppSizes.paddingM),
        _buildQuantityButton(Icons.add, () {
          final current = double.tryParse(_quantityController.text) ?? 0;
          _quantityController.text = (current + 1).toStringAsFixed(
            current + 1 == (current + 1).roundToDouble() ? 0 : 1,
          );
        }),
      ],
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: AppSizes.buttonHeight,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
          ),
        ),
        child: Icon(icon, size: 28),
      ),
    );
  }

  Future<void> _saveGift() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedWedding == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen bir düğün seçin')),
      );
      return;
    }
    if (_selectedGiftType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen takı türünü seçin')),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      final repo = ref.read(giftRepositoryProvider);
      if (repo == null) throw Exception('Repository not available');

      final guestName = _guestNameController.text.isNotEmpty
          ? _guestNameController.text
          : 'Bilinmeyen Misafir';

      final gift = Gift(
        id: const Uuid().v4(),
        userId: '',
        weddingId: _selectedWedding!.id,
        guestId: _selectedGuest?.id,
        guestNameSnapshot: guestName,
        giftTypeId: _selectedGiftType!.id,
        quantity: double.tryParse(_quantityController.text) ?? 1,
        recordedAmountTry: double.tryParse(
          _amountController.text.replaceAll(',', '.'),
        ),
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        givenAt: DateTime.now(),
      );

      await repo.addGift(gift);

      HapticFeedback.mediumImpact();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(AppStrings.saved),
            backgroundColor: AppColors.success,
          ),
        );

        // Reset form
        _guestNameController.clear();
        _quantityController.text = '1';
        _amountController.clear();
        _notesController.clear();
        setState(() {
          _selectedGiftType = null;
          _selectedGuest = null;
        });

        ref.invalidate(giftsByWeddingProvider);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showAddWeddingDialog() {
    final titleController = TextEditingController();
    final brideController = TextEditingController();
    final groomController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text(AppStrings.addWedding),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: AppStrings.weddingTitle),
                ),
                const SizedBox(height: AppSizes.paddingS),
                TextFormField(
                  controller: brideController,
                  decoration: const InputDecoration(labelText: AppStrings.brideName),
                ),
                const SizedBox(height: AppSizes.paddingS),
                TextFormField(
                  controller: groomController,
                  decoration: const InputDecoration(labelText: AppStrings.groomName),
                ),
                const SizedBox(height: AppSizes.paddingM),
                ListTile(
                  title: Text(
                    '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      setDialogState(() => selectedDate = date);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    brideController.text.isEmpty ||
                    groomController.text.isEmpty) {
                  return;
                }
                final repo = ref.read(weddingRepositoryProvider);
                if (repo == null) return;
                final wedding = Wedding(
                  id: const Uuid().v4(),
                  userId: '',
                  title: titleController.text,
                  brideName: brideController.text,
                  groomName: groomController.text,
                  weddingDate: selectedDate,
                );
                await repo.addWedding(wedding);
                ref.invalidate(weddingsProvider);
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text(AppStrings.save),
            ),
          ],
        ),
      ),
    );
  }
}
