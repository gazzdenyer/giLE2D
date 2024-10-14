// Read the map file and parse it, setting all sprite properties
function loadmap(map as string)
  linecount = 0
  // get line count of file - use to properly dim g_actual_sprite and sprite_str
  mapfile = OpenToRead(map)
  while fileEOF(mapfile) <> 1
    mapstr$ = ReadLine(mapfile)
    linecount = linecount + 1
  endwhile
  CloseFile(mapfile)

  // set the array size of the TSpritemap_Data
  dim g_actual_sprite[linecount] as TSpritemap_Data

  // set map geometry array
  dim g_mapgeo_sprite[linecount] as TSpritemap_Data

  dim sprite_str[linecount] as string
  g_mpcount = 0 // reset moving platform count

  File = OpenToRead(map)

  for j = 0 to linecount
    sprite_str[j] = ReadLine(File)

    if sprite_str[j] = "EOF" then exitfunction

    parseline(sprite_str[j])
  next j

  CloseFile(File)

  // now we can re-dim the g_movingPlatform array since we have the count
  undim g_movingPlatform[]
  dim g_movingPlatform[g_mpcount] as TSpritemap_Data

endfunction


function parseline(sprite as string)
  // allow for comments in the file, if you want to manually edit it... !
  comment$ = left(sprite, 2)
  if comment$ = "//" then return

  g_spritemap_data.Layer = val(GetStringToken(sprite, "|", 1))

  g_spritemap_data.id = val(GetStringToken(sprite, "|", 2))
  g_spritemap_data.FileName = GetStringToken(sprite, "|", 3)
  g_spritemap_data.Xcoord = val(GetStringToken(sprite, "|", 4))
  g_spritemap_data.Ycoord = val(GetStringToken(sprite, "|", 5))
  g_spritemap_data.Xsize = val(GetStringToken(sprite, "|", 6))
  g_spritemap_data.Ysize = val(GetStringToken(sprite, "|", 7))
  g_spritemap_data.Xoffset = val(GetStringToken(sprite, "|", 8))
  g_spritemap_data.Yoffset = val(GetStringToken(sprite, "|", 9))
  g_spritemap_data.physics = val(GetStringToken(sprite, "|", 10))
  g_spritemap_data.shape = val(GetStringToken(sprite, "|", 11))
  g_spritemap_data.IsMapGeometry = val(GetStringToken(sprite, "|", 12))
  g_spritemap_data.IsExplodable = val(GetStringToken(sprite, "|", 13))
  g_spritemap_data.IsCollectable = val(GetStringToken(sprite, "|", 14))
  g_spritemap_data.PointsValue = val(GetStringToken(sprite, "|", 15))
  g_spritemap_data.IsEnemy = val(GetStringToken(sprite, "|", 16))
  g_spritemap_data.IsFriend = val(GetStringToken(sprite, "|", 17))
  g_spritemap_data.HealthValue = val(GetStringToken(sprite, "|", 18))
  g_spritemap_data.IsMovingPlatform = val(GetStringToken(sprite, "|", 19))
  g_spritemap_data.pXmoveFrom = val(GetStringToken(sprite, "|", 20))
  g_spritemap_data.pXmoveTo = val(GetStringToken(sprite, "|", 21))
  g_spritemap_data.pYmoveFrom = val(GetStringToken(sprite, "|", 22))
  g_spritemap_data.pYmoveTo = val(GetStringToken(sprite, "|", 23))
  g_spritemap_data.pVelocity = val(GetStringToken(sprite, "|", 24))
  g_spritemap_data.ColHealthValue = val(GetStringToken(sprite, "|", 25))
  g_spritemap_data.MoneyValue = val(GetStringToken(sprite, "|", 26))
  g_spritemap_data.IsSpringboard = val(GetStringToken(sprite, "|", 27))
  g_spritemap_data.SpringForce = val(GetStringToken(sprite, "|", 28))
  g_spritemap_data.IsTeleporter = val(GetStringToken(sprite, "|", 29))
  g_spritemap_data.TeleportX = val(GetStringToken(sprite, "|", 30))
  g_spritemap_data.TeleportY = val(GetStringToken(sprite, "|", 31))
  g_spritemap_data.PlayerStartMarker = val(GetStringToken(sprite, "|", 32))

  rendersprite()
endfunction


