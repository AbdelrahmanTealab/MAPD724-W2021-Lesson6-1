import SpriteKit
import GameplayKit

class Island: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "island", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle Functions
    
    override func CheckBounds()
    {
        if isLandscape() {
            if(position.x <= -730)
            {
                Reset()
            }
        }
        else{
            if(position.y <= -730)
            {
                Reset()
            }
        }
    }
    
    override func Reset()
    {
        if isLandscape() {
            position.x = 730
            position.y = 0
            let randomY:Int = (randomSource?.nextInt(upperBound: 1000))! - 313
            position.y = CGFloat(randomY)
            isColliding = false
        }
        else{
            position.x = 0
            position.y = 730
            let randomX:Int = (randomSource?.nextInt(upperBound: 626))! - 313
            position.x = CGFloat(randomX)
            isColliding = false
        }
    }
    
    // initialization
    override func Start()
    {
        zPosition = 1
        Reset()
        if isLandscape() {
            dx = 5.0
            dy = 0.0
        }
        else{
            dx = 0.0
            dy = 5.0
        }
    }
    
    override func Update()
    {
        Move()
        CheckBounds()
    }
    
    func Move()
    {
        if isLandscape(){
            position.x -= dx!
            zRotation = CGFloat(Double.pi/2)
        }
        else{
            position.y -= dy!
            zRotation = 0
        }
    }
    override func isLandscape() -> Bool {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            dx = 5.0
            dy = 0.0
            return true
        }
        else{
            dx = 0.0
            dy = 5.0
            return false
        }
    }
    override func switchOrientation(){
        if isLandscape() {
            let temp = position.y
            position.y = position.x * -1
            position.x = temp
        }
        else{
            let temp = position.x
            position.x = position.y * -1
            position.y = temp
        }
        
    }
}
