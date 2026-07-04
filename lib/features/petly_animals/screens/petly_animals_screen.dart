import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/features/business/widgets/payment_cart_widget.dart';
import 'package:sixam_mart/features/petly_animals/controllers/pet_controller.dart';
import 'package:sixam_mart/features/petly_animals/screens/add_pet_screen.dart';
import 'package:sixam_mart/features/petly_animals/screens/details_animals_user_screen.dart';
import 'package:sixam_mart/features/petly_animals/widgets/pet_card_widget.dart';

class PetlyAnimalsScreen extends StatefulWidget {
  const PetlyAnimalsScreen({super.key});

  @override
  State<PetlyAnimalsScreen> createState() => _PetlyAnimalsScreenState();
}
// final prefs =  SharedPreferences.getInstance();
// final userId = prefs.getInt('user_id');

class _PetlyAnimalsScreenState extends State<PetlyAnimalsScreen> {
  @override
  void initState() {
    super.initState();

    loadPets();
  }

  Future<void> loadPets() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    print("USER ID = $userId");

    if (userId != null) {
      Get.find<PetController>().getPets(userId);
    } else {
      Get.find<PetController>().clearPetList();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return SafeArea(
        child: Scaffold(
            floatingActionButton: Padding(
              padding: isRtl
                  ? const EdgeInsets.symmetric(horizontal: 25, vertical: 25)
                  : const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Theme.of(context).primaryColor,
                  ),
                ], shape: BoxShape.circle, color: Theme.of(context).cardColor),
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        Get.to(const AddPetScreen());
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 40,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            appBar: AppBar(
              title: const Text('My Pets'),
              centerTitle: true,
            ),
            body: GetBuilder<PetController>(builder: (petcontroller) {
              if (petcontroller.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (petcontroller.pets.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/image/cover_upload_dog.jpg',
                          width: 280,
                          height: 280,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        " اتفضل ضيف اليفك 🐾",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "ضيف أول Pet ليك وابدأ الاستخدام",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const AddPetScreen());
                        },
                        child: const Text("إضافة أول Pet"),
                      ),
                    ],
                  ),
                );
              }

              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: petcontroller.pets.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4,
                  crossAxisCount: 1,
                  mainAxisSpacing: 40,
                ),
                itemBuilder: (context, index) {
                  final pet = petcontroller.pets[index];

                  return InkWell(
                    onTap: () {
                      Get.to(
                        DetailsAnimalsUserScreen(
                          age: pet.age.toString(),
                          name: pet.name!,
                          breed: pet.breed!,
                          type: pet.type!,
                          description: pet.description!,
                        ),
                      );
                    },
                    child: PetCard(
                      name: pet.name.toString(),
                      gender: pet.type.toString(),
                      weight: "2.5kg",
                      age: pet.age.toString(),
                      image: 'assets/image/cover_upload_dog.jpg',
                      cardColor: Theme.of(context).primaryColor,
                      bubbleColor: const Color(0xffF7D98A),
                    ),
                  );
                },
              );

              // return ListView.separated(
              //   physics: const BouncingScrollPhysics(),
              //   padding: const EdgeInsets.all(16),
              //   itemCount: petcontroller.pets.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     final pet = petcontroller.pets[index];
              //     return Container(
              //         padding: const EdgeInsets.all(14),
              //         width: double.infinity,
              //         height: 160,
              //         decoration: BoxDecoration(
              //             boxShadow: [
              //               BoxShadow(
              //                   color: Theme.of(context).hintColor,
              //                   blurStyle: BlurStyle.outer,
              //                   spreadRadius: 1),
              //             ],
              //             borderRadius: BorderRadius.circular(25),
              //             color: Theme.of(context).cardColor),
              //         // image dog
              //         child: Stack(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               children: [
              //                 Container(
              //                   height: 120,
              //                   width: 120,
              //                   clipBehavior: Clip.hardEdge,
              //                   decoration: BoxDecoration(
              //                     shape: BoxShape.rectangle,
              //                     boxShadow: [
              //                       BoxShadow(
              //                           blurRadius: 3,
              //                           blurStyle: BlurStyle.outer,
              //                           color: Theme.of(context).primaryColor,
              //                           spreadRadius: 2),
              //                     ],
              //                     borderRadius: BorderRadius.circular(12),
              //                   ),
              //                   child: Image.network(
              //                     pet.image.toString(),
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   width: size.width * 0.13,
              //                 ),
              //                 Expanded(
              //                   child: Column(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceAround,
              //                     children: [
              //                       TitleNameWidgetPetly(
              //                         size: size,
              //                         title: 'Name',
              //                         name: pet.name!,
              //                       ),
              //                       TitleNameWidgetPetly(
              //                         size: size,
              //                         title: 'Age',
              //                         name: pet.age.toString(),
              //                       ),
              //                       TitleNameWidgetPetly(
              //                         size: size,
              //                         title: 'Breed',
              //                         name: pet.breed.toString(),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             Positioned(
              //               top: 0,
              //               right: 0,
              //               child: Container(
              //                 width: 35,
              //                 height: 35,
              //                 decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Theme.of(context).primaryColor,
              //                 ),
              //                 child: InkWell(
              //                   onTap: () {
              //                     Get.to(DetailsAnimalsUserScreen(
              //                       image: pet.image!,
              //                       age: pet.age.toString(),
              //                       name: pet.name!,
              //                       breed: pet.breed!,
              //                       type: pet.type!,
              //                       description: pet.description!,
              //                     ));
              //                   },
              //                   child: const Icon(
              //                     Icons.arrow_outward_rounded,
              //                     color: Colors.white,
              //                     size: 12,
              //                   ),
              //                 ),
              //               ),
              //             )
              //           ],
              //         ));
              //   },
              //   separatorBuilder: (BuildContext context, int index) {
              //     return const SizedBox(
              //       height: 14,
              //     );
              //   },
              // );
            })));
  }
}

class TitleNameWidgetPetly extends StatelessWidget {
  const TitleNameWidgetPetly({
    super.key,
    required this.size,
    required this.title,
    required this.name,
  });

  final Size size;
  final String title;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size.width * 0.25,
          height: size.height * 0.025,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Text(
              maxLines: 2,
              textAlign: TextAlign.start,
              name,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                  color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
