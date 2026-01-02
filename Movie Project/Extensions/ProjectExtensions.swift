//
//  ProjectExtensions.swift
//  Mobillium Project
//
//  Created by Çağatay Eğilmez on 14.05.2022.
//

import Foundation
import UIKit
import Kingfisher
import SDWebImage
import Lottie
import ObjectiveC

//MARK: -Layout Extension
public extension UIView {
    
    func fillSuperview(with equalPadding: CGFloat) {
        let insets = UIEdgeInsets(top: equalPadding,
                                  left: equalPadding,
                                  bottom: equalPadding,
                                  right: equalPadding)
        fillSuperview(with: insets)
    }

    func fillSuperview(horizontalPadding: CGFloat,
                       verticalPadding: CGFloat) {
        fillSuperview(with: UIEdgeInsets(top: verticalPadding,
                                         left: horizontalPadding,
                                         bottom: verticalPadding,
                                         right: horizontalPadding))
    }

    func fillSuperview(with padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor,
               leading: superview?.leadingAnchor,
               bottom: superview?.bottomAnchor,
               trailing: superview?.trailingAnchor,
               topPadding: padding.top,
               leadingPadding: padding.left,
               bottomPadding: padding.bottom,
               trailingPadding: padding.right)
    }

    func fillSafeArea(with padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.safeAreaTopAnchor,
               leading: superview?.safeAreaLeadingAnchor,
               bottom: superview?.safeAreaBottomAnchor,
               trailing: superview?.safeAreaTrailingAnchor,
               topPadding: padding.top,
               leadingPadding: padding.left,
               bottomPadding: padding.bottom,
               trailingPadding: padding.right)
    }

    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, topPadding: CGFloat = 0, leadingPadding: CGFloat = 0, bottomPadding: CGFloat = 0, trailingPadding: CGFloat = 0, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingPadding).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -trailingPadding).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func sizeAnchor(width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    func aspect(ratio: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio).isActive = true
    }
    
    func centerAnchor(centerY: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, x: CGFloat = 0, y: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY, constant: y).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX, constant: x).isActive = true
        }
    }

    func centerYAnchor(to item: UIView, multiplier: CGFloat = 0, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: item, attribute: .centerY, multiplier: multiplier, constant: constant).isActive = true
    }
    
    func centerXAnchor(to item: UIView, multiplier: CGFloat = 0, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: item, attribute: .centerX, multiplier: multiplier, constant: constant).isActive = true
    }

    func alignCenterToSuperView() {
        alignCenterXToSuperView()
        alignCenterYToSuperView()
    }

    func alignCenterYToSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { return }
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }

    func alignCenterXToSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { return }
        centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
    }

    func equalWidth(with multiplier: CGFloat = 1.0, to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    }
}

// MARK: - Safe Area Layout
public extension UIView {
    var safeAreaTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }

    var safeAreaLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leadingAnchor
        } else {
            return self.leadingAnchor
        }
    }

    var safeAreaTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.trailingAnchor
        } else {
            return self.trailingAnchor
        }
    }
    
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}

//MARK: -Tab Gesture Extension
public protocol ViewIdentifier: AnyObject {
    static var viewIdentifier: String { get }
}

public extension ViewIdentifier {
    static var viewIdentifier: String {
        String(describing: self)
    }
}

extension UIView: ViewIdentifier {}

extension UIView {

    private struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }

    private typealias Action = (() -> Void)?

    private var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }

    func addTapGestureRecognizer(action: (() -> Void)?) {
        isUserInteractionEnabled = true
        tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }

}

//MARK: -Button Control Extension
extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->()) {
        let sleeve = ActionClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ActionClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
private class ActionClosureSleeve {
    let closure: ()->()

    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }

    @objc func invoke () {
        closure()
    }
}

//MARK: -Tableview Register Extension
public extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.viewIdentifier)
    }

    func dequeue<T: ViewIdentifier>(at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: T.viewIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("can not dequeue cell with identifier \(T.viewIdentifier) from collectionView \(self)")
        }
        return cell
    }
}

//MARK: -Label Create Extension
extension UILabel {
    static func create(text: String = "",
                       numberOfLines: Int = 0,
                       font: UIFont = UIFont.systemFont(ofSize: 16),
                       textColor: UIColor = UIColor.darkText,
                       textAlignment: NSTextAlignment = .left) -> UILabel {

        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        label.sizeToFit()
        return label
    }
}

//MARK: -UIIMageView load image extension with using KingFisher
extension UIImageView {
    @discardableResult func loadKF(_ url: String) -> UIImageView {
        let url = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: nil)
        {
            result in
            switch result {
            case .success(let value):
                print("Image downloaded: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Download failed: \(error.localizedDescription)")
            }
        }
        return self
    }
    
    //This one another 3rd party library to download images
    @discardableResult func loadSD(_ url: String) -> UIImageView {
        self.sd_setImage(with: URL(string: url))
        return self
    }
}

//MARK: -UIViewController loader animation and alert extension
extension UIViewController {
    
    var screenSize: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }
    
    private struct AssociatedKeys {

        static var loaderViewKey = "loaderViewKey"
    }

    private var loadingView: LoaderView {
        if let existing = objc_getAssociatedObject(self, &AssociatedKeys.loaderViewKey) as? LoaderView {
            return existing
        }

        let view = LoaderView(frame: UIScreen.main.bounds)
        objc_setAssociatedObject(self, &AssociatedKeys.loaderViewKey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return view
    }
    
    func showAlert(cancelName: String?, buttonName: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if cancelName != nil {
           alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        }
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            if self.tabBarController != nil {
                self.tabBarController?.present(alert, animated: true, completion: nil)
            } else {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func push(to viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func startLoader() {
        // loadingView.show(in: self.view, animated: true)
    }
    
    func stopLoader() {
        // loadingView.hide(animated: true)
    }
    
    @objc func popVc() {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: -UIColorExtensions

extension UIColor {
    public convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        guard cString.count == 6 else {
            self.init(white: 0.5, alpha: 1)
            return
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0)
        )
    }
}


//MARK: -Date Extension

extension Date {
    public func day() -> Int {
        let cal = Calendar.current
        return cal.component(.day, from: self)
    }
    
    public func month() -> Int {
        let cal = Calendar.current
        return cal.component(.month, from: self)
    }

    public func year() -> Int {
        let cal = Calendar.current
        return cal.component(.year, from: self)
    }
}

//MARK: UIApplication Extension For Status Bar
extension UIApplication {
var statusBarUIView: UIView? {

    if #available(iOS 13.0, *) {
        let tag = 3848245

        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first

        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999

            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }

    } else {

        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
  }
}

