import 'package:flutter/material.dart';

import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';
import '../components/components.dart';

class RecipesScreen extends StatelessWidget {
  final exploreService = MockFooderlichService();

  RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // TODO: Add RecipesGridView here
          return const Center(child: Text('Recipes Screen'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}