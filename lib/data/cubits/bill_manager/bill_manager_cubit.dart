import 'package:flutter_bloc/flutter_bloc.dart';

import './bill_manager_state.dart';

class BillManagerCubit extends Cubit<BillManagerState> {
  BillManagerCubit() : super(BillManagerState());
}
