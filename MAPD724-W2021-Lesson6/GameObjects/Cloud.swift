import SpriteKit
import GameplayKit

class Cloud: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "cloud", initialScale: 1.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle Functions
    
    override func CheckBounds()
    {
        if isLandscape() {
            if(position.x <= -756)
            {
                Reset()
            }
        }
        else{
            if(position.y <= -756)
            {
                Reset()
            }
        }
    }
    
    override func Reset()
    {
        if isLandscape() {
            dy = CGFloat((randomSource?.nextUniform())! * -4.0) + 2.0
            dx = CGFloat((randomSource?.nextUniform())! * 5.0) + 5.0
            
            // get a pseudo-random number for landscape
            let randomX:Int = (randomSource?.nextInt(upperBound: 10))! + 756
            position.x = CGFloat(randomX)
            
            let randomY:Int = (randomSource?.nextInt(upperBound: 524))! - 262
            position.y = CGFloat(randomY)
            
            isColliding = false
        }
        else{
            dy = CGFloat((randomSource?.nextUniform())! * 5.0) + 5.0
            dx = CGFloat((randomSource?.nextUniform())! * -4.0) + 2.0
            
            // get a pseudo-random number for portrait
            let randomX:Int = (randomSource?.nextInt(upperBound: 524))! - 262
            position.x = CGFloat(randomX)
            
            let randomY:Int = (randomSource?.nextInt(upperBound: 10))! + 756
            position.y = CGFloat(randomY)
            
            isColliding = false
            
        }
    }
    
    // initialization
    override func Start()
    {
        zPosition = 3
        alpha = 0.5
        Reset()
    }
    
    override func Update()
    {
        Move()
        CheckBounds()
    }
    
    func Move()
    {
        if isLandscape(){
            zRotation = CGFloat(Double.pi/2)
            yScale = -1
        }
        else{
            zRotation = 0
            yScale = 1
        }
        position.y -= dy!
        position.x -= dx!
    }
    override func isLandscape() -> Bool {
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            return true
        }
        else{
            return false
        }
    }
    override func switchOrientation(){
        let temp = position.y
        position.y = position.x * -1
        position.x = temp
        
        let tempDy = dy
        dy = dx
        dx = tempDy
        
    }
}