function rendersprite()
  // if the sprite id is 9999, its a background - THIS NEEDS TO CHANGE FOR SCROLLER
  if g_spritemap_data.id = 99999
    //backdrop = CreateSprite(LoadImage(str(g_spritemap_data.Xcoord) + ".png"))
    //FixSpriteToScreen (backdrop, 0)

  else

    // set the players initial position
    if g_spritemap_data.PlayerStartMarker = 1
      g_player.xcoord = g_spritemap_data.Xcoord
      g_player.ycoord = g_spritemap_data.Ycoord


    // render as non map geometry sprites
    elseif (g_spritemap_data.IsMapGeometry = 0) and (g_spritemap_data.IsMovingPlatform = 0)

      // increment the actual non geometry sprite count
      g_nongeo_cnt = g_nongeo_cnt + 1

      // render the sprites
      g_actual_sprite[g_nongeo_cnt].id = createSprite(loadimage(g_spritemap_data.FileName))  // str(g_spritemap_data.id) + ".png"
      //SetSpriteDepth(g_actual_sprite[g_nongeo_cnt].id, g_spritemap_data.Layer)
      setSpriteSize(g_actual_sprite[g_nongeo_cnt].id, g_spritemap_data.Xsize, g_spritemap_data.Ysize)
      setSpriteOffset(g_actual_sprite[g_nongeo_cnt].id, g_spritemap_data.Xoffset, g_spritemap_data.Yoffset)
      setSpritePositionByOffset(g_actual_sprite[g_nongeo_cnt].id, g_spritemap_data.Xcoord, g_spritemap_data.Ycoord)

      g_actual_sprite[g_nongeo_cnt].Xcoord = g_spritemap_data.Xcoord
      g_actual_sprite[g_nongeo_cnt].Ycoord = g_spritemap_data.Ycoord

      // apply the physics attributes
      if g_spritemap_data.physics > 0
        SetSpriteShape(g_actual_sprite[g_nongeo_cnt].id, g_spritemap_data.shape)
        setSpritePhysicsOn(g_actual_sprite[g_nongeo_cnt].id, g_spritemap_data.physics)
      else
        SetSpritePhysicsOff(g_actual_sprite[g_nongeo_cnt].id)
      endif

      // Assign the rest of the properties
      g_actual_sprite[g_nongeo_cnt].IsMapGeometry = g_spritemap_data.IsMapGeometry
      g_actual_sprite[g_nongeo_cnt].IsExplodable = g_spritemap_data.IsExplodable
      g_actual_sprite[g_nongeo_cnt].IsCollectable = g_spritemap_data.IsCollectable
      g_actual_sprite[g_nongeo_cnt].PointsValue = g_spritemap_data.PointsValue
      g_actual_sprite[g_nongeo_cnt].IsEnemy = g_spritemap_data.IsEnemy
      g_actual_sprite[g_nongeo_cnt].IsFriend = g_spritemap_data.IsFriend
      g_actual_sprite[g_nongeo_cnt].HealthValue = g_spritemap_data.HealthValue
      g_actual_sprite[g_nongeo_cnt].ColHealthValue = g_spritemap_data.ColHealthValue
      g_actual_sprite[g_nongeo_cnt].MoneyValue = g_spritemap_data.MoneyValue
      g_actual_sprite[g_nongeo_cnt].IsSpringboard = g_spritemap_data.IsSpringboard
      g_actual_sprite[g_nongeo_cnt].SpringForce = g_spritemap_data.SpringForce
      g_actual_sprite[g_nongeo_cnt].IsTeleporter = g_spritemap_data.IsTeleporter
      g_actual_sprite[g_nongeo_cnt].TeleportX = g_spritemap_data.TeleportX
      g_actual_sprite[g_nongeo_cnt].TeleportY = g_spritemap_data.TeleportY

      if g_actual_sprite[g_nongeo_cnt].IsCollectable = 1
        SetSpriteAnimation(g_actual_sprite[g_nongeo_cnt].id, 32, 32, 8)
        PlaySprite(g_actual_sprite[g_nongeo_cnt].id, 8, 1)
      endif

      if g_actual_sprite[g_nongeo_cnt].IsSpringboard = 1
        SetSpriteAnimation(g_actual_sprite[g_nongeo_cnt].id, 64, 64, 4)
        setSpriteFrame(g_actual_sprite[g_nongeo_cnt].id, 1)
      endif

      if g_actual_sprite[g_nongeo_cnt].IsTeleporter = 1
        SetSpriteAnimation(g_actual_sprite[g_nongeo_cnt].id, 64, 64, 16)
        setSpriteFrame(g_actual_sprite[g_nongeo_cnt].id, 1)
        PlaySprite(g_actual_sprite[g_nongeo_cnt].id, 15, 1)
      endif

    elseif (g_spritemap_data.IsMapGeometry = 1) and (g_spritemap_data.IsMovingPlatform = 0)

      // increment g_mapgeocnt
      g_mapgeocnt = g_mapgeocnt + 1

      // render as map geometry
      // render the sprites
      g_mapgeo_sprite[g_mapgeocnt].id = createSprite(loadimage(g_spritemap_data.FileName))  // str(g_spritemap_data.id) + ".png"
      //SetSpriteDepth(spr, g_spritemap_data.Layer)
      setSpriteSize(g_mapgeo_sprite[g_mapgeocnt].id, g_spritemap_data.Xsize, g_spritemap_data.Ysize)
      setSpriteOffset(g_mapgeo_sprite[g_mapgeocnt].id, g_spritemap_data.Xoffset, g_spritemap_data.Yoffset)
      setSpritePositionByOffset(g_mapgeo_sprite[g_mapgeocnt].id, g_spritemap_data.Xcoord, g_spritemap_data.Ycoord)

      g_mapgeo_sprite[g_mapgeocnt].Xcoord = g_spritemap_data.Xcoord
      g_mapgeo_sprite[g_mapgeocnt].Ycoord = g_spritemap_data.Ycoord


      // apply the physics attributes
      if g_spritemap_data.physics > 0
        SetSpriteShape(g_mapgeo_sprite[g_mapgeocnt].id, g_spritemap_data.shape)
        setSpritePhysicsOn(g_mapgeo_sprite[g_mapgeocnt].id, g_spritemap_data.physics)
      else
        SetSpritePhysicsOff(g_mapgeo_sprite[g_mapgeocnt].id)
      endif

    elseif (g_spritemap_data.IsMapGeometry = 0) and (g_spritemap_data.IsMovingPlatform = 1)


      // render as a moving platform

      g_movingPlatform[g_mpcount].id = createSprite(LoadImage(g_spritemap_data.FileName))  // str(g_spritemap_data.id) + ".png"
      //SetSpriteDepth(g_movingPlatform[g_mpcount].id, g_spritemap_data.Layer)
      direction = 1
      setSpriteSize(g_movingPlatform[g_mpcount].id, g_spritemap_data.Xsize, g_spritemap_data.Ysize)
      setSpriteOffset(g_movingPlatform[g_mpcount].id, g_spritemap_data.Xoffset, g_spritemap_data.Yoffset)
      setSpritePositionByOffset(g_movingPlatform[g_mpcount].id, g_spritemap_data.Xcoord, g_spritemap_data.Ycoord)

      g_movingPlatform[g_mpcount].Xcoord = g_spritemap_data.Xcoord
      g_movingPlatform[g_mpcount].Ycoord = g_spritemap_data.Ycoord

      // apply the physics attributes
      if g_spritemap_data.physics > 0
        SetSpriteShape(g_movingPlatform[g_mpcount].id, g_spritemap_data.shape)
        setSpritePhysicsOn(g_movingPlatform[g_mpcount].id, g_spritemap_data.physics)
      else
        SetSpritePhysicsOff(g_movingPlatform[g_mpcount].id)
      endif

      g_movingPlatform[g_mpcount].IsMovingPlatform = g_spritemap_data.IsMovingPlatform
      g_movingPlatform[g_mpcount].pXmoveFrom = g_spritemap_data.pXmoveFrom
      g_movingPlatform[g_mpcount].pXmoveTo = g_spritemap_data.pXmoveTo
      g_movingPlatform[g_mpcount].pYmoveFrom = g_spritemap_data.pYmoveFrom
      g_movingPlatform[g_mpcount].pYmoveTo = g_spritemap_data.pYmoveTo
      g_movingPlatform[g_mpcount].pVelocity = g_spritemap_data.pVelocity
      g_movingPlatform[g_mpcount].mp_direction = g_spritemap_data.pVelocity

      // keep count of the platforms for the array
      g_mpcount = g_mpcount + 1

    endif

    //SetSpriteVisible(spr, 0)
  endif
