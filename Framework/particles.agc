// TODO: this effect dies over time.... it does not sync properly !!!!!!
function CheckParticles()
  if g_healthparticle.active = 1
    g_healthparticle.currentage = g_healthparticle.currentage + (timer()/1000)

    if (g_healthparticle.currentage - g_healthparticle.timecreated) > g_healthparticle.lifespan
      g_healthparticle.active = 0
      deleteparticles(g_healthparticle.id)
    endif

  endif

endfunction


function HealthParticles(sprite)
  g_healthparticle.id = CreateParticles(GetSpriteX(sprite) + 16, GetSpriteY(sprite) + 16)
  setparticlesimage(g_healthparticle.id, g_healthparticle.image)
  setparticlessize(g_healthparticle.id, 10)
  setparticleslife(g_healthparticle.id, 1.2)
  SetParticlesFrequency(g_healthparticle.id, 100)
  SetParticlesVelocityRange(g_healthparticle.id, 1, 3)
  AddParticlesColorKeyFrame (g_healthparticle.id, 0.0, 255, 255, 0, 255)
  AddParticlesColorKeyFrame (g_healthparticle.id, 0.3, 255, 245, 196, 255)
  AddParticlesColorKeyFrame (g_healthparticle.id, 0.6, 0, 255, 255, 255)
  AddParticlesColorKeyFrame (g_healthparticle.id, 0.9, 0, 0, 0, 0)
  g_healthparticle.active = 1
  g_healthparticle.timecreated = timer()
  g_healthparticle.currentage = timer()
endfunction
