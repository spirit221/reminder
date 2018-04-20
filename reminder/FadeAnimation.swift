import Foundation
import UIKit
class FadeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        if let vc = toViewController {
            transitionContext.finalFrame(for: vc)
            transitionContext.containerView.addSubview(vc.view)
            vc.view.alpha = 0.0
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                           animations: {
                            vc.view.alpha = 1.0
            },
                           completion: { _ in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            NSLog("No")
        }
    }
}
