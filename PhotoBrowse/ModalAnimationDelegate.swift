//
//  ModalAnimationDelegate.swift
//  PhotoBrowse
//
//  Created by Jack.Ma on 16/4/28.
//  Copyright © 2016年 Jack.Ma. All rights reserved.
//

import UIKit

class ModalAnimationDelegate: NSObject, UIViewControllerTransitioningDelegate{
    private var isPresentAnimationing: Bool = true
}

extension ModalAnimationDelegate: UIViewControllerAnimatedTransitioning {
     func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresentAnimationing = true
        return self
     }
    
     func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresentAnimationing = false
        return self
    }
}

extension ModalAnimationDelegate {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        isPresentAnimationing ? presentViewAnimation(transitionContext) : dismissViewAnimation(transitionContext)
    }
    
    func presentViewAnimation(transitionContext: UIViewControllerContextTransitioning) {
        
        // 过渡view
        let destinationView = transitionContext.viewForKey(UITransitionContextToViewKey)
        // 容器view
        let containerView = transitionContext.containerView()
        guard let _ = destinationView else {
            return
        }
        print(destinationView)
        print(containerView)
        // 过渡view添加到容器view上
        containerView?.addSubview(destinationView!)
        // 目标控制器
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? PhotoBrowseCollectionVC
        let indexPath = destinationController?.indexPaht
        // 当前跳转的控制器
        let collectionViewController = ((transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)) as! UINavigationController).topViewController as! UICollectionViewController
        let currentCollectionView = collectionViewController.collectionView
        // 当前选中的cell
        let selectctedCell = currentCollectionView?.cellForItemAtIndexPath(indexPath!) as? CollectionViewCell
        // 新建一个imageview添加到目标view之上,做为动画view
        let annimateViwe = UIImageView()
        annimateViwe.image = selectctedCell?.imageView.image
        annimateViwe.contentMode = .ScaleAspectFill
        annimateViwe.clipsToBounds = true
        // 被选中的cell到目标view上的座标转换
        let originFrame = currentCollectionView!.convertRect(selectctedCell!.frame, toView: UIApplication.sharedApplication().keyWindow)
        annimateViwe.frame = originFrame
        containerView?.addSubview(annimateViwe)
        let endFrame = coverImageFrameToFullScreenFrame(selectctedCell?.imageView.image)
        destinationView?.alpha = 0
        // 过渡动画执行
        UIView.animateWithDuration(1, animations: {
            annimateViwe.frame = endFrame
        }) { (finished) in
            transitionContext.completeTransition(true)
            UIView.animateWithDuration(0.5, animations: {
                destinationView?.alpha = 1
            }) { (_) in
                annimateViwe.removeFromSuperview()
            }
        }
    }
    
    func dismissViewAnimation(transitionContext: UIViewControllerContextTransitioning) {
        let transitionView = transitionContext.viewForKey(UITransitionContextFromViewKey)
        let contentView = transitionContext.containerView()
        // 取出modal出的来控制器
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UICollectionViewController
        // 取出当前显示的collectionview
        let presentView = destinationController.collectionView
        // 取出控制器当前显示的cell
        let dismissCell = presentView?.visibleCells().first as? CollectionViewCell
        // 新建过渡动画imageview
        let animateImageView = UIImageView()
        animateImageView.contentMode = .ScaleAspectFill
        animateImageView.clipsToBounds = true
        // 获取当前显示的cell的image
        animateImageView.image = dismissCell?.imageView.image
        // 获取当前显示cell在window中的frame
        animateImageView.frame = (dismissCell?.imageView.frame)!
        contentView?.addSubview(animateImageView)
        // 动画最后停止的frame
        let indexPath = presentView?.indexPathForCell(dismissCell!)
        // 取出要返回的控制器view
        let originView = ((transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! UINavigationController).topViewController as! UICollectionViewController).collectionView
        
        var originCell = originView!.cellForItemAtIndexPath(indexPath!)
        if originCell == nil {
            originView?.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .CenteredVertically, animated: false)
            originView?.layoutIfNeeded()
        }
        originCell = originView!.cellForItemAtIndexPath(indexPath!)
        let originFrame = originView?.convertRect(originCell!.frame, toView: UIApplication.sharedApplication().keyWindow)
        UIView.animateWithDuration(1, animations: {
            animateImageView.frame = originFrame!
            transitionView?.alpha = 0
        }) { (_) in
            animateImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}