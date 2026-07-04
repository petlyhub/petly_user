import 'package:flutter/material.dart';

class PetCardWidget extends StatelessWidget {
  const PetCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: PetCard(
                  name: "Taisum",
                  gender: "Male",
                  weight: "2.5kg",
                  age: "1yr 2mn",
                  image:
                      "https://images.unsplash.com/photo-1517849845537-4d257902454a",
                  cardColor: Color(0xffFCECC8),
                  bubbleColor: Color(0xffF7D98A),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: PetCard(
                  name: "Amber",
                  gender: "Male",
                  weight: "2kg",
                  age: "1yr 6mn",
                  image:
                      "https://images.unsplash.com/photo-1517423440428-a5a00ad493e8",
                  cardColor: Color(0xffC9F0FF),
                  bubbleColor: Color(0xff59CCFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PetCard extends StatefulWidget {
  final String name;
  final String gender;
  final String weight;
  final String age;
  final String image;
  final Color cardColor;
  final Color bubbleColor;

  const PetCard({
    super.key,
    required this.name,
    required this.gender,
    required this.weight,
    required this.age,
    required this.image,
    required this.cardColor,
    required this.bubbleColor,
  });

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      decoration: BoxDecoration(
        color: widget.cardColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        children: [

          /// Decorative circles
          Positioned(
            bottom: 18,
            right: 18,
            child: _buildBubblePattern(),
          ),

          /// Main content
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// Image container
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                /// Name
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff111827),
                  ),
                ),

                const SizedBox(height: 14),

                /// Tags
                Row(
                  children: [
                    _tag(widget.gender),
                    const SizedBox(width: 8),
                    _tag(widget.weight),
                    const SizedBox(width: 8),
                    _tag(widget.age),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Color(0xff374151),
        ),
      ),
    );
  }

  Widget _buildBubblePattern() {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        children: [

          _circle(40, 0, 28),
          _circle(10, 15, 22),
          _circle(48, 38, 22),
          _circle(0, 45, 18),
          _circle(28, 58, 18),

        ],
      ),
    );
  }

  Widget _circle(double left, double top, double size) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: widget.bubbleColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}