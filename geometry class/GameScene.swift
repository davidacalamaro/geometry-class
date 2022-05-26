//
//  GameScene.swift
//  geometry class
//
//  Created by nope on 5/6/22.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var gspeed: CGFloat = 1
    var bg = SKSpriteNode()
    var ground = SKSpriteNode()
    var cube = SKSpriteNode()
    var spike = SKSpriteNode()
    
    var dead = false
    
    var tg = false
    var touching = false
    var firstTouch = false
    var moveBG = false
    var firstRun = 0
    let doJump = SKAction.init(named: "jump")
    
    override func didMove(to view: SKView)
    {
       // let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        //borderBody.friction = 0
        //self.physicsBody = borderBody
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        
        spike = self.childNode(withName: "spike") as! SKSpriteNode
        cube = self.childNode(withName: "cube") as! SKSpriteNode
        cube.physicsBody?.allowsRotation = true
        cube.physicsBody?.mass = 0.3
        cube.physicsBody?.restitution = 0.0
        
        
        
        createBg()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
    {
        self.moveBG = true
    }
    
    }
    
    
    
    func jump()
    {
        cube.run(doJump!, withKey: "jump")
    }

    

    
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2) || (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1)
        {
          /*
            particle(pos: contact.contactPoint)
            cube.removeFromParent()
            dead = true
            print("dead")
           */
        }
        
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 3) || (contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1)
        {
            tg = true
            // cube.removeAction(forKey: "rotate")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touching = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        touching = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        ground.position.y = -155
        //print(cube.physicsBody?.allContactedBodies() as Any)
    
        if moveBG == true
        {
            cube.position = CGPoint(x: -94.9, y: cube.position.y)
            //print(cube.position.y)
            cube.physicsBody?.velocity.dx = 0.0
            spike.position.x -= 6.66666666
            cube.physicsBody?.isDynamic = false
        }

        if touching == true && tg == true
        {
            jump()
            print("should jump")
        }
        
        else
        {
            print("touching \(touching)")
                print("touch ground \(tg)")
        }
       
        
     /*
        if Int(cube.position.y) <= -97
        {tg = true} //touch ground
        
        else
        {tg = false}
       */
//
        
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
