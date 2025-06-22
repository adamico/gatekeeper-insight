extends Node

signal day_completed(day_number: int, score: float, rating: String)
signal week_completed(average_score: float, overall_rating: String)

const DAYS_PER_WEEK := 7

var current_day := 1
var daily_stats := []  # Array of DayStats objects

# Current day's running statistics
var admitted_count := 0
var denied_count := 0
var correct_decisions := 0
var incorrect_decisions := 0
var daily_goal := 10  # Configurable target
var remaining_visitors := daily_goal  # Visitors to process this day


class DayStats:
    var day_number: int
    var admitted: int
    var denied: int
    var correct: int
    var incorrect: int
    var score: float
    var rating: String
    

    func _init(day: int, a: int, d: int, c: int, i: int) -> void:
        day_number = day
        admitted = a
        denied = d
        correct = c
        incorrect = i
        score = float(c) / (c + i) * 100.0 if (c + i) > 0 else 0.0
        rating = calculate_rating(score)
    

    static func calculate_rating(score_value: float) -> String:
        if score_value >= 90.0:
            return "A"
        elif score_value >= 80.0:
            return "B"
        elif score_value >= 70.0:
            return "C" 
        elif score_value >= 60.0:
            return "D"
        else:
            return "F"


func _ready() -> void:
    EventBus.visitor_admitted.connect(_on_visitor_admitted)
    EventBus.visitor_denied.connect(_on_visitor_denied)


func _on_visitor_admitted(visitor_stats: VisitorStats) -> void:
    admitted_count += 1
    # Determine if admission was correct based on visitor profile
    if visitor_stats.should_be_admitted():
        correct_decisions += 1
    else:
        incorrect_decisions += 1
    remaining_visitors -= 1
    _check_day_completion()


func _on_visitor_denied(visitor_stats: VisitorStats) -> void:
    denied_count += 1
    # Determine if denial was correct based on visitor profile
    if !visitor_stats.should_be_admitted():
        correct_decisions += 1
    else:
        incorrect_decisions += 1
    remaining_visitors -= 1
    _check_day_completion()


func _check_day_completion() -> void:
    var total_processed = admitted_count + denied_count
    if total_processed >= daily_goal:
        # Store this day's stats
        var day_stats = DayStats.new(
            current_day,
            admitted_count,
            denied_count,
            correct_decisions,
            incorrect_decisions
        )
        daily_stats.append(day_stats)
        
        # Emit day completed signal
        day_completed.emit(current_day, day_stats.score, day_stats.rating)
        
        # Check if week is complete
        if current_day >= DAYS_PER_WEEK:
            _complete_week()
        else:
            current_day += 1
            reset_daily_stats()


func _complete_week() -> void:
    var total_score := 0.0
    for stats in daily_stats:
        total_score += stats.score
    
    var average_score = total_score / daily_stats.size()
    var overall_rating = DayStats.calculate_rating(average_score)
    
    week_completed.emit(average_score, overall_rating)


func reset_daily_stats() -> void:
    admitted_count = 0
    denied_count = 0
    correct_decisions = 0
    incorrect_decisions = 0
    remaining_visitors = daily_goal


func reset_week() -> void:
    current_day = 1
    daily_stats.clear()
    reset_daily_stats()


func get_day_stats(day_number: int) -> DayStats:
    for stats in daily_stats:
        if stats.day_number == day_number:
            return stats
    return null