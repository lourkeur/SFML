module SFML.Graphics.Sprite
(
    createSprite
,   copySprite
,   destroySprite
,   setPosition
,   setRotation
,   setScale
,   setOrigin
,   getPosition
,   getRotation
,   getScale
,   getOrigin
,   move
,   rotate
,   scale
,   getTransform
,   getInverseTransform
,   setColor
,   getColor
,   setTexture
,   setTextureRect
,   getTexture
,   getTextureRect
,   getLocalBounds
,   getGlobalBounds
)
where


import SFML.Graphics.BlendMode
import SFML.Graphics.Color
import SFML.Graphics.Rect
import SFML.Graphics.Texturable
import SFML.Graphics.Transform
import SFML.Graphics.Transformable
import SFML.Graphics.Types
import SFML.System.Vector2

import Foreign.C.Types
import Foreign.Marshal.Alloc (alloca)
import Foreign.Marshal.Utils (with)
import Foreign.Ptr
import Foreign.Storable (peek)
import Unsafe.Coerce


checkNull :: Sprite -> Maybe Sprite
checkNull sprite@(Sprite ptr) =
    case (unsafeCoerce ptr) of
        0 -> Nothing
        _ -> Just sprite


checkNullTexture :: Texture -> Maybe Texture
checkNullTexture tex@(Texture ptr) =
    case (unsafeCoerce ptr) of
        0 -> Nothing
        _ -> Just tex


-- | Create a new sprite.
createSprite :: IO (Maybe Sprite)
createSprite = fmap checkNull sfSprite_create

foreign import ccall unsafe "sfSprite_create"
    sfSprite_create :: IO Sprite

-- \return A new sfSprite object, or NULL if it failed

--CSFML_GRAPHICS_API sfSprite* sfSprite_create(void);


-- | Copy an existing sprite.
copySprite :: Sprite -> IO Sprite
copySprite = sfSprite_copy

foreign import ccall unsafe "sfSprite_copy"
    sfSprite_copy :: Sprite -> IO Sprite

--CSFML_GRAPHICS_API sfSprite* sfSprite_copy(sfSprite* sprite);


-- | Destroy an existing sprite
destroySprite :: Sprite -> IO ()
destroySprite = sfSprite_destroy

foreign import ccall unsafe "sfSprite_destroy"
    sfSprite_destroy :: Sprite -> IO ()

--CSFML_GRAPHICS_API void sfSprite_destroy(sfSprite* sprite);


instance Transformable Sprite where
    
    setPosition sprite pos = with pos $ sfSprite_setPosition_helper sprite
    
    setRotation = sfSprite_setRotation
    
    setScale sprite s = with s $ sfSprite_setScale_helper sprite
    
    setOrigin sprite o = with o $ sfSprite_setOrigin_helper sprite
    
    getPosition sprite = alloca $ \ptr -> sfSprite_getPosition_helper sprite ptr >> peek ptr
    
    getRotation = sfSprite_getRotation
    
    getScale sprite = alloca $ \ptr -> sfSprite_getScale_helper sprite ptr >> peek ptr
    
    getOrigin sprite = alloca $ \ptr -> sfSprite_getOrigin_helper sprite ptr >> peek ptr
    
    move sprite off = with off $ sfSprite_move_helper sprite
    
    rotate = sfSprite_rotate
    
    scale sprite s = with s $ sfSprite_scale_helper sprite
    
    getTransform sprite = alloca $ \ptr -> sfSprite_getTransform_helper sprite ptr >> peek ptr
    
    getInverseTransform sprite = alloca $ \ptr -> sfSprite_getInverseTransform_helper sprite ptr >> peek ptr


foreign import ccall unsafe "sfSprite_setPosition_helper"
    sfSprite_setPosition_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfSprite_setPosition(sfSprite* sprite, sfVector2f position);

foreign import ccall unsafe "sfSprite_setRotation"
    sfSprite_setRotation :: Sprite -> Float -> IO ()

--CSFML_GRAPHICS_API void sfSprite_setRotation(sfSprite* sprite, float angle);

foreign import ccall unsafe "sfSprite_setScale_helper"
    sfSprite_setScale_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfSprite_setScale(sfSprite* sprite, sfVector2f scale);

foreign import ccall unsafe "sfSprite_setOrigin_helper"
    sfSprite_setOrigin_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfSprite_setOrigin(sfSprite* sprite, sfVector2f origin);

foreign import ccall unsafe "sfSprite_getPosition_helper"
    sfSprite_getPosition_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API sfVector2f sfSprite_getPosition(const sfSprite* sprite);

foreign import ccall unsafe "sfSprite_getRotation"
    sfSprite_getRotation :: Sprite -> IO Float

--CSFML_GRAPHICS_API float sfSprite_getRotation(const sfSprite* sprite);

foreign import ccall unsafe "sfSprite_getScale_helper"
    sfSprite_getScale_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API sfVector2f sfSprite_getScale(const sfSprite* sprite);

foreign import ccall unsafe "sfSprite_getOrigin_helper"
    sfSprite_getOrigin_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API sfVector2f sfSprite_getOrigin(const sfSprite* sprite);

foreign import ccall unsafe "sfSprite_move_helper"
    sfSprite_move_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfSprite_move(sfSprite* sprite, sfVector2f offset);

