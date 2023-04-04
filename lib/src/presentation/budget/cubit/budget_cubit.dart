import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetInitial());
}
