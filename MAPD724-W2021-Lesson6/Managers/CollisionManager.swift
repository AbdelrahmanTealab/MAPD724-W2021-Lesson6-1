import SpriteKit
import GameplayKit

class CollisionManager
{
    public static var gameViewController: GameViewController?
    
    public static func SquaredDistance(point1: CGPoint, point2: CGPoint) -> CGFloat
    {
        let Xs: CGFloat = point2.x - point1.x
        let Ys: CGFloat = point2.y - point1.y
        return Xs * Xs + Ys * Ys
    }
    
    public static func SquaredRadiusCheck(scene: SKScene, object1: GameObject, object2: GameObject) -> Void
    {
        let P1 = object1.position
        let P2 = object2.position
        var P1HalfHeight = object1.halfHeight!
        var P2HalfHeight = object2.halfHeight!
        var HalfHeights = P1HalfHeight + P2HalfHeight
        
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            P1HalfHeight = object1.halfWidth!
            P2HalfHeight = object2.halfWidth!
            HalfHeights = P1HalfHeight + P2HalfHeight
            print("Collision manager is using half widths")
        }
        
        if(SquaredDistance(point1: P1, point2: P2) < HalfHeights * HalfHeights)
        {
            if(!object2.isColliding!)
            {
                switch object2.name
                {
                case "island":
                    ScoreManager.Score += 100
                    gameViewController?.updateScoreLabel()
                    scene.run(SKAction.playSoundFileNamed("yay", waitForCompletion: false))
                    break
                case "cloud":
                    ScoreManager.Lives -= 1
                    gameViewController?.updateLivesLabel()
                    scene.run(SKAction.playSoundFileNamed("thunder", waitForCompletion: false))
                    break
                default:
                    break
                }
                object2.isColliding = true
            }
        }
    }
}
