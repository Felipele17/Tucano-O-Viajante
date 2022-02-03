//
//  GameElements.swift
//  TucanoJogo2
//
//  Created by Felipe Leite on 01/02/22.
//

import SpriteKit

struct CollisionBitMask {
    static let birdCategory:UInt32 = 0x1 << 0
    static let obstacleCategory:UInt32 = 0x1 << 1
    static let foodCategory:UInt32 = 0x1 << 2
}

extension GameScene {
    
    func createZeca() -> SKSpriteNode {
        let zeca = SKSpriteNode(imageNamed: "Tucano")
        zeca.position = CGPoint(x: 195, y: 120)
        
        zeca.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        zeca.physicsBody?.linearDamping = 1.1
        zeca.physicsBody?.restitution = 0
        zeca.physicsBody?.angularVelocity = 0
        
        zeca.physicsBody?.categoryBitMask = CollisionBitMask.birdCategory
        zeca.physicsBody?.collisionBitMask = CollisionBitMask.obstacleCategory
        zeca.physicsBody?.contactTestBitMask = CollisionBitMask.obstacleCategory | CollisionBitMask.foodCategory
        
        zeca.physicsBody?.affectedByGravity = false
        zeca.physicsBody?.isDynamic = true
        zeca.physicsBody?.allowsRotation = false
        
        return zeca
    }
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "Restart")
        restartBtn.size = CGSize(width: 70, height: 70)
        restartBtn.position = CGPoint(x: 60, y: 780)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    func createPauseBtn() {
        pauseBtn = SKSpriteNode(imageNamed: "Pause")
        pauseBtn.size = CGSize(width:70, height:70)
        pauseBtn.position = CGPoint(x: 330, y: 780)
        pauseBtn.zPosition = 6
        self.addChild(pauseBtn)
    }
    func createScoreLabel() -> SKLabelNode {
        let scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: 185, y: 720)
        scoreLbl.text = "Pontuação: \(score)"
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 20
        scoreLbl.fontName = "Chalkduster"
        return scoreLbl
    }
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x: 195, y: 422)
        taptoplayLbl.text = "Toque para Jogar"
        taptoplayLbl.fontColor = UIColor(red: 196/255, green: 230/255, blue: 25/255, alpha: 1.0)
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        taptoplayLbl.fontName = "Chalkduster"
        return taptoplayLbl
    }
    func createObstacles() -> SKNode  {
        let aguiaNode = SKSpriteNode(imageNamed: "Águia")
        aguiaNode.size = CGSize(width: 95, height: 120)
        aguiaNode.physicsBody?.categoryBitMask = CollisionBitMask.obstacleCategory
        aguiaNode.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        aguiaNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        aguiaNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        aguiaNode.physicsBody?.linearDamping = 1.1
        aguiaNode.physicsBody?.restitution = 0
        aguiaNode.physicsBody?.angularVelocity = 0
        
        aguiaNode.physicsBody?.allowsRotation = false
        aguiaNode.physicsBody?.affectedByGravity = true
        aguiaNode.physicsBody?.isDynamic = true
        
        let cobraNode = SKSpriteNode(imageNamed: "Cobra")
        cobraNode.size = CGSize(width: 95, height: 120)
        cobraNode.physicsBody?.categoryBitMask = CollisionBitMask.obstacleCategory
        cobraNode.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        cobraNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        cobraNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        cobraNode.physicsBody?.linearDamping = 1.1
        cobraNode.physicsBody?.restitution = 0
        cobraNode.physicsBody?.angularVelocity = 0
        
        cobraNode.physicsBody?.allowsRotation = false
        cobraNode.physicsBody?.affectedByGravity = true
        cobraNode.physicsBody?.isDynamic = true
        
        let bananaNode = SKSpriteNode(imageNamed: "Banana")
        bananaNode.size = CGSize(width: 95, height: 120)
        bananaNode.physicsBody?.categoryBitMask = CollisionBitMask.foodCategory
        bananaNode.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        bananaNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        bananaNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        bananaNode.physicsBody?.linearDamping = 1.1
        bananaNode.physicsBody?.restitution = 0
        bananaNode.physicsBody?.angularVelocity = 0
        
        bananaNode.physicsBody?.allowsRotation = false
        bananaNode.physicsBody?.affectedByGravity = true
        bananaNode.physicsBody?.isDynamic = true
        
        let macaNode = SKSpriteNode(imageNamed: "Maça")
        macaNode.size = CGSize(width: 95, height: 120)
        macaNode.physicsBody?.categoryBitMask = CollisionBitMask.foodCategory
        macaNode.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        macaNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        macaNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        macaNode.physicsBody?.linearDamping = 1.1
        macaNode.physicsBody?.restitution = 0
        macaNode.physicsBody?.angularVelocity = 0
        
        macaNode.physicsBody?.allowsRotation = false
        macaNode.physicsBody?.affectedByGravity = true
        macaNode.physicsBody?.isDynamic = true
        
        let morangoNode = SKSpriteNode(imageNamed: "Morango")
        morangoNode.size = CGSize(width: 45, height: 60)
        morangoNode.physicsBody?.categoryBitMask = CollisionBitMask.foodCategory
        morangoNode.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        morangoNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        morangoNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        morangoNode.physicsBody?.linearDamping = 1.1
        morangoNode.physicsBody?.restitution = 0
        morangoNode.physicsBody?.angularVelocity = 0
        
        morangoNode.physicsBody?.allowsRotation = false
        morangoNode.physicsBody?.affectedByGravity = true
        morangoNode.physicsBody?.isDynamic = true
        
        obst.addChild(aguiaNode)
        obst.addChild(cobraNode)
        obst.addChild(bananaNode)
        obst.addChild(macaNode)
        obst.addChild(morangoNode)
        
        obst.run(moveAndRemove)
        
        return obst
    }
    
}
