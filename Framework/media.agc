function LoadSounds()
  g_player.PlayerJump = LoadSound("jump1.wav")
  g_player.PlayerStep = LoadSound("step1.wav")
  g_player.PlayerCrump = LoadSound("crump1.wav")
  g_player.HealthSound = LoadSound("collecthealth.wav")
  g_player.Springboard = LoadSound("spring1.wav")
  g_player.Teleport = LoadSound("teleport1.wav")
endfunction


function LoadTextObjects()
  // load font
  customimg = LoadImage("custom.png")
  // health text
  g_txtHealth = CreateText("Health: 100")
  SetTextFontImage(g_txtHealth, customimg)
  settextsize(g_txtHealth, 24)
  settextposition(g_txtHealth, 26, 0)
  settextalignment(g_txtHealth, 0)
  settextcolor(g_txtHealth, 17, 255, 118, 255)
  settextvisible(g_txtHealth, 0)

  g_txtPoints = CreateText("Points: 0")
  SetTextFontImage(g_txtPoints, customimg)
  settextsize(g_txtPoints, 24)
  settextposition(g_txtPoints, 220, 0)
  settextalignment(g_txtPoints, 0)
  settextcolor(g_txtPoints, 255, 96, 48, 255)
  settextvisible(g_txtPoints, 0)

  g_txtMoney = CreateText("Money: $Nada!")
  SetTextFontImage(g_txtMoney, customimg)
  settextsize(g_txtMoney, 24)
  settextposition(g_txtMoney, 920, 0)
  settextalignment(g_txtMoney, 0)
  settextcolor(g_txtMoney, 192, 255, 192, 255)
  settextvisible(g_txtMoney, 0)

endfunction


function LoadGlyphs()
  g_healthglyph = CreateSprite(LoadImage("279.png"))
  setspritesize(g_healthglyph, 24, 24)
  setspriteposition(g_healthglyph, 0, 0)
  setspritevisible(g_healthglyph, 1)

  g_pointsglyph  = CreateSprite(LoadImage("278.png"))
  setspritesize(g_pointsglyph, 24, 24)
  setspriteposition(g_pointsglyph, 194, 0)
  setspritevisible(g_pointsglyph, 1)

  g_moneyglyph  = CreateSprite(LoadImage("277.png"))
  setspritesize(g_moneyglyph, 24, 24)
  setspriteposition(g_moneyglyph, 894, 0)
  setspritevisible(g_moneyglyph, 1)
endfunction


function LoadParticles()
  g_healthparticle.image = LoadImage("particle.png")
  g_healthparticle.lifespan = 1
  g_healthparticle.active = 0
endfunction
