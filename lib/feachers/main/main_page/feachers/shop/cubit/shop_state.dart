part of 'shop_cubit.dart';

@immutable
sealed class ShopState {}

final class ShopInitial extends ShopState {}

class LoadingMealState extends ShopState {}

class RemoveNeedsState extends ShopState {}