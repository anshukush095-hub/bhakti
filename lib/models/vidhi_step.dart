class VidhiStep {
  final int stepNumber;
  final String shortTitle; // e.g. "संकल्प", "आचमन", "अभिषेक", "पूजा", "आरती"
  final String fullTitle;  // e.g. "आचमन करें"
  final String instruction;
  final String mantra;
  final String audioLabel;

  const VidhiStep({
    required this.stepNumber,
    required this.shortTitle,
    required this.fullTitle,
    required this.instruction,
    required this.mantra,
    required this.audioLabel,
  });
}
