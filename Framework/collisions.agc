function CheckItemCollision()
  for j = 1 to g_nongeo_cnt
  if GetSpriteCollision(g_player.id, g_actual_sprite[j].id) = 1

    // Enemy collision
    if g_actual_sprite[j].IsEnemy = 1
      UpdatePlayer(-1, 0, 0, 0)
    endif

    // collectable collision
    if g_actual_sprite[j].IsCollectable = 1
      if GetSpriteVisible(g_actual_sprite[j].id) = 1 // only if the sprite is visible
        deleteparticles(g_healthparticle.id)  // delete previous
        UpdatePlayer(g_actual_sprite[j].ColHealthValue, 0, g_actual_sprite[j].PointsValue, g_actual_sprite[j].MoneyValue)
        SetSpritePhysicsOff(g_actual_sprite[j].id)
        SetSpriteVisible(g_actual_sprite[j].id, 0)
        //HealthParticles(g_actual_sprite[j].id)
        PlaySound(g_player.HealthSound)
      endif
    endif

    // springboard
    if g_actual_sprite[j].IsSpringboard = 1
      setSpritePhysicsVelocity(g_player.id,  getSpritePhysicsVelocityX(g_player.id),  -(g_player.jump_power + g_actual_sprite[j].SpringForce))
      PlaySprite(g_actual_sprite[j].id, 8, 0)  // play springboard animation once
      PlaySound(g_player.Springboard)  // play springboard sound once
    endif

    // teleport
    if g_actual_sprite[j].IsTeleporter = 1
      SetSpritePosition(g_player.id, g_actual_sprite[j].TeleportX, g_actual_sprite[j].TeleportY)
      PlaySound(g_player.Teleport)  // play teleport sound once
      //HealthParticles(g_player.id)
    endif

    // DEBUG
    //Print("Sprite ID: " + str(g_actual_sprite[j].id))
  endif
  next j
endfunction