foreign import ccall unsafe "sfSprite_rotate"
    sfSprite_rotate :: Sprite -> Float -> IO ()

--CSFML_GRAPHICS_API void sfSprite_rotate(sfSprite* sprite, float angle);

foreign import ccall unsafe "sfSprite_scale_helper"
    sfSprite_scale_helper :: Sprite -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfSprite_scale(sfSprite* sprite, sfVector2f factors);

foreign import ccall unsafe "sfSprite_getTransform_helper"
    sfSprite_getTransform_helper :: Sprite -> Ptr Transform -> IO ()

--CSFML_GRAPHICS_API sfTransform sfSprite_getTransform(const sfSprite* sprite);

foreign import ccall unsafe "sfSprite_getInverseTransform_helper"
    sfSprite_getInverseTransform_helper :: Sprite -> Ptr Transform -> IO ()

--CSFML_GRAPHICS_API sfTransform sfSprite_getInverseTransform(const sfSprite* sprite);


-- | Set the global color of a sprite.
--
-- This color is modulated (multiplied) with the sprite's
-- texture. It can be used to colorize the sprite, or change
-- its global opacity.
-- By default, the sprite's color is opaque white.
setColor :: Sprite -> Color -> IO ()
setColor sprite color = with color $ sfSprite_setColor_helper sprite

foreign import ccall unsafe "sfSprite_setColor_helper"
    sfSprite_setColor_helper :: Sprite -> Ptr Color -> IO ()

--CSFML_GRAPHICS_API void sfSprite_setColor(sfSprite* sprite, sfColor color);


-- | Get the global color of a sprite.
getColor :: Sprite -> IO Color
getColor sprite = alloca $ \ptr -> sfSprite_getColor_helper sprite ptr >> peek ptr

foreign import ccall unsafe "sfSprite_getColor_helper"
    sfSprite_getColor_helper :: Sprite -> Ptr Color -> IO ()

--CSFML_GRAPHICS_API sfColor sfSprite_getColor(const sfSprite* sprite);


instance Texturable Sprite where
    
    setTexture sprite tex reset = sfSprite_setTexture sprite tex (fromIntegral . fromEnum $ reset)
    
    setTextureRect sprite rect = with rect $ sfSprite_setTextureRect_helper sprite
    
    getTexture = fmap checkNullTexture . sfSprite_getTexture
    
    getTextureRect sprite = alloca $ \ptr -> sfSprite_getTextureRect_helper sprite ptr >> peek ptr

foreign import ccall unsafe "sfSprite_setTexture"
    sfSprite_setTexture :: Sprite -> Texture -> CInt -> IO ()

--CSFML_GRAPHICS_API void sfSprite_setTexture(sfSprite* sprite, const sfTexture* texture, sfBool resetRect);


foreign import ccall unsafe "sfSprite_setTextureRect_helper"
    sfSprite_setTextureRect_helper :: Sprite -> Ptr IntRect -> IO ()

--CSFML_GRAPHICS_API void sfSprite_setTextureRect(sfSprite* sprite, sfIntRect rectangle);


foreign import ccall unsafe "sfSprite_getTexture"
    sfSprite_getTexture :: Sprite -> IO Texture

-- \return Pointer to the sprite's texture (can be null)

--CSFML_GRAPHICS_API const sfTexture* sfSprite_getTexture(const sfSprite* sprite);


foreign import ccall unsafe "sfSprite_getTextureRect_helper"
    sfSprite_getTextureRect_helper :: Sprite -> Ptr IntRect -> IO ()

--CSFML_GRAPHICS_API sfIntRect sfSprite_getTextureRect(const sfSprite* sprite);


-- | Get the local bounding rectangle of a sprite.
--
-- The returned rectangle is in local coordinates, which means
-- that it ignores the transformations (translation, rotation,
-- scale, ...) that are applied to the entity.
--
-- In other words, this function returns the bounds of the
-- entity in the entity's coordinate system.
getLocalBounds
    :: Sprite -- ^ Sprite object
    -> IO FloatRect -- ^ Local bounding rectangle of the entity

getLocalBounds sprite = alloca $ \ptr -> sfSprite_getLocalBounds_helper sprite ptr >> peek ptr

foreign import ccall unsafe "sfSprite_getLocalBounds_helper"
    sfSprite_getLocalBounds_helper :: Sprite -> Ptr FloatRect -> IO ()

--CSFML_GRAPHICS_API sfFloatRect sfSprite_getLocalBounds(const sfSprite* sprite);


-- | Get the global bounding rectangle of a sprite
--
-- The returned rectangle is in global coordinates, which means
-- that it takes in account the transformations (translation,
-- rotation, scale, ...) that are applied to the entity.
--
-- In other words, this function returns the bounds of the
-- sprite in the global 2D world's coordinate system.
getGlobalBounds
    :: Sprite -- ^ Sprite object
    -> IO FloatRect -- ^ Global bounding rectangle of the entity

getGlobalBounds sprite = alloca $ \ptr -> sfSprite_getGlobalBounds_helper sprite ptr >> peek ptr

foreign import ccall unsafe "sfSprite_getGlobalBounds_helper"
    sfSprite_getGlobalBounds_helper :: Sprite -> Ptr FloatRect -> IO ()

--CSFML_GRAPHICS_API sfFloatRect sfSprite_getGlobalBounds(const sfSprite* sprite);
