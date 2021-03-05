import UIKit
import AVFoundation
import SpriteKit
import GameplayKit

let screenSize = UIScreen.main.bounds
var screenWidth: CGFloat?
var screenHeight: CGFloat?

class GameScene: SKScene,CanReceiveTransitionEvents
{

    
    // instance variables
    var ocean: Ocean?
    var island: Island?
    var plane: Plane?
    var clouds: [Cloud] = []
    
    override func didMove(to view: SKView)
    {
        screenWidth = frame.width
        screenHeight = frame.height
        
        name = "GAME"
        
        // add ocean to the scene
        ocean = Ocean() // allocate memory
        addChild(ocean!) // add object to the scene
        
        // add island to the scene
        island = Island()
        addChild(island!)
        
        // add plane to the scene
        plane = Plane()
        addChild(plane!)
        
        // add 3 clouds to the scene
        for index in 0...1
        {
            let cloud: Cloud = Cloud()
            clouds.append(cloud)
            addChild(clouds[index])
        }
        
        let engineSound = SKAudioNode(fileNamed: "engine.mp3")
        self.addChild(engineSound)
        engineSound.autoplayLooped = true
        
        // preload sounds
        do {
            let sounds:[String] = ["thunder", "yay"]
            for sound in sounds
            {
                let path: String = Bundle.main.path(forResource: sound, ofType: "mp3")!
                let url: URL = URL(fileURLWithPath: path)
	                let player: AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        } catch {
        }
        
    }
    
    
    func touchDown(atPoint pos : CGPoint)
    {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            plane?.TouchMove(newPos: CGPoint(x: -495, y: pos.y))
        }
        else{
            plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
        }
    }
    
    func touchMoved(toPoint pos : CGPoint)
    {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            plane?.TouchMove(newPos: CGPoint(x: -495, y: pos.y))
        }
        else{
            plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
        }
    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            plane?.TouchMove(newPos: CGPoint(x: -495, y: pos.y))
        }
        else{
            plane?.TouchMove(newPos: CGPoint(x: pos.x, y: -495))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    func viewWillTransition(to size: CGSize) {
        switchOrientation()
    }
    
    func switchOrientation() {
        let tempW = scene?.size.width
        scene?.size.width = (scene?.size.height)!
        scene?.size.height = tempW!
        ocean?.switchOrientation()
        plane?.switchOrientation()
        island?.switchOrientation()
        for cloud in clouds
        {
            cloud.switchOrientation()
        }
    }
    
    
    // this is where all the fun happens - this function is called about 60fps - every 16.666ms
    override func update(_ currentTime: TimeInterval)
    {
        ocean?.Update()
        island?.Update()
        plane?.Update()
        
        CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: island!)
        
        for cloud in clouds
        {
            cloud.Update()
            CollisionManager.SquaredRadiusCheck(scene: self, object1: plane!, object2: cloud)
        }
        
        
    }
}

//Reference: https://stackoverflow.com/questions/50012451/how-to-detect-device-rotation-from-skscene
protocol CanReceiveTransitionEvents {
    func viewWillTransition(to size: CGSize)
}
