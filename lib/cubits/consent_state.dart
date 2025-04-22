import 'package:equatable/equatable.dart';
import '../models/consent_model.dart';

enum SyncStatus { initial, pending, synced, failed }

class ConsentState extends Equatable {
  final ConsentModel consent;
  final SyncStatus syncStatus;

  const ConsentState({
    required this.consent,
    this.syncStatus = SyncStatus.initial,
  });

  // Initial state factory constructor
  factory ConsentState.initial() {
    return ConsentState(
      consent: ConsentModel(),
    );
  }

  // Copy with method to create a new state with updated values
  ConsentState copyWith({
    ConsentModel? consent,
    SyncStatus? syncStatus,
  }) {
    return ConsentState(
      consent: consent ?? this.consent,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  List<Object> get props => [consent, syncStatus];
}