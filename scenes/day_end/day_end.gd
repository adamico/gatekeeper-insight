extends Control

const MAIN_MENU_SCENE = preload("res://scenes/main_menu.tscn")

@onready var day_label := %DayLabel
@onready var score_label := %ScoreLabel
@onready var rating_label := %RatingLabel
@onready var stats_container := %StatsContainer
@onready var week_summary_container := %WeekSummaryContainer
@onready var next_day_button := %NextDayButton
@onready var audio_stream_player := %AudioStreamPlayer


func _ready() -> void:
	GameStats.day_completed.connect(_on_day_completed)
	GameStats.week_completed.connect(_on_week_completed)
	next_day_button.pressed.connect(_on_next_day_button_pressed)
	visible = false


func _on_day_completed(day_number: int, score: float, rating: String) -> void:
	day_label.text = "Day %d Complete" % day_number
	score_label.text = "Score: %.1f%%" % score
	rating_label.text = "Rating: %s" % rating
	
	# Show daily stats
	var stats = GameStats.get_day_stats(day_number)
	%StatsContainer/TotalLabel.text = "Total visitors: %d" % (stats.admitted + stats.denied)
	%StatsContainer/AdmittedLabel.text = "Admitted: %d" % stats.admitted
	%StatsContainer/DeniedLabel.text = "Denied: %d" % stats.denied
	%StatsContainer/CorrectLabel.text = "Correct decisions: %d" % stats.correct
	%StatsContainer/IncorrectLabel.text = "Incorrect decisions: %d" % stats.incorrect
	
	week_summary_container.visible = false
	stats_container.visible = true
	
	visible = true


func _on_week_completed(average_score: float, overall_rating: String) -> void:
	day_label.text = "Week Complete!"
	score_label.text = "Average Score: %.1f%%" % average_score
	rating_label.text = "Overall Rating: %s" % overall_rating
	
	# Create a summary of all days
	var week_summary = %WeekSummaryContainer/WeekSummaryGrid
	week_summary.clear()
	
	# Add headers
	week_summary.add_item("Day")
	week_summary.add_item("Admitted")
	week_summary.add_item("Denied")
	week_summary.add_item("Score")
	week_summary.add_item("Rating")
	
	# Add each day's data
	for day in range(1, GameStats.DAYS_PER_WEEK + 1):
		var stats = GameStats.get_day_stats(day)
		week_summary.add_item(str(day))
		week_summary.add_item(str(stats.admitted))
		week_summary.add_item(str(stats.denied))
		week_summary.add_item("%.1f%%" % stats.score)
		week_summary.add_item(stats.rating)
	
	week_summary_container.visible = true
	stats_container.visible = false
	next_day_button.text = "Return to Menu"
	
	visible = true


func _on_next_day_button_pressed() -> void:
	audio_stream_player.play()
	if GameStats.current_day > GameStats.DAYS_PER_WEEK:
		# Week is over, return to main menu
		GameStats.reset_week()
		# Change scene to main menu or whatever is appropriate
		get_tree().change_scene_to_packed(MAIN_MENU_SCENE)
	else:
		# Continue to next day
		# You might want to transition to a "new day" screen or just continue
		EventBus.next_day_started.emit(GameStats.current_day)