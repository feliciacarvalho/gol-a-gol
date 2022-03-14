--------------------
largura = love.graphics.getWidth()

altura = love.graphics.getHeight()
----aqui comeco a inicilizar a parte do placar------
local contney=0
local contmessi=0

placar={ney=0,messi=0,gol=false} 

local vitoria_messi=false
local vitoria_ney=false
-------------fim iniciarlizacao placar------------
function love.load()
  --------------------------carrega musica-----------------------
  inicial=love.audio.newSource("som/check.mp3","stream")
  inicial : setLooping(true)
  love.audio.play(inicial)
  --------------------som gol------------------

  gol=love.audio.newSource("som/golaço.mp3","stream")
  gol : setLooping(false)
  ------------------som campeão----------------
  neyganhador=love.audio.newSource("som/neymito.mp3","stream")
  neyganhador:setLooping(true)
  messiganhador=love.audio.newSource("som/barcelona.mp3","stream")
  messiganhador:setLooping(true)
--------inicializando o mundo---------------
  love.physics.setMeter(64)
   mundo = love.physics.newWorld(0,9.81 * 64,false)


--Variaveis do personagem
campo = {  --campo
x = 0,
y = 1,
xvel = 0,
yvel = 0,

}  
background = love.graphics.newImage('campov5.png')  


-----------------------fisica da bola----------------------
   ball={}
    bola=love.graphics.newImage("bola1.png") ----------------carrega bola==------------
    ball.w=bola:getWidth() ------detecta a largura-----
    ball.h=bola:getHeight()-------detecta a altura-------
    ball.x=280
    ball.y=200
    ball.r=0
    --speedball=100
    ball.b = love.physics.newBody(mundo, ball.x+105 , ball.y+25 , "dynamic")  --  x,y posicao, e dinamico para acertar outros objetos
      ball.b:setMass(0.8)                                        -- peso
      ball.s = love.physics.newCircleShape(20)                  --raio
      ball.f = love.physics.newFixture(ball.b, ball.s)          -- conecta os corpos
      ball.f:setRestitution(1)     ---------- quique da bola
        ------------------------------------------------------------------------------   
   -----------------------------------------------------------------------------------------------
---------------------------------------------fisica de messi-------------------------
 messi1={}
    messi=love.graphics.newImage("messi24.png") ----------------carrega bola==------------
   messi1.w=messi:getWidth() ------detecta a largura-----
    messi1.h=messi:getHeight()-------detecta a altura-------
    messi1.x=100 
    messi1.y=350
    messi1.r=0  

    messi1.b = love.physics.newBody(mundo, messi1.x+105 , messi1.y+25 , "dynamic")  --  x,y posicao, e dinamico para acertar outros objetos
      messi1.b:setMass(1)                                        -- peso
      messi1.s = love.physics.newCircleShape(23)                  --raio
      messi1.f = love.physics.newFixture(messi1.b, messi1.s)          -- conecta os corpos

     ----------------------------------delimita o chão--------------------------------------------   
     messi1.chao = {}
     messi1.chao.body = love.physics.newBody(mundo, 200,700)
     messi1.chao.shape = love.physics.newRectangleShape(5000,400)
     messi1.chao.fixture = love.physics.newFixture(messi1.chao.body,messi1.chao.shape)


--------------------------------------------------------------------------------------





---------------------------------------------------------------------------------------
  ney={}
    ney2=love.graphics.newImage("ney24.png") ----------------carrega imagem---------------
    ney.w=ney2:getWidth() ------detecta a largura-----
    ney.h=ney2:getHeight()-------detecta a altura-------
    ney.x=450
    ney.y=350
    ney.r=0  

    ney.b = love.physics.newBody(mundo, ney.x+105 , ney.y+25 , "dynamic")  --  x,y posicao, e dinamico para acertar outros objetos
      ney.b:setMass(1)                                        -- peso
      ney.s = love.physics.newCircleShape(23)                  --raio da cabeça
      ney.f = love.physics.newFixture(ney.b, ney.s)          -- conecta os corpos
    
     


-----------------------------limite das bordas-------
    bordascima={}
        bordascima.b=love.physics.newBody(mundo, 500,12, "static") 
        bordascima.s = love.physics.newRectangleShape(1000,0)
        bordascima.f = love.physics.newFixture(bordascima.b, bordascima.s)
        bordascima.f:setUserData("bordascima")

    
   ---------------------------------esquerda parte de baixo-------
    leftbaixo={}
        leftbaixo.b = love.physics.newBody(mundo, 1 ,542, "static") 
        leftbaixo.s = love.physics.newRectangleShape(2,1000)
        leftbaixo.f = love.physics.newFixture(leftbaixo.b, leftbaixo.s)
        leftbaixo.f:setUserData("leftbaixo")
   ---------------------- direita parte de cima-------------------
    rightcima={} 
        rightcima.b = love.physics.newBody(mundo, 986 , 55, "static") 
        rightcima.s = love.physics.newRectangleShape(0,97)
        rightcima.f = love.physics.newFixture(rightcima.b, rightcima.s)
        rightcima.f:setUserData("rightcima")
   -------------------------direita parte de baixo--------------------------
    rightbaixo={}
        rightbaixo.b =  love.physics.newBody(mundo, 986 ,545, "static") 
        rightbaixo.s = love.physics.newRectangleShape(450,1500)
        rightbaixo.f = love.physics.newFixture(rightbaixo.b, rightbaixo.s)
        rightbaixo.f:setUserData("rightbaixo")

