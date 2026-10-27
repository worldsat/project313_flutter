enum FilterCategory {
  all(label: 'All Homes', isEco: false),
  villas(label: 'Villas', isEco: false),
  penthouses(label: 'Penthouses', isEco: false),
  ecoHomes(label: 'Eco-Homes', isEco: true);

  final String label;
  final bool isEco;

  const FilterCategory({
    required this.label,
    required this.isEco,
  });
}
