import SpriteKit
import GameplayKit

class Ocean: GameObject
{
    
    // constructor
    init()
    {
        super.init(imageString: "ocean", initialScale: 2.0)
        Start()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle Functions
    
    override func CheckBounds()
    {
        if isLandscape() {
            if(position.x <= -773)
            {
                Reset()
            }
        }
        else{
            if(position.y <= -773)
            {
                Reset()
            }
        }
    }
    
    override func Reset()
    {
        if isLandscape() {
            position.x = 773
            position.y = 0
        }
        else{
            position.x = 0
            position.y = 773
        }
    }
    
    // initialization
    override func Start()
    {
        zPosition = 0
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
            yScale = -2
        }
        else{
            position.y -= dy!
            zRotation = 0
            yScale = 2
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
            
            dx = 5.0
            dy = 0.0
        }
        else{
            let temp = position.x
            position.x = position.y * -1
            position.y = temp
            
            dx = 0.0
            dy = 5.0
        }
    }
}
