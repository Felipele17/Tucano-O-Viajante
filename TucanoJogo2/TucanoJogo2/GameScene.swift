//
//  GameScene.swift
//  TucanoJogo2
//
//  Created by Felipe Leite on 27/01/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var dropList = [SKSpriteNode]()
    var images = ["Águia","Banana","Cobra","Maça","Morango"]
    
    var isGameStarted = Bool(false)
    var isDied = Bool(false)
    
    var score = Int(0)
    var scoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var restartBtn = SKSpriteNode()
    var pauseBtn = SKSpriteNode()
    var obst = SKNode()
    var moveAndRemove = SKAction()
    
    var zeca = SKSpriteNode()
    
    func createScene(){
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
        
        self.physicsWorld.contactDelegate = self
        
        let background = SKSpriteNode(imageNamed: "Céu")
        background.position = CGPoint(x: 195, y: 422)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        zeca = createZeca()
        addChild(zeca)
        
        scoreLbl = createScoreLabel()
        self.addChild(scoreLbl)
        
        taptoplayLbl = createTaptoplayLabel()
        self.addChild(taptoplayLbl)
    }
    
    override func didMove(to view: SKView) {
        createScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isGameStarted == false{
            isGameStarted =  true
            zeca.physicsBody?.affectedByGravity = true
            createPauseBtn()
            taptoplayLbl.removeFromParent()
            recursiveDrop()
            
            
            
            zeca.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            zeca.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
        } else {
            if isDied == false {
                zeca.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                zeca.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 40))
            }
        }
        for touch in touches{
            let location = touch.location(in: self)
            if isDied == true{
                if restartBtn.contains(location){
                    restartScene()
                }
            } else {
                if pauseBtn.contains(location){
                    if self.isPaused == false{
                        self.isPaused = true
                        pauseBtn.texture = SKTexture(imageNamed: "Play")
                    } else {
                        self.isPaused = false
                        pauseBtn.texture = SKTexture(imageNamed: "Pause")
                    }
                }
            }
        }
        var isRight : Bool = false
        var isLeft : Bool = false
        
        if zeca.position.y < 400 {
            let jumpUpActionD = SKAction.moveBy(x: 60, y: 100, duration: 0.3)
            let jumpUpActionE = SKAction.moveBy(x: -60, y: 100, duration: 0.3)
            let jumpSequenceD = SKAction.sequence([jumpUpActionD])
            let jumpSequenceE = SKAction.sequence([jumpUpActionE])
            
            for touch in touches {
                let location = touch.location(in: self)
                
                if(location.x < self.frame.size.width/2){
                    isLeft = true
                    zeca.run(jumpSequenceE)
                }
                
                if(location.x > self.frame.size.width/2){
                    isRight = true
                    zeca.run(jumpSequenceD)
                }
            }
            if (isRight && isLeft){
                
            }
        }
        
    }
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.obstacleCategory || firstBody.categoryBitMask == CollisionBitMask.obstacleCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory{
            enumerateChildNodes(withName: "Obst", using: ({
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            }))
            if isDied == false{
                isDied = true
                createRestartBtn()
                pauseBtn.removeFromParent()
                self.zeca.removeAllActions()
            }
        } else if firstBody.categoryBitMask == CollisionBitMask.birdCategory && secondBody.categoryBitMask == CollisionBitMask.foodCategory {
            score += 1
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        } else if firstBody.categoryBitMask == CollisionBitMask.foodCategory && secondBody.categoryBitMask == CollisionBitMask.birdCategory {
            score += 1
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
        }
    }
    func createDrop(){
        var positionX = [100, 280]
        images.shuffle()
        positionX.shuffle()
        let drop = SKSpriteNode(imageNamed: images[0])
        if images[0] == "Morango" {
            drop.name = "Good Drop"
        } else {
            drop.name = "Bad Drop"
        }
        drop.size = CGSize(width: 95, height: 120)
        drop.position = CGPoint(x: positionX[0], y: 820)
        drop.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        drop.physicsBody?.linearDamping = 1.1
        drop.physicsBody?.restitution = 0
        drop.physicsBody?.angularVelocity = 0
        
        drop.physicsBody?.allowsRotation = false
        drop.physicsBody?.affectedByGravity = true
        drop.physicsBody?.isDynamic = true
        addChild(drop)
        dropList.append(drop)
    }
    
    func recursiveDrop(){
        let recursive = SKAction.sequence([
            SKAction.run(createDrop),
            SKAction.wait(forDuration: 2),
            SKAction.removeFromParent(),
            SKAction.run({[unowned self] in self.recursiveDrop()}),
        ])
        
        run(recursive, withKey: "aKey")
    }
    
    func cancelActionDropBall() {
        removeAction(forKey: "aKey")
    }
    
    func restartScene(){
        self.removeAllChildren()
        self.removeAllActions()
        isDied = false
        isGameStarted = false
        score = 0
        createScene()
    }
}
