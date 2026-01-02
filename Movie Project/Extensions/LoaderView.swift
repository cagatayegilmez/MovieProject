//
//  LoaderView.swift
//  Mobillium Project
//
//  Created by Çağatay Eğilmez on 2.01.2026.
//

import Lottie
import UIKit

@objcMembers
final class LoaderView: UIView {

    private enum Constant {

        static let animatedImageName = "loading"
        static let animatedImageSize = CGSize(width: 44.0, height: 44.0)
    }

    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: Constant.animatedImageName)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop

        return animationView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Shows loading view in given superview.
    /// - Parameter view: Superview that the loading view will be attached.
    /// - Parameter animated: Boolean value indicating if showing should be realized with animation.
    func show(in view: UIView, animated: Bool) {
        view.endEditing(true)

        if superview != view {
            resetAnimation()
            view.addSubview(self)
            view.fillSafeArea()
            layoutIfNeeded()

            let animationDuration = animated ? 0.3 : 0.0
            UIView.animate(
                withDuration: animationDuration,
                animations: {
                    self.alpha = 1.0
                },
                completion: { _ in
                    self.animationView.play()
                    UIAccessibility.post(
                        notification: UIAccessibility.Notification.announcement,
                        argument: "Yükleniyor")
                })
        }
    }

    /// Hides loading view.
    /// - Parameter animated: Boolean value indicating if hiding should be realized with animation.
    func hide(animated: Bool) {
        if superview == nil {
            return
        }

        let animationDuration = animated ? 0.3 : 0.0
        UIView.animate(
            withDuration: animationDuration,
            animations: {
                self.alpha = 0.0
            },
            completion: { _ in
                self.animationView.stop()
                self.removeFromSuperview()

                UIAccessibility.post(
                    notification: UIAccessibility.Notification.announcement,
                    argument: "Yüklendi")
            })
    }

    private func resetAnimation() {
        alpha = 0.0

        if animationView.isAnimationPlaying {
            animationView.stop()
        }

        animationView.isAccessibilityElement = false
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black.withAlphaComponent(0.6)

        addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(
                equalToConstant: Constant.animatedImageSize.width),
            animationView.heightAnchor.constraint(
                equalToConstant: Constant.animatedImageSize.height),
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        //isAccessibilityElement = ProcessInfo.ic_isUITest
        accessibilityIdentifier = "loadingView"
        resetAnimation()
    }
}
