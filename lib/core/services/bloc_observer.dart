
import 'package:flutter_bloc/flutter_bloc.dart';

// Custom BlocObserver to monitor Bloc events, transitions, and states
class SimpleBlocObserver extends BlocObserver {
  // Called whenever an event is added to any Bloc
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('Event added to ${bloc.runtimeType}: $event');
  }

  // Called whenever a transition occurs (state changes)
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('Transition in ${bloc.runtimeType}: $transition');
  }

  // Called whenever a state change occurs
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('State changed in ${bloc.runtimeType}: $change');
  }

  // Called when an error occurs in a Bloc
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('Error in ${bloc.runtimeType}: $error\nStackTrace: $stackTrace');
  }

  // Called when a Bloc is created
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('Bloc created: ${bloc.runtimeType}');
  }

  // Called when a Bloc is closed
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('Bloc closed: ${bloc.runtimeType}');
  }
}

