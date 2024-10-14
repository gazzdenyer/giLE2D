// ***** function CreatePlayer() *****
// basic block - test player

function CreatePlayer()
  g_player.id = createSprite(LoadImage("player5.png"))

  //createSprite(g_player.id)
  SetSpriteSize(g_player.id, 64, -1)
  SetSpritePosition(g_player.id, g_player.xcoord, g_player.ycoord)
  SetSpriteAnimation(g_player.id, 128, 128, 16)
  setSpritePhysicsOn(g_player.id, 2)
  SetSpriteShape(g_player.id, 3)
  setSpritePhysicsCanRotate(g_player.id, 0)

  // set player defaults
  g_player.isdead = 0 // its alive!!!... its alive!!!
  g_player.health = 100
  g_player.points = 0
  g_player.money = 0
  g_player.armour = 50
  g_player.jump_power = 200  // 120
  g_player.move_speed_ground = 70  // 120
  g_player.move_speed_air = 70  // 50
  g_player.rFrame = 5
  g_player.lFrame = 1
  g_player.framecounter = 0

  PlaySprite(g_player.id,15,0,10,10)
endfunction


function PlayerAnim(iDirection, iJump, Platform)
  if iDirection = 2  // right
    if (iJump > 3) and (Platform = 0)
      setSpriteFrame(g_player.id, 5)
    else
      g_player.rFrame = g_player.rFrame + 1
      if g_player.rFrame > 8 then g_player.rFrame = 5
        setSpriteFrame(g_player.id, g_player.rFrame)
        PlaySound(g_player.PlayerStep)
    endif

  elseif iDirection = 1  // left
    if (iJump > 3) and (Platform = 0)
      setSpriteFrame(g_player.id, 1)
    else
      g_player.lFrame = g_player.lFrame + 1
      if g_player.lFrame > 4 then g_player.lFrame = 1
        setSpriteFrame(g_player.id, g_player.lFrame)
        PlaySound(g_player.PlayerStep)
    endif

  elseif iDirection = 0 // standstill
    setSpriteFrame(g_player.id, 10)
  endif
endfunction

function MovePlayer_JoyStick(APlayer_Stop# as float) // example of using the virtual joystick for physics player movement
  // player movement ***************************************
  g_player.framecounter = g_player.framecounter + 1

  jumpVelocity# = abs(GetSpritePhysicsVelocityY(g_player.id))

  jump = GetVirtualButtonPressed(g_Jump_Button) // = 1  // GetRawKeyPressed(32)
  if jump > 0
      if jumpVelocity# < 4
        setSpritePhysicsVelocity(g_player.id,getSpritePhysicsVelocityX(g_player.id),- (jump*g_player.jump_power))
      elseif APlatform = 1 // are we on a platform ?
        setSpritePhysicsVelocity(g_player.id,getSpritePhysicsVelocityX(g_player.id),- (jump*g_player.jump_power))
      endif
    endif

    // move g_player.id
    if jumpVelocity# < 4 // if not jumping move faster 
      setSpritePhysicsVelocity(g_player.id, getvirtualjoystickx(1)*3*g_player.move_speed_ground*APlayer_Stop#, getSpritePhysicsVelocityY(g_player.id))    
    else // slow down lateral motion when in mid-air
      setSpritePhysicsVelocity(g_player.id, getvirtualjoystickx(1)*2*g_player.move_speed_air*APlayer_Stop#, getSpritePhysicsVelocityY(g_player.id))
    endif

    // call PlayerAnim()
    if g_player.framecounter = 5
      if GetVirtualJoystickX(1) > 0 // right
        PlayerAnim(2, trunc(jumpVelocity#), APlatform)
      elseif GetVirtualJoystickX(1) < 0 // left
        PlayerAnim(1, trunc(jumpVelocity#), APlatform)
      else
        PlayerAnim(0, trunc(jumpVelocity#), APlatform) // standstill
      endif
      g_player.framecounter = 0
    endif

    if (GetVirtualButtonPressed(g_Jump_Button) > 0)  and ((jumpVelocity# < 4) or (APlatform = 1))      
	  PlaySound(g_player.PlayerJump, 50)
    endif

  // end player movement ***********************************

endfunction


function MovePlayer_Keyboard(APlayer_Stop# as float) // example of using the keyboard for physics player movement
  // player movement ***************************************
  g_player.framecounter = g_player.framecounter + 1

  jumpVelocity# = abs(GetSpritePhysicsVelocityY(g_player.id))

  jump = GetRawKeyPressed(38)
  if jump > 0
      if jumpVelocity# < 4
        setSpritePhysicsVelocity(g_player.id,getSpritePhysicsVelocityX(g_player.id),- (jump*g_player.jump_power))
      elseif APlatform = 1 // are we on a platform ?
        setSpritePhysicsVelocity(g_player.id,getSpritePhysicsVelocityX(g_player.id),- (jump*g_player.jump_power))
      endif
    endif

    // move g_player.id
    if jumpVelocity# < 4 // if not jumping move faster
      setSpritePhysicsVelocity(g_player.id, (GetRawKeyState(39) - GetRawKeyState(37))*g_player.move_speed_ground*APlayer_Stop#, getSpritePhysicsVelocityY(g_player.id))  
    else // slow down lateral motion when in mid-air
      setSpritePhysicsVelocity(g_player.id, (GetRawKeyState(39) - GetRawKeyState(37))*g_player.move_speed_air*APlayer_Stop#, getSpritePhysicsVelocityY(g_player.id))
    endif

    // call PlayerAnim()
    if g_player.framecounter = 5
      if GetRawKeyState(39) // right
        PlayerAnim(2, trunc(jumpVelocity#), APlatform)
      elseif GetRawKeyState(37) // left
        PlayerAnim(1, trunc(jumpVelocity#), APlatform)
      else
        PlayerAnim(0, trunc(jumpVelocity#), APlatform) // standstill
      endif
      g_player.framecounter = 0
    endif

    if (GetRawKeyPressed(38) > 0) and ((jumpVelocity# < 4) or (APlatform = 1)) then PlaySound(g_player.PlayerJump, 50)

  // end player movement ***********************************
endfunction


// call from functions that increase or reduce player health, armour
// also when player receives powerups, etc.
function UpdatePlayer(ihealth as integer, iarmour as integer, iPoints as integer, imoney as integer)
  g_player.health = g_player.health + ihealth
  g_player.armour = g_player.armour + iarmour
  g_player.points = g_player.points + iPoints
  g_player.money = g_player.money + imoney

  settextstring(g_txtHealth, "Health: " + str(g_player.health))
  settextstring(g_txtPoints, "Points: " + str(g_player.points))
  settextstring(g_txtMoney, "Money: $" + str(g_player.money))

  // set health text color based on players health value
  if g_player.health > 70
    settextcolor(g_txtHealth, 17, 255, 118, 255)
  elseif (g_player.health < 70) and (g_player.health > 51)
    settextcolor(g_txtHealth, 252, 255, 5, 255)
  elseif (g_player.health < 50) and (g_player.health > 31)
    settextcolor(g_txtHealth, 253, 185, 53, 255)
  elseif g_player.health < 31
    settextcolor(g_txtHealth, 255, 0, 0, 255)
  endif

endfunction
