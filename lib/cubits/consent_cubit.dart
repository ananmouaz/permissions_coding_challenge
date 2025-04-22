import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/consent_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import 'consent_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConsentCubit extends Cubit<ConsentState> {
  final ApiService _apiService;
  final StorageService _storageService;

  ConsentCubit({
    required ApiService apiService,
    required StorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService,
        super(ConsentState.initial()) {
    // Load saved consent settings when cubit is created
    loadSavedConsent();
  }

  // Load consent settings from local storage
  Future<void> loadSavedConsent() async {
    final savedConsent = await _storageService.loadConsent();
    emit(state.copyWith(consent: savedConsent));
  }

  // Update consent settings
  Future<void> updateConsent({
    bool? shareLocation,
    bool? shareUsageAnalytics,
    bool? shareCrashReports,
  }) async {
    final updatedConsent = state.consent.copyWith(
      shareLocation: shareLocation,
      shareUsageAnalytics: shareUsageAnalytics,
      shareCrashReports: shareCrashReports,
    );

    // Save to local storage
    final saved = await _storageService.saveConsent(updatedConsent);

    if (saved) {
      emit(state.copyWith(consent: updatedConsent));
      Fluttertoast.showToast(
        msg: "Settings saved",
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Failed to save settings",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  // Sync consent settings with the API
  Future<void> syncConsent() async {
    // Update state to pending
    emit(state.copyWith(syncStatus: SyncStatus.pending));

    // Send data to API (real implementation)
    try {
      final result = await _apiService.sendConsentData(state.consent);

      if (result == ApiResult.success) {
        emit(state.copyWith(syncStatus: SyncStatus.synced));
      } else {
        emit(state.copyWith(syncStatus: SyncStatus.failed));
      }
    } catch (e) {
      emit(state.copyWith(syncStatus: SyncStatus.failed));
    }
  }

  // For demo: Simulate API success
  Future<void> simulateSuccessSync() async {
    emit(state.copyWith(syncStatus: SyncStatus.pending));

    final result = await _apiService.simulateSuccess();

    if (result == ApiResult.success) {
      emit(state.copyWith(syncStatus: SyncStatus.synced));
    }
  }

  // For demo: Simulate API failure
  Future<void> simulateFailureSync() async {
    emit(state.copyWith(syncStatus: SyncStatus.pending));

    final result = await _apiService.simulateFailure();

    if (result == ApiResult.failure) {
      emit(state.copyWith(syncStatus: SyncStatus.failed));
    }
  }

  // Retry sync
  Future<void> retrySync() async {
    await syncConsent();
  }
}