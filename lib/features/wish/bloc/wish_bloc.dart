import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wish_event.dart';
part 'wish_state.dart';

class WishBloc extends Bloc<WishEvent, WishState> {
  WishBloc() : super(WishInitial()) {
    on<WishEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
