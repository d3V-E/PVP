extends Node2D



@onready var pointerp1:Sprite2D = $"Main Canvas/Pointer1"
@onready var pointerp2:Sprite2D = $"Main Canvas/Pointer2"
@onready var healbackground:Sprite2D = $"Main Canvas/Heal"
@onready var dmgbackground:Sprite2D = $"Main Canvas/Damage"
@onready var strike:TextureButton = $"Main Canvas/Strike"
@onready var vampire:TextureButton = $"Main Canvas/Vampire"
@onready var meteor:TextureButton = $"Main Canvas/Meteor"
@onready var quickheal:TextureButton = $"Main Canvas/Quick Heal"
@onready var clean:TextureButton = $"Main Canvas/Clean"
@onready var light:TextureButton = $"Main Canvas/Light"
@onready var minipotion:TextureButton = $"Main Canvas/Mini poison"
@onready var plague:TextureButton = $"Main Canvas/Plague"
@onready var boost:TextureButton = $"Main Canvas/Boost"
@onready var sheild :TextureButton = $"Main Canvas/Sheild"

@onready var p1ht : RichTextLabel = $"Main Canvas/Header/Player 1 Health"
@onready var p2ht:RichTextLabel = $"Main Canvas/Header/Player 2 Health"

var player1h = 500
var player2h = 500
var player1max = 1000
var player2max = 1000
var turn = "PLAYER1"
var player1boost = 1
var player2boost = 1


var strikedmg = 75


var vampiredmg = 65
var vampireheal = 35
var vampirep1 = 0
var vampirep2 = 0

var meteordmg = 150
var meteorp1 = 0
var meteorp2 = 0

var quickhealc = 50

var cleanp1 = 0
var cleanp2 = 0
var passivedmgp1 = false
var passivedmgp2 = false
var cleanheal = 30

var lightheal = 125
var lightcp1 = 0
var lightcp2 = 0


func _ready():
	healbackground.visible = false
	dmgbackground.visible = false
	strike.pivot_offset = strike.size / 2
	vampire.pivot_offset = vampire.size / 2
	meteor.pivot_offset = meteor.size / 2
	quickheal.pivot_offset = quickheal.size / 2
	clean.pivot_offset = clean.size / 2
	light.pivot_offset = light.size / 2
	minipotion.pivot_offset = minipotion.size / 2
	plague.pivot_offset = plague.size / 2
	boost.pivot_offset = boost.size / 2
	sheild.pivot_offset = sheild.size / 2
	vampire.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
	meteor.self_modulate = Color(1.0 ,1.0 , 1.0 , 1.0)
	clean.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
	light.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
	update_ui()
	p1ht.text = str(player1h) + " / " + str(player1max)
	p2ht.text = str(player2h) + " / " + str(player2max)



func damageanim():
	dmgbackground.visible = true
	await get_tree().create_timer(0.2).timeout
	dmgbackground.visible = false


func healanim():
	healbackground.visible = true
	await get_tree().create_timer(0.2).timeout
	healbackground.visible = false







func _on_strike_button_down():
	var tween = get_tree().create_tween()
	tween.tween_property(strike , "scale" , Vector2(.9 ,.9), .1)





func _on_strike_button_up():
	var tween = get_tree().create_tween()
	tween.tween_property(strike , "scale" , Vector2(1 , 1) , .1)
	if turn == "PLAYER1":
		player2h -= 75
		p2ht.text = str(player2h) + " / " + str(player2max)
		damageanim()
		turncooldown()
		turn = "PLAYER2"
		update_ui()
	elif turn == "PLAYER2":
		player1h -= 75
		p1ht.text = str(player1h) + " / " + str(player1max)
		damageanim()
		turncooldown()
		turn = "PLAYER1"
		update_ui()



func update_ui():
	p1ht.text = str(player1h) + " / " + str(player1max)
	p2ht.text = str(player2h) + " / " + str(player2max)
	if turn == "PLAYER1":
		pointerp1.visible = true
		pointerp2.visible = false
		if vampirep1 > 0:
			vampire.self_modulate = Color(0.3 , 0.3 , 0.3 , 1.0)
		else:
			vampire.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
	
		if meteorp1 > 0:
			meteor.self_modulate = Color(0.3 , 0.3 , 0.3 , 1.0)
		else:
			meteor.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
		
		if cleanp1 > 0:
			clean.self_modulate = Color(0.3 , 0.3 , 0.3 , 1.0)
		else:
			clean.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
		
		if lightcp1 > 0:
			light.self_modulate = Color(0.3 , 0.3 , 0.3 , 1.0)
		else:
			light.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
	
	
	elif turn == "PLAYER2":
		pointerp1.visible = false
		pointerp2.visible = true
		if vampirep2 > 0:
			vampire.self_modulate = Color(0.3 , 0.3 , 0.3 , 1.0)
		else:
			vampire.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
	
		if meteorp2 > 0:
			meteor.self_modulate = Color(0.3 ,0.3 , 0.3 , 1.0)
		else:
			meteor.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0 )
		
		if cleanp2 > 0:
			clean.self_modulate = Color(0.3 , 0.3 , 0.3 , 1.0)
		else:
			clean.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)
		
		if lightcp2 > 0:
			light.self_modulate = Color(0.3 , 0.3 , 0.3 , 1.0)
		else:
			light.self_modulate = Color(1.0 , 1.0 , 1.0 , 1.0)




