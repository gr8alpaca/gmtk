@tool
class_name BackgroundLayer extends ParallaxLayer

const DEFAULT_TEXTURE: Texture2D = preload("res://Art/SpaceBackgrounds1024x1024/Large 1024x1024/Purple Nebula/Purple Nebula 5 - 1024x1024.png")

@export var texture: Texture2D = DEFAULT_TEXTURE:
    set(val):
        texture = val

        RenderingServer.canvas_item_clear(rid)
        var tex: Texture2D = texture if texture != null else DEFAULT_TEXTURE
        RenderingServer.canvas_item_add_texture_rect(rid, Rect2(Vector2.ZERO, tex.get_size()), tex.get_rid(), true)

var rect: Rect2
var rid: RID

func _init() -> void:
    motion_mirroring = DEFAULT_TEXTURE.get_size()
    rect = Rect2(Vector2.ZERO, DEFAULT_TEXTURE.get_size())
    rid = get_canvas_item()


func _notification(what: int) -> void:
    match what:

        NOTIFICATION_POST_ENTER_TREE:
            var tex: Texture2D = texture if texture != null else DEFAULT_TEXTURE
            RenderingServer.canvas_item_add_texture_rect(rid, rect, tex.get_rid(), false)
            print("Triggering....")
            
        NOTIFICATION_EXIT_TREE:
            RenderingServer.canvas_item_clear(rid)