endfunction

function MovePlatforms()

  for cnt = 0 to g_mpcount - 1

    setSpritePhysicsVelocity(g_movingPlatform[cnt].id, 0, g_movingPlatform[cnt].mp_direction)
    if getSpriteYbyOffset(g_movingPlatform[cnt].id) > g_movingPlatform[cnt].pYmoveTo
      g_movingPlatform[cnt].mp_direction = -g_movingPlatform[cnt].pVelocity
    else
      if getSpriteYbyOffset(g_movingPlatform[cnt].id) < g_movingPlatform[cnt].pYmoveFrom
        g_movingPlatform[cnt].mp_direction = g_movingPlatform[cnt].pVelocity
      endif
    endif

  next cnt

endfunction


function LoadNextMap()
  // ***************************************************************************
  // TODO: First we will need to DESTROY ALL STUFF from the previous map !!!!!!
  // ***************************************************************************

  //if g_soundtrack > 0 then DeleteMusic(g_soundtrack)
  //DeleteImage(g_intro_img)
  //DeleteAllSprites()
  settextvisible(g_txtHealth, 0)
  settextvisible(g_txtPoints, 0)
  settextvisible(g_txtMoney, 0)

  // increase the map file name
  g_curr_map_counter = g_curr_map_counter + 1

  // reset the number of non map geometry sprites
  g_nongeo_cnt = 0

  //message("load map")

  // Now, load the map
  loadmap("maps/map" + str(g_curr_map_counter) + ".txt") //map1, map2, etc need validator for mapname in delphi mapper project !!!

  // create the player
  CreatePlayer()

  // create a kinematic platform
  //kinematic = CreateMovingPlatform() // should turn this into a type, with vx, vy and id properties

  // Play next map soundtrack

  if g_soundtrack > 0 then DeleteMusic(g_soundtrack)
  g_soundtrack = LoadMusic ("track" + str(g_curr_map_counter) + ".ogg")
  PlayMusic (g_soundtrack, 1)

  // set all text objects visible

  settextvisible(g_txtHealth, 1)
  settextvisible(g_txtPoints, 1)
  settextvisible(g_txtMoney, 1)

  // load game glyphs

  LoadGlyphs()

  Sync()

  resettimer()

  // create controls

  //g_keyboard = CreateControls()

  // set game mode to play

  //g_gamemode = GAME_MODE_PLAY

  // resettimer()

  // create and show the pause button
  //AddVirtualButton(4, 200, 360, 40)
  //SetVirtualButtonText(3, "PAUSE")
  //SetVirtualButtonVisible(3, 1)
