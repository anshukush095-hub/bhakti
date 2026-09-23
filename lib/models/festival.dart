import 'puja_item.dart';
import 'vidhi_step.dart';

class Festival {
  final String id;
  final String nameHindi;
  final String nameEnglish;
  final String dateHindi;
  final String fullDateHindi;
  final String imageAsset;
  final String description;
  final String muhurat;
  final int totalItems;
  int completedItems;
  final bool isSaved;
  final List<PujaItem> checklist;
  final List<VidhiStep> steps;

  Festival({
    required this.id,
    required this.nameHindi,
    required this.nameEnglish,
    required this.dateHindi,
    required this.fullDateHindi,
    required this.imageAsset,
    required this.description,
    required this.muhurat,
    required this.totalItems,
    this.completedItems = 0,
    this.isSaved = false,
    required this.checklist,
    required this.steps,
  });
}
