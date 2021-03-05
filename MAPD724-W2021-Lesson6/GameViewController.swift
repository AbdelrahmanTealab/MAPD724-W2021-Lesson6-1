import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{

    @IBOutlet weak var LivesLabel: UILabel!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                // Present the scene
                view.presentScene(scene)
                if view.bounds.size.width > view.bounds.size.height {
                    //switch height and width
                    scene.switchOrientation()
                    scene.plane?.TouchMove(newPos: CGPoint(x: -495, y: 0))
                }
            }
            
            view.ignoresSiblingOrder = true
            
        }
        
        CollisionManager.gameViewController = self
        ScoreManager.Score = 0
        ScoreManager.Lives = 5
        updateLivesLabel()
        updateScoreLabel()
        
    }

    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func updateScoreLabel() -> Void
    {
        ScoreLabel.text  = "Score: \(ScoreManager.Score)"
    }
        
    func updateLivesLabel() -> Void
    {
        LivesLabel.text = "Lives: \(ScoreManager.Lives)"
    }
    //Reference: https://stackoverflow.com/questions/50012451/how-to-detect-device-rotation-from-skscene
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)

        guard
            let skView = self.view as? SKView,
            let canReceiveRotationEvents = skView.scene as? CanReceiveTransitionEvents else { return }
        canReceiveRotationEvents.viewWillTransition(to: size)
    }
    
}
