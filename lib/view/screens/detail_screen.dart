import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final recipe = Get.arguments;

    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Stack(
                  children: [
                    Image.network(
                      recipe?['imageUrl'],
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              size: 30,
                            ))),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_outline),
                        onPressed: () {
                          const Icon(Icons.favorite_outlined);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe['recipeName'],
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const Text(
                      'Ingredients:',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipe['ingredients'].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(recipe['ingredients'][index]),
                        );
                      },
                    ),
                    const SizedBox(height: 17),
                    const Text(
                      'Instructions:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recipe['instructions'].length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            '${index + 1}. ${recipe['instructions'][index]}',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    )));
  }
}
