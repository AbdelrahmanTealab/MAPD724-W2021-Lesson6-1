import SpriteKit
import GameplayKit

class Plane: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "plane", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle Functions
    
    override func CheckBounds()
    {
        if isLandscape() {
            // constrain on the left - left boundary
            if(position.y <= -310)
            {
                position.y = -310
            }
            
            // constrain on the right - right boundary
            if(position.y >= 310)
            {
                position.y = 310
            }
            
        }
        else{
            // constrain on the left - left boundary
            if(position.x <= -310)
            {
                position.x = -310
            }
            
            // constrain on the right - right boundary
            if(position.x >= 310)
            {
                position.x = 310
            }
            
        }
    }
    
    override func Reset()
    {
       
    }
    
    // initialization
    override func Start()
    {
        zPosition = 2
        if isLandscape() {
            position.y = -495
            zRotation = CGFloat(Double.pi/2)
            yScale = -2
        }
        else{
            position.x = 0
            position.y = -495
            zRotation = 0
            yScale = 2
        }
    }
    
    override func Update()
    {
        CheckBounds()
    }
    
    func TouchMove(newPos: CGPoint)
    {
        position = newPos
    }
    
    override func isLandscape() -> Bool {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            zRotation = CGFloat(Double.pi/2)
            yScale = -2
            return true
        }
        else{
            zRotation = 0
            yScale = 2
            return false
        }
    }
    override func switchOrientation(){
        if isLandscape() {
            position.y = position.x * -1
            position.x = -495
            zRotation = CGFloat(Double.pi/2)
            yScale = -2
        }
        else{
            position.x = position.y * -1
            position.y = -495
            zRotation = 0
            yScale = 2
        }
        
    }
}