-------------------------------variaveis das imagens de vitoria
  neymarimg=love.graphics.newImage("GG.png")
  messiimg=love.graphics.newImage("bernaleo.png")

end


   
  

function love.update(dt)
--fisica aplicada
mundo:update(dt)

--------------------- aumentar pontuação quando a bola passar pelo gol do messi --------------------------
  if ball.b:getX() <= 30 and ball.b:getY()>=390 and ball.b:getY()<=542 then
      placar.ney = placar.ney + 1
        resetaBola()  ----- 
  end
-----------------------aumentar pontuação quando a bola passar pelo gol do neymar------------------------
  if ball.b:getX() >= 720 and ball.b:getY()>=390 and ball.b:getY()<=542 then
      placar.messi = placar.messi + 1
       resetaBola()
  end

function resetaBola()
  ball.b:setX(400)--coloca a bola na metade da largura e nessa distancia
  ball.b:setY(400)--coloca a bola na metade da altura da tela
  ball.b:setLinearVelocity(0,0)--zera o momento da bola
  gol:play()--------------------som do gol
  
  ney.b:setX(500)--reseta o boneco no eixo x
  ney.b:setY(350)--resata o boneco no eixo y
  ney.b:setLinearVelocity(0,0)--zera o momento do boneco

   messi1.b:setX(200)--reseta o boneco no eixo x
   messi1.b:setY(350)--resata o boneco no eixo y
   messi1.b:setLinearVelocity(0,0)--zera o momento do boneco

end
----------------definindo o numero de gols necesários para a vitoria------------
   if placar.messi==3 then
     vitoria_messi=true
     messiganhador:play()
     love.audio.pause(inicial)
   end
   if placar.ney==3 then
    vitoria_ney=true
    neyganhador:play()
    love.audio.pause(inicial)
   end




-----------------------------movimentação do menino ney---------------
 if love.keyboard.isDown("left") then

       ney.b:applyForce(-200 , 0)
       
 end
 if love.keyboard.isDown("right") then

       ney.b:applyForce(200 , 0)

 end


----------------------------movimentação do leo messi---------------
 if love.keyboard.isDown("a") then

       messi1.b:applyForce(-200 , 0)     
 end
 if love.keyboard.isDown("d") then

       messi1.b:applyForce(200 , 0)
 end




    
   ------------------------botão do pulo--------------------
  function love.keypressed ( key)
     if key ==  "w"  then 
      messi1.b: applyLinearImpulse ( 0,  -120 )
     end 

     if key ==  "up"  then 
      ney.b: applyLinearImpulse ( 0, -120 )
     end 
  end
end

function love.draw()


   ------desneha borda de cima=---------------
   
    love.graphics.polygon("fill", bordascima.b:getWorldPoints(bordascima.s:getPoints()))




------------------------desenha o background-------------------------
    love.graphics.draw(background,campo.x,campo.y,0,0.78,1,iw1, ih1)
   
   ----------------------desenha a bola----------------------------- 
    love.graphics.circle("fill", ball.b:getX()+30,ball.b:getY()+30, ball.s:getRadius())--]]
    love.graphics.draw(bola, ball.b:getX() , ball.b:getY(), 0,1,1)
  


------------------------desenha o menino  neymar----------------------
    love.graphics.circle("fill",ney.b:getX()+35,ney.b:getY()+30,ney.s:getRadius())
    love.graphics.draw(ney2,ney.b:getX() , ney.b:getY() , 0,0.5,0.5)
    


 --------------------------desenha leo messi-------------------------   
    love.graphics.circle("fill",messi1.b:getX()+40,messi1.b:getY()+25,messi1.s:getRadius())
    love.graphics.draw(messi,messi1.b:getX() , messi1.b:getY() , 0,0.5,0.5)
    
    
----------------------------------AQUI COMECO A DESENHAR gols NEY-------------------
  --if startcenario==true then
    
    love.graphics.setColor(0,0,0)
    love.graphics.print(placar.ney,404,80.5,0,2,2.5)
    love.graphics.setColor(255,255,255)
  --end
  ---------------------------------------------------------------------------
------------------------------AQUI DESENHO DO MESSI---------------------
  --if startcenario==true then
    
    love.graphics.setColor(0,0,0)
    love.graphics.print(placar.messi,382,80.5,0,2,2.5)
    love.graphics.setColor(255,255,255)
 -- end
  if vitoria_messi==true  then
    love.graphics.draw(messiimg,-200,0,0,1.8)
  elseif vitoria_ney==true  then
    love.graphics.draw(neymarimg,-200,0,0,0.7)
  end
end