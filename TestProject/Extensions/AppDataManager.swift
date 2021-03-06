

import UIKit


public class BaseViewController: UIViewController {
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = !self.shouldShowTabBar()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // set interface style to light mode
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        

    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        

    }
    
    
    func shouldShowTabBar() -> Bool {
        guard self.navigationController != nil else { return false }
        return self.navigationController?.viewControllers.first == self
    }
   
    // MARK: - action methods
    @IBAction private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: - other methods
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

protocol Creatable: UIView {
    init()
}

extension Creatable {
    static func create(_ builder: (Self) -> Void) -> Self {
        let view = Self.init()
        builder(view)
        return view
    }
}

extension UIView: Creatable {
    
    public func addSubviews(_ views: UIView...) {
        views.forEach { (view) in
            self.addSubview(view)
        }
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true, cornerRadius: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = .zero
//            CGSize(width: -1, height: 3)
        layer.shadowRadius = 4
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIStackView {
    
    public func addArrangedViews(_ views: UIView...) {
        views.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
}



extension UITableView {
    
    func register(_ cell: AnyClass) {
        self.register(cell, forCellReuseIdentifier: String(describing: cell))
    }
    
    func registerHeader(_ header: AnyClass) {
        self.register(header, forHeaderFooterViewReuseIdentifier: String(describing: header))
    }
    
    func dequeue(_ cell: AnyClass, indexPath: IndexPath) -> UITableViewCell {
        self.dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath)
    }
    
    func dequeueCell<Cell: UITableViewCell>(_ cell: Cell.Type, indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else { return Cell() }
        return cell
    }
 
    func dequeue<Header: UITableViewHeaderFooterView>(header: Header.Type) -> Header {
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: String(describing: Header.self)) as? Header else {
            return Header()
        }
        return header
    }
}

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

}


extension UIViewController {
    
    func showAlertMesssage(title: String?, message:String?, okHandler:((UIAlertAction) -> Void)? = nil, okTitle: String = "OK") {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler: okHandler))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
