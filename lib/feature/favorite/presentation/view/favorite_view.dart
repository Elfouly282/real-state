import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_state/core/di.dart';
import 'package:real_state/feature/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:real_state/feature/favorite/presentation/widget/favorite_view_content.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return FavoriteViewContent();
  }
}