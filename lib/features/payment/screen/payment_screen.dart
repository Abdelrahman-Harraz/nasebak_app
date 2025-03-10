import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nasebak_app/res/app_asset_paths.dart';
import 'package:nasebak_app/res/app_colors.dart';
import 'package:nasebak_app/utils/extensions/extension_localization.dart';
import 'package:nasebak_app/utils/extensions/extension_theme.dart';
import 'package:nasebak_app/utils/locale/app_localization_keys.dart';

class PaymentScreen extends StatefulWidget {
  final int price;
  final int? duration;
  final String? dateValue;
  final String currency;

  const PaymentScreen({
    super.key,
    required this.price,
    this.duration,
    this.dateValue,
    required this.currency,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardholderNameController =
      TextEditingController();

  String _selectedPaymentMethod = 'card';
  late double _vatAmount;
  late double _totalAmount;

  @override
  void initState() {
    super.initState();
    _vatAmount = widget.price * 0.15;
    _totalAmount = widget.price + _vatAmount;

    // Add listeners to the controllers
    _cardNumberController.addListener(_updateButtonState);
    _expiryDateController.addListener(_updateButtonState);
    _cvvController.addListener(_updateButtonState);
    _cardholderNameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      // This will trigger a rebuild of the widget and update the button state
    });
  }

  @override
  void dispose() {
    // Remove the listeners when the widget is disposed
    _cardNumberController.removeListener(_updateButtonState);
    _expiryDateController.removeListener(_updateButtonState);
    _cvvController.removeListener(_updateButtonState);
    _cardholderNameController.removeListener(_updateButtonState);

    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardholderNameController.dispose();
    super.dispose();
  }

  bool _areAllFieldsFilled() {
    return _cardNumberController.text.isNotEmpty &&
        _expiryDateController.text.isNotEmpty &&
        _cvvController.text.isNotEmpty &&
        _cardholderNameController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        foregroundColor: AppColors.colorPrimary,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.notificationsIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssetPaths.menuIcon),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssetPaths.homeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 58,
                      width: double.infinity,
                      color: AppColors.invoiceDetailsTextBackground,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            context.translate(LocalizationKeys.invoiceDetails),
                            style: context.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _buildInvoiceDetails(),
                    const SizedBox(height: 50),
                    _buildPaymentMethods(),
                    const SizedBox(height: 30),
                    _buildCardDetails(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildPayButton(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildInvoiceDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate(LocalizationKeys.subscription),
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 15),
              if (widget.duration != null && widget.dateValue != null)
                Text(
                  '${widget.duration} ${widget.dateValue}',
                  style: context.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              Text(
                '${widget.price} ${widget.currency}',
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.paymentScreenBorder),
          const SizedBox(height: 16),
          // VAT details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate(LocalizationKeys.vat),
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '15 %',
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Text(
                '${_vatAmount.toStringAsFixed(2)} ${widget.currency}',
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.paymentScreenBorder),
          const SizedBox(height: 16),
          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate(LocalizationKeys.totalPrice),
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${_totalAmount.toStringAsFixed(2)} ${widget.currency}',
                style: context.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Padding(
      padding: const EdgeInsets.only(right: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Visa
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 'card';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      _selectedPaymentMethod == 'card'
                          ? Colors.white
                          : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(AppAssetPaths.visaIcon),
            ),
          ),
          // Mada
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 'mada';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      _selectedPaymentMethod == 'mada'
                          ? Colors.white
                          : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(AppAssetPaths.madaPaymentIcon),
            ),
          ),
          // Apple Pay
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentMethod = 'apple';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      _selectedPaymentMethod == 'apple'
                          ? Colors.white
                          : Colors.transparent,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(AppAssetPaths.applePayIcon),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildCardDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Card number
          Text(
            context.translate(LocalizationKeys.cardNumber),
            style: context.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _cardNumberController,
            decoration: InputDecoration(
              hintText: '1234  5678  3456  2456',
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: AppColors.paymentScreenTextFieldsBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: context.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CardNumberFormatter(),
            ],
          ),
          const SizedBox(height: 16),
          // Expiry date and CVV
          Row(
            children: [
              // CVV
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate(LocalizationKeys.cvv),
                      style: context.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _cvvController,
                      decoration: InputDecoration(
                        hintText: '123',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: AppColors.paymentScreenTextFieldsBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: context.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Expiry date
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate(LocalizationKeys.expiryDate),
                      style: context.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _expiryDateController,
                      decoration: InputDecoration(
                        hintText: '24  /  21',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: AppColors.paymentScreenTextFieldsBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: context.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                        ExpiryDateFormatter(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Cardholder name
          Text(
            context.translate(LocalizationKeys.cardHolderName),
            style: context.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _cardholderNameController,
            decoration: InputDecoration(
              hintText: context.translate(LocalizationKeys.enterNameOnCard),
              hintStyle: const TextStyle(color: Colors.grey),
              filled: true,
              fillColor: AppColors.paymentScreenTextFieldsBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
            style: context.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildPayButton() {
    bool isEnabled = _areAllFieldsFilled(); // Check if all fields are filled

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          gradient:
              isEnabled
                  ? LinearGradient(
                    colors: [
                      AppColors.membershipButtonColor2,
                      AppColors.membershipButtonColor1,
                      AppColors.membershipButtonColor1,
                      AppColors.membershipButtonColor1,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )
                  : LinearGradient(
                    colors: [Colors.grey, Colors.grey],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: ElevatedButton(
          onPressed:
              isEnabled
                  ? () {
                    // Handle the payment logic here
                  }
                  : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            context.translate(LocalizationKeys.pay),
            style: TextStyle(
              color: Colors.white,

              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write(' '); // Add a space after every 4 digits
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    // If the input is empty, return the new value as is
    if (text.isEmpty) {
      return newValue;
    }

    // Remove any non-digit characters
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Insert a '/' after the first two digits (month)
    if (text.length >= 2) {
      text = '${text.substring(0, 2)} / ${text.substring(2)}';
    }

    // Limit the input to 4 digits (MMYY)
    if (text.length > 7) {
      text = text.substring(0, 7);
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
