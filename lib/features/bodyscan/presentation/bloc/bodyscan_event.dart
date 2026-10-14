import 'package:equatable/equatable.dart';

abstract class BodyscanEvent extends Equatable {
  const BodyscanEvent();

  @override
  List<Object?> get props => [];
}

class LoadBodyscanDataEvent extends BodyscanEvent {
  const LoadBodyscanDataEvent();
}

class TriggerNewScanEvent extends BodyscanEvent {
  const TriggerNewScanEvent();
}
