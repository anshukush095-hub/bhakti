class PujaItem {
  final String id;
  final String nameHindi;
  final String? nameEnglish;
  final String quantity;
  final String imageAsset;
  bool isPurchased;

  PujaItem({
    required this.id,
    required this.nameHindi,
    this.nameEnglish,
    required this.quantity,
    required this.imageAsset,
    this.isPurchased = false,
  });

  PujaItem copyWith({
    String? id,
    String? nameHindi,
    String? nameEnglish,
    String? quantity,
    String? imageAsset,
    bool? isPurchased,
  }) {
    return PujaItem(
      id: id ?? this.id,
      nameHindi: nameHindi ?? this.nameHindi,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      quantity: quantity ?? this.quantity,
      imageAsset: imageAsset ?? this.imageAsset,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }
}
