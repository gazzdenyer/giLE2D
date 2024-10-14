#Include "player.agc"
#Include "maploader.agc"
#Include "collisions.agc"
#Include "media.agc"
#Include "particles.agc"

setvirtualresolution(1136,640)
setdefaultwrapu(1)
setsyncrate(60, 1)
setphysicsgravity(0, 200)

type TSpritemap_Data // this defines ALL sprite objects, apart from the player
  Layer as integer
  id as integer
  Xcoord as integer
  Ycoord as integer
  Xsize as integer
  Ysize as integer
  Xoffset as integer
  Yoffset as integer
  physics as integer
  shape as integer
  IsMapGeometry as integer
  IsExplodable as integer
  IsCollectable as integer
  PointsValue as integer
  ColHealthValue as integer
  IsEnemy as integer
  IsFriend as integer
  HealthValue as integer
  MoneyValue as integer
  IsMovingPlatform as integer
  pXmoveFrom as integer
  pXmoveTo as integer
  pYmoveFrom as integer
  pYmoveTo as integer
  mp_direction as integer
  pVelocity as integer
  IsSpringboard as integer
  SpringForce as integer
  IsTeleporter as integer
  TeleportX as integer
  TeleportY as integer
  PlayerStartMarker as integer
  FileName as string
endtype

type TPlayer
  id as integer
  health as integer // default at 100
  armour as integer // default at 50
  points as integer
  money as integer
  isdead as integer // 0 - alive, 1 - dead
  jump_power as integer // default to 120
  move_speed_ground as integer // default to 100
  move_speed_air as integer // default to 50
  rFrame as integer // right - moving anim
  lFrame as integer // left - moving frame
  framecounter as integer // anim frame counter
  PlayerJump // sound
  PlayerStep // sound
  PlayerCrump // sound
  HealthSound // sound
  Springboard // sound
  Teleport // sound
  xcoord as integer
  ycoord as integer
endtype

type TParticle
  id as integer
  timecreated as float
  lifespan as float
  currentage as float
  image as integer
  active as integer
endtype

global APlatform as integer

global g_speed_factor# = 0.004
global g_scroll_repeater = 3

backdropIM2 = loadimage("back1.png")
backdropSP2 = createsprite(backdropIM2)
setspritesize(backdropSP2,1136,640)

backdropIM = loadimage("range1.png")
backdropSP = createsprite(backdropIM)
setspritesize(backdropSP,1136,640)

backdropIM3 = loadimage("calibration1.png")
backdropSP3 = createsprite(backdropIM3)
setspritesize(backdropSP3,1136,640)

// The player
global g_player as TPlayer

global g_curr_map_counter as integer
g_curr_map_counter = 0

global g_spritemap_data as TSpritemap_Data
//global g_actual_sprite // DIM this in maploader.agk, function loadmap()
global g_nongeo_cnt as integer // count of sprites that are not simple map geometry

// NOTE: we can use undim command to deallocate arrays at newmapload time
// also, not full support for dynamic arrays -  setting sizeof for example
global dim g_movingPlatform[20] as TSpritemap_Data
global g_mpcount as integer // count of moving platforms

//global g_mapgeo_sprite // DIM this in maploader.agk, function loadmap()
global g_mapgeocnt as integer // count of all sprites

global g_player_stop#
g_player_stop# = 1

// Global text objects
global g_txtScore as integer
global g_txtHealth as integer
global g_txtPoints as integer
global g_txtMoney as integer

// Glyphs
global g_healthglyph as integer
global g_pointsglyph as integer
global g_moneyglyph as integer

// particles
global g_healthparticle as TParticle // health particle

// set default music volume TODO: make this configurable
SetMusicSystemVolume(20)

// change this global to either use keyboard or virtual joystick for player control
// 0 = joystick, 1 = keyboard
g_keyboard = GetKeyboardExists()

if (g_keyboard = 0) or (g_keyboard = 2)
  global g_Jump_Button = 1
  global g_Fire_Button = 2	
  addvirtualjoystick(1, 1052, 560, 140)
  addvirtualbutton(g_Jump_Button, 48, 590, 90) // jump button
  btnJumpUp = LoadImage("btnjumpup.png")
  btnJumpDown = LoadImage("btnjumpdown.png")
  setvirtualbuttonimageup(g_Jump_Button, btnJumpUp)
  setvirtualbuttonimagedown(g_Jump_Button, btnJumpDown)
endif

// load media
LoadSounds()
// load text objects
LoadTextObjects()
// load particle images
LoadParticles()
// load map
LoadNextMap() // in maploader.agc

sleep(250)

// ********************* MAIN LOOP ***************************
do

  // FOR DEBUG OUTPUT
  //print("player vel: " + str(abs(GetSpritePhysicsVelocityX(g_player.id))))
  //print("xscroll = " + str(xscroll#))

  // left
  if getrawkeystate(37) = 1
    if abs(GetSpritePhysicsVelocityX(g_player.id)) > 9

    xscroll# = xscroll# - g_speed_factor#
    if xscroll# <= 0 // and g_player_stop# = 1
      xscroll# = 0
      g_player_stop# = 0
    else
      g_player_stop# = 1
    endif
    else
      g_player_stop# = 1
      if xscroll# <= 0
        xscroll# = 0
        g_player_stop# = 0
      endif
    endif
  endif

  // set the screen scroll factor
  if getrawkeystate(39) = 1
    if abs(GetSpritePhysicsVelocityX(g_player.id)) > 9

    xscroll# = xscroll# + g_speed_factor#
    if xscroll# >= g_scroll_repeater // and g_player_stop# = 1
      xscroll# = g_scroll_repeater
      g_player_stop# = 0
    else
      g_player_stop# = 1
    endif
    else
      g_player_stop# = 1
      if xscroll# >= g_scroll_repeater
        xscroll# = g_scroll_repeater
        g_player_stop# = 0
      endif
    endif
  endif
  
  if g_keyboard = 1 then MovePlayer_Keyboard(g_player_stop#) else MovePlayer_JoyStick(g_player_stop#)
  
  CheckItemCollision() // in enemies.agc

  ScrollSprites(xscroll#*0.4)

  setspriteuvoffset(backdropSP3, xscroll#*0.4, 0)
  setspriteuvoffset(backdropSP, xscroll#*0.15, 0)
  setspriteuvoffset(backdropSP2, xscroll#*0.05, 0)
  
  if getrawkeypressed(27) then end

  Sync()
loop
