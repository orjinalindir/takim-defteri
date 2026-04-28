import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _nameController = TextEditingController();
  bool _otpSent = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      setState(() => _error = 'Telefon numarası gerekli');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final formattedPhone = phone.startsWith('+') ? phone : '+90$phone';
      await Supabase.instance.client.auth.signInWithOtp(phone: formattedPhone);
      setState(() => _otpSent = true);
    } catch (e) {
      setState(() => _error = 'Doğrulama kodu gönderilemedi: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _verifyOtp() async {
    final phone = _phoneController.text.trim();
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      setState(() => _error = 'Doğrulama kodu gerekli');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final formattedPhone = phone.startsWith('+') ? phone : '+90$phone';
      await Supabase.instance.client.auth.verifyOTP(
        phone: formattedPhone,
        token: otp,
        type: OtpType.sms,
      );
    } catch (e) {
      setState(() => _error = 'Doğrulama başarısız: ${e.toString()}');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.paddingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo / Title
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGoldLight,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryGold, width: 3),
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    size: 48,
                    color: AppColors.primaryGold,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingL),
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: AppSizes.paddingS),
                Text(
                  AppStrings.appTagline,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                const SizedBox(height: AppSizes.paddingXL),

                if (_error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSizes.paddingM),
                    decoration: BoxDecoration(
                      color: AppColors.errorRed.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.radiusM),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: AppColors.errorRed),
                        const SizedBox(width: AppSizes.paddingS),
                        Expanded(
                          child: Text(
                            _error!,
                            style: const TextStyle(
                              color: AppColors.errorRed,
                              fontSize: AppSizes.fontM,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingM),
                ],

                // Phone Input
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  enabled: !_otpSent,
                  style: const TextStyle(fontSize: AppSizes.fontL),
                  decoration: InputDecoration(
                    labelText: AppStrings.phoneNumber,
                    hintText: '5XX XXX XXXX',
                    prefixText: '+90 ',
                    prefixStyle: const TextStyle(
                      fontSize: AppSizes.fontL,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: const Icon(Icons.phone, size: 28),
                  ),
                ),
                const SizedBox(height: AppSizes.paddingM),

                if (_otpSent) ...[
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: AppSizes.fontXXL,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 8,
                    ),
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    decoration: InputDecoration(
                      labelText: AppStrings.enterOtp,
                      counterText: '',
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingM),
                ],

                SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: _loading
                        ? null
                        : (_otpSent ? _verifyOtp : _sendOtp),
                    child: _loading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _otpSent ? AppStrings.verify : AppStrings.sendOtp,
                          ),
                  ),
                ),

                if (_otpSent) ...[
                  const SizedBox(height: AppSizes.paddingM),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _otpSent = false;
                        _otpController.clear();
                        _error = null;
                      });
                    },
                    child: const Text(
                      'Telefon numarasını değiştir',
                      style: TextStyle(fontSize: AppSizes.fontL),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