func _on_auto_update_timeout():
	update_ui()






func _on_vampire_button_down():
	if turn == "PLAYER1" and vampirep1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(vampire , "scale" , Vector2(.9 ,.9) , .1)
	if turn == "PLAYER2" and vampirep2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(vampire , "scale" , Vector2(.9 ,.9) ,.1)






func _on_vampire_button_up():
	if turn == "PLAYER1" and vampirep1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(vampire , "scale" , Vector2(1 ,1) , .1)
		player1h += vampireheal
		player2h -= vampiredmg
		vampirep1 = 2
		turncooldown()
		turn = "PLAYER2"
		update_ui()
		healanim()
		damageanim()
	
	
	
	elif turn == "PLAYER2" and vampirep2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(vampire , "scale" , Vector2(1 ,1) ,.1)
		player2h += vampireheal
		player1h -= vampiredmg
		vampirep2 = 2
		turncooldown()
		turn = "PLAYER1"
		update_ui()
		healanim()
		damageanim()



func turncooldown():
	if turn == "PLAYER1":
		if vampirep1 > 0:
			vampirep1 -= 1
		
		if meteorp1 > 0:
			meteorp1 -= 1
		
		if cleanp1 > 0:
			cleanp1 -= 1
	elif turn == "PLAYER2":
		if vampirep2 > 0:
			vampirep2 -= 1
		
		if meteorp2 > 0:
			meteorp2 -= 1
		
		if cleanp2 > 0:
			cleanp2 -= 1











func _on_meteor_button_down():
	if turn == "PLAYER1" and meteorp1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(meteor , "scale" , Vector2(.9 ,.9) , .1)
	if turn == "PLAYER2" and meteorp2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(meteor , "scale" , Vector2(.9 ,.9) ,.1)





func _on_meteor_button_up():
	if turn == "PLAYER1" and meteorp1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(meteor , "scale" , Vector2(1 ,1) , .1)
		player2h -= meteordmg
		meteorp1 = 4
		turncooldown()
		turn = "PLAYER2"
		update_ui()
		damageanim()
	
	
	elif turn == "PLAYER2" and meteorp2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(meteor , "scale" , Vector2(1 ,1) ,.1)
		player1h -= meteordmg
		meteorp2 = 4
		turncooldown()
		turn = "PLAYER1"
		update_ui()
		damageanim()




func _on_quick_heal_button_down():
	var tween = get_tree().create_tween()
	tween.tween_property(quickheal , "scale" , Vector2(.9 ,.9) , .1)





func _on_quick_heal_button_up():
	var tween = get_tree().create_tween()
	tween.tween_property(quickheal , "scale" , Vector2(1 , 1) , .1)
	if turn == "PLAYER1":
		player1h += 50
		p1ht.text = str(player1h) + " / " + str(player1max)
		healanim()
		turncooldown()
		turn = "PLAYER2"
		update_ui()
	elif turn == "PLAYER2":
		player2h += 50
		p2ht.text = str(player2h) + " / " + str(player2max)
		healanim()
		turncooldown()
		turn = "PLAYER1"
		update_ui()








func _on_clean_button_down():
	if turn == "PLAYER1" and cleanp1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(clean , "scale" , Vector2(.9 ,.9) , .1)
	if turn == "PLAYER2" and cleanp2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(clean , "scale" , Vector2(.9 ,.9) ,.1)




func _on_clean_button_up():
	if turn == "PLAYER1" and cleanp1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(clean , "scale" , Vector2(1 ,1) , .1)
		player1h += cleanheal
		cleanp1 = 2
		turncooldown()
		turn = "PLAYER2"
		update_ui()
		healanim()
	
	
	
	
	elif turn == "PLAYER2" and cleanp2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(clean , "scale" , Vector2(1 ,1) ,.1)
		player2h += cleanheal
		cleanp2 = 2
		turncooldown()
		turn = "PLAYER1"
		update_ui()
		healanim()






func _on_light_button_down():
	if turn == "PLAYER1" and lightcp1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(light , "scale" , Vector2(.9 ,.9) , .1)
	if turn == "PLAYER2" and lightcp2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(light , "scale" , Vector2(.9 ,.9) ,.1)




func _on_light_button_up():
	if turn == "PLAYER1" and lightcp1 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(light , "scale" , Vector2(1 ,1) , .1)
		player1h += lightheal
		lightcp1 = 3
		turncooldown()
		turn = "PLAYER2"
		update_ui()
		healanim()
	
	elif turn == "PLAYER2" and lightcp2 == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(light , "scale" , Vector2(1 ,1) ,.1)
		player2h += lightheal
		lightcp2 = 3
		turncooldown()
		turn = "PLAYER1"
		update_ui()
		healanim()