endfunction



function ScrollSprites(AScrollVal# as float)
  // formula: X = spriteX - (screenX * foreground scroll factor)

  for cnt = 1 to g_mapgeocnt
    SetSpritePositionByOffset(g_mapgeo_sprite[cnt].id,  round(g_mapgeo_sprite[cnt].Xcoord - (1136 * (AScrollVal#))), g_mapgeo_sprite[cnt].Ycoord)
  next cnt

  for cnt1 = 1 to g_nongeo_cnt
    setSpritePositionByOffset(g_actual_sprite[cnt1].id, round(g_actual_sprite[cnt1].Xcoord - (1136 * (AScrollVal#))), g_actual_sprite[cnt1].Ycoord)
  next cnt1

  for cnt2 = 1 to g_mpcount
    setSpritePositionByOffset(g_movingPlatform[cnt2].id, round(g_movingPlatform[cnt2].Xcoord - (1136 * (AScrollVal#))), g_movingPlatform[cnt2].Ycoord)
  next cnt2

endfunction




// WAITING TO BE ABLE TO PASS ARRAYS TO FUNCTIONS!

//function AssignProperties(sprite as TSpritemap_Data, datavalue as TSpritemap_Data)
//  sprite.id = datavalue.id
//  sprite.Xcoord = datavalue.Xcoord
//  sprite.Ycoord = datavalue.Ycoord
//  sprite.Xsize = datavalue.Xsize
//  sprite.Ysize = datavalue.Ysize
//  sprite.Xoffset = datavalue.Xoffset
//  sprite.Yoffset = datavalue.Yoffset
//  sprite.physics = datavalue.physics
//  sprite.shape = datavalue.shape
//  sprite.IsMapGeometry = datavalue.IsMapGeometry
//  sprite.IsExplodable = datavalue.IsExplodable
//  sprite.IsCollectable = datavalue.IsCollectable
//  sprite.PointsValue = datavalue.PointsValue
//  sprite.IsEnemy = datavalue.IsEnemy
//  sprite.IsFriend = datavalue.IsFriend
//  sprite.HealthValue = datavalue.HealthValue
//endfunction


// SOME TEST SHIT
