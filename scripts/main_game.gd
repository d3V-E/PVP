extends Node2D




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
@onready var sheidl :TextureButton = $"Main Canvas/Sheild"



func _ready():
	healbackground.visible = false
	dmgbackground.visible = false



func damageanim():
	dmgbackground.visible = true
	await get_tree().create_timer(0.5).timeout
	dmgbackground.visible = false


func healanim():
	healbackground.visible = true
	await get_tree().create_timer(0.5).timeout
	healbackground.visible = false
