class Event {
  final String title;
  final String imageUrl;
  final String venue;
  final String expectedPopulation;
  final String entryFee;
  final String highlights;
  final bool isBooked;
  final DateTime date; // Add this field

  Event({
    required this.title,
    required this.imageUrl,
    required this.venue,
    required this.expectedPopulation,
    required this.entryFee,
    required this.highlights,
    required this.date,
    this.isBooked = false, // Default to false
  });
}
