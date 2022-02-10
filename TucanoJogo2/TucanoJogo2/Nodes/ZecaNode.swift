//
//  ZecaNode.swift
//  TucanoJogo2
//
//  Created by Felipe Leite on 07/02/22.
//

import SpriteKit

public class ZecaNode: SKSpriteNode {
    public init(){
        let texture = SKTexture(imageNamed: "Tucano")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.name = "zeca"
        self.zPosition = 5
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 70))
        self.physicsBody?.linearDamping = 1.1
        self.physicsBody?.restitution = 0
        self.physicsBody?.angularVelocity = 0
        
        self.physicsBody?.categoryBitMask = CollisionBitMask.birdCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.obstacleCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.obstacleCategory | CollisionBitMask.foodCategory
        
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
