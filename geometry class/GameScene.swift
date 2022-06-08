//
//  GameScene.swift
//  geometry class
//
//  Created by nope on 5/6/22.
//
//https://www.desmos.com/calculator/kwqhsyjgph
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var gspeed: CGFloat = 1
    var bg = SKSpriteNode()
    var ground = SKSpriteNode()
    var cube = SKSpriteNode()
    var spike = SKSpriteNode()
    var level = SKSpriteNode()
    var orb = SKSpriteNode()
    var Ccamera = SKCameraNode()
    var camUpBound = SKSpriteNode()
    var camDownBound = SKSpriteNode()
    var dead = false
    
    var followCamY = 0.0
    var camPosY = 0.0
    var camPosX = 0.0
    var jumping = false
    var tg = false
    var touching = false
    var firstTouch = false
    var moveBG = false
    var firstRun = 0
    let doJump = SKAction.init(named: "jump")
    let rotate = SKAction.init(named: "rotate")
    var camUp = SKAction.init(named: "camera up")
    var camDown = SKAction.init(named: "camera down")
    var preCamUp = 0.0
    
    let arr1 = [83, 84, 85, 86, 87, 88, 89, 90, 91, 92]
    let arr2 = [ -83, -84, -85, -86, -87, -88, -89, -90, -91, -92, -93, -94, -95, -96]
    let arr3 = [173, 174, 175, 176, 177, 178, 179, 180, 181, 182]
    let arr4 = [-173, -174, -175, -176, -177, -178, -179, -180, -181, -182]
    let arr5 = [-7, -6, -5, -4, -3, -2, -1, 0, 1, 2]
    var time = 0
    override func didMove(to view: SKView)
    {
       // let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        //borderBody.friction = 0
        //self.physicsBody = borderBody
        physicsWorld.gravity = CGVector(dx: 0, dy: -17.7820551)
        physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        //doJump.setValue(Any?.self, forKey: "jump")
        //rotate.setValue(Any?.self, forKey: "rotate")
        
        Ccamera = (self.childNode(withName: "camera") as! SKCameraNode)
        camUpBound = self.childNode(withName: "camUpBound") as! SKSpriteNode
        camDownBound = self.childNode(withName: "camDownBound") as! SKSpriteNode
        level = self.childNode(withName: "test") as! SKSpriteNode
        orb = level.childNode(withName: "orb") as! SKSpriteNode
        spike = level.childNode(withName: "spike") as! SKSpriteNode
        cube = self.childNode(withName: "cube") as! SKSpriteNode
        cube.physicsBody?.allowsRotation = true
        cube.physicsBody?.mass = 0.0
        cube.physicsBody?.restitution = 0.0
        cube.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        cube.physicsBody?.angularDamping = -0.1
        
        createBg()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
    {
        self.moveBG = true
    }
    
    }
    
    func jump()
    {

        if touching == true
        {
        if jumping == false
            {
          //  cube.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 235), at: CGPoint(x: -50, y: -50))
        //cube.physicsBody?.applyAngularImpulse(500)
            cube.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 750.302043))
            tg = false
           time = 0
        jumping = true
            
            }
        }
        
    }

    

    
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2) || (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1)
        {
          
            //particle(pos: contact.contactPoint)
            //cube.removeFromParent()
           // dead = true
            print("dead")
           
        }
        
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3) || (contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1)
        {
            tg = true
            
            
                jumping = false
            cube.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
            jump()
            //preCamUp = cube.position.y
        
        }
        
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touching = true
        jump()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touching = false
    }
    
    override func update(_ currentTime: TimeInterval) {
      /*
        print("orb frame \(orb.frame)")
        print("orb pos \(orb.position)")
        
        print("cube position \(cube.position)")
        
        if orb.frame.contains(cube.position)
        {
            jump()
            print("orb hit")
        }
        */
       // print("camera \(Ccamera.position)")
//        camPosY = Ccamera.position.y
//        camPosX = Ccamera.position.x
        
      /*
        if Int(camUpBound.position.y) == Int(cube.position.y) || Int(camUpBound.position.y) == Int(cube.position.y-1) || Int(camUpBound.position.y) == Int(cube.position.y+1)
        {
            Ccamera.position = CGPoint(x: -1.009429931640625, y: camPosY + cube.position.y)
            print("cam")
            camUpBound.position.y = Ccamera.position.y + cube.position.y
        }
        */
        //doesnt work, fix this
        
        // change up bound to 87.5
       // print("cam up \(camUpBound.position.y)")
        //print("cube \(cube.position.y)")
        //print(Ccamera.position)
        if cube.position.y > camUpBound.position.y
        {
            //Ccamera.position = CGPoint(x: -1.009429931640625, y: camPosY + cube.position.y)
          
            Ccamera.position.x = -1.009429931640625
          //  Ccamera.run(camUp!, withKey: "camUp")
           // camUpBound.run(camUp!, withKey: "camUpBound")
            //camDownBound.run(camUp!, withKey: "camDownBound")
            Ccamera.position.y += 1
            
            
            print("cam")
            //camUpBound.position.y = Ccamera.position.y + cube.position.y
            
            if tg == true
            {camUpBound.position.y = cube.position.y + 50//192.75300
                camDownBound.position.y = cube.position.y - 3
            }
        
            
        }
        //
        
        if tg == false && cube.position.y < camDownBound.position.y
        {
//            Ccamera.position.x = -1.009429931640625
//            Ccamera.run(camDown!, withKey: "camDown")
//            camUpBound.run(camDown!, withKey: "camDownBound")
//            camDownBound.run(camDown!, withKey: "camDownBound")
            Ccamera.position.x = -1.009429931640625
          //  Ccamera.run(camUp!, withKey: "camUp")
           // camUpBound.run(camUp!, withKey: "camUpBound")
            //camDownBound.run(camUp!, withKey: "camDownBound")
            Ccamera.position.y -= 5
            
            
            print("cam2")
            //camUpBound.position.y = Ccamera.position.y + cube.position.y
            
            
        }
        
        
        
        
        
        
        
        ground.position.y = -155

        if jumping == true && cube.hasActions() == false
        {
            cube.run(rotate!, withKey: "rotate")
        }
        
        let cr = Int(cube.zRotation * (180 / .pi))
    
        
        
    if tg == true
    {
   // print(cr)
        if arr1.contains(cr)
        {
            cube.removeAction(forKey: "rotate")
            cube.zRotation = .pi/2
        }
    
        else if arr2.contains(cr)
        {
            cube.removeAction(forKey: "rotate")
            cube.zRotation = -.pi/2
        }
        
        else if arr3.contains(cr)
        {
            cube.removeAction(forKey: "rotate")
            cube.zRotation = .pi
        }
        
        else if arr4.contains(cr)
        {
            cube.removeAction(forKey: "rotate")
            cube.zRotation = -.pi
        }
    
        else if arr5.contains(cr)
        {
            cube.removeAction(forKey: "rotate")
            cube.zRotation = 0
        }
    }
        
        if moveBG == true
        {
            
            cube.position = CGPoint(x: -94.9, y: cube.position.y)
            cube.physicsBody?.velocity.dx = 0.0
            level.position.x -= 6.66666666
          //  cube.physicsBody?.isDynamic = false
//            Ccamera.position = CGPoint(x: camPosX + cube.position.x, y: camPosY + cube.position.y)
           if tg == true
            {
           
               
               
               //Ccamera.position.y = cube.position.y + 98
               
             // Ccamera.run(camUp!)
               //create action to move ccamera up 98
            
           
           }
        
        }
       

     
        
        if moveBG == true
        {
        if gspeed == 1
        {
            moveBg(speed: 2, name: "bg")
            moveBg(speed: 6.666666666, name: "ground")
            
        }

    if dead == true
    {
        moveBG = false
        moveBg(speed: 0, name: "bg")
        moveBg(speed: 0, name: "ground")
        spike.position.x = spike.position.x
    }
            
            
            


        }
        
        
        
    }
    
    
    
    
    
    
    func createBg()
    {
        for i in 0...3
        {
            let bg = SKSpriteNode(imageNamed: "bgt")
            bg.name = "bg"
            bg.size = CGSize(width: 800, height: 800)
            bg.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            bg.position = CGPoint(x: CGFloat(i) * bg.size.width, y: 212.5 /*-(self.frame.size.height / 2)*/)
            bg.zPosition = -1
            bg.physicsBody?.categoryBitMask = 999
            self.addChild(bg)

            let ground = SKSpriteNode(imageNamed: "ground")
            ground.name = "ground"
            ground.size = CGSize(width: 800, height: 65)
            ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            ground.position = CGPoint(x: CGFloat(i) * bg.size.width, y: -155 /*-(self.frame.size.height / 2)*/)
            ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 800, height: 65))
            ground.physicsBody?.isDynamic = false
            ground.physicsBody?.allowsRotation = false
            ground.physicsBody?.affectedByGravity = false
            ground.physicsBody?.pinned = false
//            ground.physicsBody?.collisionBitMask = 1
            ground.physicsBody?.categoryBitMask = 3
            ground.zPosition = 2
            ground.physicsBody?.restitution = 0.0
            self.addChild(ground)
        
        }
        
    }
    
    func particle(pos: CGPoint)
    {
        if let emitterNode = SKEmitterNode(fileNamed: "death.sks")
        {
            emitterNode.position = pos
            emitterNode.targetNode = self
            emitterNode.zPosition = 3
            addChild(emitterNode)
        }
    }
    
    
    
    
    
    
    
    
    func moveBg(speed: Double, name: String)
    {
        self.enumerateChildNodes(withName: name, using:
        ({
        (node, error) in
            
            node.position.x -= speed
         
            
            if node.position.x < -((self.scene?.size.width)!)-75
            {
//                node.position.x += (self.scene?.size.width)! * 3.8
                node.position.x = 853.6
            }
        }))
    }
}


///.             camera does stuff here
///|
///|
///|
///|
///|
///|
///|
///|
///|
///-         camera does stuff here
 

//camera moves up when hits point and stops moving when hits point again

