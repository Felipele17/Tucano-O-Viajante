//
//  GameScene.swift
//  TucanoJogo2
//
//  Created by Felipe Leite on 27/01/22.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Pontuaçãp: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "Céu")
        background.position = CGPoint(x: 195, y: 422)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Pontuação: 0"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 195, y: 720)
        addChild(scoreLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        let zeca = SKSpriteNode(imageNamed: "Tucano")
        zeca.position = CGPoint(x: 195, y: 120)
        let jumpUpAction = SKAction.moveBy(x: 5, y: 20, duration: 0.2)
        let jumpSequence = SKAction.sequence([jumpUpAction])
        zeca.run(jumpSequence)
        addChild(zeca)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var isRight: Bool = false
        var isLeft: Bool = false
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if(location.x < self.frame.size.width/2){
                isLeft = true
            }
            
            if(location.x > self.frame.size.width/2){
                isRight = true
            }
        }
        
    }
}
