import 'package:blitter_flutter_app/data/cubits.dart';
import 'package:blitter_flutter_app/data/models.dart';

class PaymentScreenArguments {
  final Bill bill;
  final double amount;
  final String receiverName;
  final String receiverPaymentAddress;
  final BillModalCubit billModalCubit;

  const PaymentScreenArguments({
    required this.bill,
    required this.amount,
    required this.receiverName,
    required this.receiverPaymentAddress,
    required this.billModalCubit,
  });
}
