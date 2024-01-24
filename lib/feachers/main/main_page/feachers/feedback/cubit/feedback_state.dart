part of 'feedback_cubit.dart';

@immutable
sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

class ChangericepState extends FeedbackState {}

class ChangeRicepState extends FeedbackState {}

class ChangeValueState extends FeedbackState {}

class GetMealforFeedbackState extends FeedbackState {}

class GetMealState extends FeedbackState {}

class LoadingMealState extends FeedbackState {}

class AddRateState extends FeedbackState {}

class PublishFeedbackState extends FeedbackState {}
