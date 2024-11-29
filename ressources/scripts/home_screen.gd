extends Control

#-------------------------------Fonction-------------------------------
func _on_play_button_pressed():
	# Bascule sur la scène de jeu (platformer.tscn) si on clique sur le bouton "play"
	get_tree().change_scene_to_file("res://scenes/platformer.tscn")

func _on_options_button_pressed():
	# Envoie le message "Options button pressed!" si on clique sur le bouton "Options"
	print("Options button pressed!")

func _on_quit_button_pressed():
	# Stop le programme si on clique sur le bouton "Quit"
	get_tree().quit()
