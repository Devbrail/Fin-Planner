import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'goal_state.dart';

class GoalCubit extends Cubit<GoalState> {
  GoalCubit() : super(GoalInitial());
}
