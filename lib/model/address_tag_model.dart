class AddressTagModel {
  String tagName;
  bool isSelected;

  AddressTagModel({required this.tagName, required this.isSelected});

  AddressTagModel copyWith({
    String? tagName,
    bool? isSelected,
  }) {
    return AddressTagModel(
      tagName: tagName ?? this.tagName,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
