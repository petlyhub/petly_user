import 'package:flutter/material.dart';

class PaymentMethodCard extends StatefulWidget {
  const PaymentMethodCard({super.key});

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  int selectedCard = 0;
  bool useWallet = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [

            /// Title
            ListTile(
              title: const Text(
                "طريقة الدفع",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: TextButton(
                onPressed: () {},
                child: const Text("المزيد"),
              ),
            ),

            const Divider(height: 1),

            /// Saved Card
            RadioListTile<int>(
              value: 0,
              groupValue: selectedCard,
              activeColor: Colors.black,
              onChanged: (value) {
                setState(() {
                  selectedCard = value!;
                });
              },
              title: Row(
                children: [

                  const Expanded(
                    child: Text(
                      "mada **** 7389",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Image.asset(
                    "assets/images/mada.png",
                    width: 40,
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            /// Add New Card
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text(
                "إضافة بطاقة جديدة",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Image.asset(
                    "assets/images/mada.png",
                    width: 30,
                  ),

                  const SizedBox(width: 8),

                  Image.asset(
                    "assets/images/visa.png",
                    width: 30,
                  ),

                  const SizedBox(width: 8),

                  Image.asset(
                    "assets/images/mastercard.png",
                    width: 30,
                  ),
                ],
              ),
              onTap: () {},
            ),

            const Divider(height: 1),

            /// Wallet
            SwitchListTile(
              value: useWallet,
              onChanged: (value) {
                setState(() {
                  useWallet = value;
                });
              },
              title: const Text(
                "المحفظة",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              subtitle: const Text(
                "الرصيد: 0.00 ر.س",
              ),
            ),
          ],
        ),
      ),
    );
  }
}