extends Node2D

var enterCaveIntroSequence := 0
var isFriendlyCave := false
var enterCaveIntroText = PackedStringArray([
"You approach the cave...",
"It is dark and spooky...",
"You try to light a fire but it too damp...",
"A large dragon jumps out in front of you! He opens his jaws and..."
])

func startInitialIntro():
	$Start.visible = true
	$Result.visible = false
	$Start/AnimationPlayer.play("FadeIn")
	print(enterCaveIntroText.size())

func _ready() -> void:
	startInitialIntro()

func _on_button_1_pressed() -> void:
	print("Button 1 pressed!")
	caveSelected(1)

func _on_button_2_pressed() -> void:
	print("Button 2 pressed!")
	caveSelected(2)

func startApproachingCaveIntro():
	$Start.visible = false
	$Result.visible = true
	playApproachingCaveIntro()

func caveSelected(selectedCave: int):
	var friendlyCave := randi_range(1, 2)
	if(friendlyCave == selectedCave): isFriendlyCave = true
	print("isFriendlyCave:" + str(isFriendlyCave))
	startApproachingCaveIntro()
	
func playEndingIntro():
	if isFriendlyCave:
		$Result/AnimationPlayer.play("Friendly")
	else:
		$Result/AnimationPlayer.play("NotFriendly")
	
func playApproachingCaveIntro():
	if enterCaveIntroSequence < enterCaveIntroText.size():
		$Result/Intro.text = enterCaveIntroText[enterCaveIntroSequence]
		$Result/AnimationPlayer.play("FadeInAndStretchOut")
		enterCaveIntroSequence += 1
	else:
		playEndingIntro()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeInAndStretchOut":
		playApproachingCaveIntro()
	if anim_name == "Friendly" || anim_name == "NotFriendly":
		$Result/AnimationPlayer.play("TryAgain")

func _on_button_try_again_pressed() -> void:
	get_tree().reload_current_scene()
