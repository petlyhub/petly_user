import 'package:flutter/material.dart';

class DetailsAnimalsUserScreen extends StatefulWidget {
  const DetailsAnimalsUserScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.breed,
      required this.type,
      required this.description});
  final String name;
  final String age;
  final String breed;
  final String type;
  final String description;

  @override
  State<DetailsAnimalsUserScreen> createState() =>
      _DetailsAnimalsUserScreenState();
}

class _DetailsAnimalsUserScreenState extends State<DetailsAnimalsUserScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar:
          AppBar(title: const Text('Pet Profile'), centerTitle: true, actions: [
        TextButton(onPressed: () {}, child: const Text('Edit')),
      ]),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.25,
                child: Image.asset(
                  'assets/image/cover_upload_dog.jpg',
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: size.height * 0.63,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TitleNameWidget(
                        name: widget.name,
                        content: 'Name',
                        isIcon: true,
                        icon: const Icon(Icons.edit),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                        endIndent: 2,
                      ),
                      const Spacer(),
                      TitleNameWidget(
                        content: 'Pet',
                        isIcon: false,
                        name: widget.type,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                        endIndent: 2,
                      ),
                      const Spacer(),
                      TitleNameWidget(
                        content: 'Pet Breed',
                        isIcon: false,
                        name: widget.breed,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                        endIndent: 2,
                      ),
                      const Spacer(),
                      TitleNameWidget(
                        content: 'Age',
                        isIcon: false,
                        name: widget.age,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                        endIndent: 2,
                      ),
                      const Spacer(),
                      TitleNameWidget(
                        content: 'Description',
                        isIcon: false,
                        name: widget.description,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                        endIndent: 2,
                      ),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TitleNameWidget extends StatefulWidget {
  TitleNameWidget(
      {super.key,
      this.isIcon = true,
      required this.name,
      this.title,
      this.icon,
      this.content});
  final String name;
  final String? title;
  final String? content;
  final Icon? icon;
  bool isIcon = false;

  @override
  State<TitleNameWidget> createState() => _TitleNameWidgetState();
}

class _TitleNameWidgetState extends State<TitleNameWidget> {
  bool isIcon = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.name,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Spacer(),
        isIcon
            ? Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.lightBlueAccent,
                ),
                child: widget.icon,
              )
            : Container(),
        Text(
          widget.title ?? '',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        Text(
          widget.content ?? '',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      ],
    );
  }
}
