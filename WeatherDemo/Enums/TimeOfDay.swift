enum TimeOfDay: Equatable {
    case day
    case night

    static func from(timeOfCalculation: Int,
                     timeOfSunrise: Int,
                     timetimeOfSunset: Int) -> Self {
        (timeOfSunrise...timetimeOfSunset).contains(timeOfCalculation) ? .day : .night
    }
}
