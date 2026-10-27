import 'package:flutter/material.dart';
import '../data/firestore_service.dart';
import '../data/mock_data.dart';
import '../models/estate.dart';
import '../models/filter_category.dart';
import '../models/navigation_tab.dart';

class EstateController extends ChangeNotifier {
  List<Estate> _allEstates = [
    MockData.featuredEstate,
    ...MockData.popularEstates,
  ];
  final List<Estate> _savedEstates = List.from(MockData.savedEstates);
  FilterCategory _selectedCategory = FilterCategory.all;
  String _selectedMapEstateId = 'the-glass-pavilions';
  NavigationTab _currentTab = NavigationTab.explore;
  bool _forceEmptySaved = false;
  bool _isLoading = false;

  EstateController() {
    loadFromFirebase();
  }

  Future<void> loadFromFirebase() async {
    _isLoading = true;
    notifyListeners();

    try {
      final remote = await FirestoreService.fetchEstates();
      if (remote.isNotEmpty) {
        _allEstates = remote;

        // Sync saved list from remote properties marked as saved
        final remoteSaved = remote.where((e) => e.isSaved).toList();
        if (remoteSaved.isNotEmpty) {
          _savedEstates.clear();
          _savedEstates.addAll(remoteSaved);
        }
      }
    } catch (_) {
      // Graceful fallback to MockData
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Estate> get allEstates => _allEstates;
  bool get isLoading => _isLoading;

  Estate get featuredEstate => _allEstates.firstWhere(
        (e) => e.isFeatured,
        orElse: () => _allEstates.first,
      );

  List<Estate> get popularEstates =>
      _allEstates.where((e) => e.id != featuredEstate.id).toList();

  List<Estate> get savedEstates => _forceEmptySaved ? [] : _savedEstates;
  int get totalSavedCount => _forceEmptySaved ? 0 : _savedEstates.length;
  FilterCategory get selectedCategory => _selectedCategory;
  String get selectedMapEstateId => _selectedMapEstateId;
  NavigationTab get currentTab => _currentTab;
  bool get forceEmptySaved => _forceEmptySaved;

  Estate get selectedMapEstate {
    return _allEstates.firstWhere(
      (e) => e.id == _selectedMapEstateId,
      orElse: () => MockData.getEstateById(_selectedMapEstateId),
    );
  }

  bool isEstateSaved(String id) {
    if (_forceEmptySaved) return false;
    return _savedEstates.any((e) => e.id == id);
  }

  void toggleSave(String id) {
    final index = _savedEstates.indexWhere((e) => e.id == id);
    if (index >= 0) {
      _savedEstates.removeAt(index);
    } else {
      final estate = _allEstates.firstWhere(
        (e) => e.id == id,
        orElse: () => MockData.getEstateById(id),
      );
      _savedEstates.add(estate.copyWith(isSaved: true));
    }
    notifyListeners();
  }

  void selectCategory(FilterCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void selectMapEstate(String id) {
    _selectedMapEstateId = id;
    notifyListeners();
  }

  void navigateToTab(NavigationTab tab) {
    _currentTab = tab;
    notifyListeners();
  }

  void toggleEmptySavedState() {
    _forceEmptySaved = !_forceEmptySaved;
    notifyListeners();
  }
}
