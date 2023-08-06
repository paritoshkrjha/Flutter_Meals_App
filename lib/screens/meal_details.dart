import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favouriteMealsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favouriteMealsProvider.notifier)
                    .toggleMealFavouriteStatus(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(wasAdded
                        ? "Meal Added as a favourite "
                        : 'Meal Removed')));
              },
              icon: favouriteMeals.contains(meal)
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border))
        ],
      ),
      body: Column(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Ingredients",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              for (final ingredient in meal.ingredients)
                Text(
                  "- $ingredient",
                  style: TextStyle(color: Colors.white),
                ),
            ],
          )
        ],
      ),
    );
  }
}
