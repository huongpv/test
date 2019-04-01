import UIKit
import Parchment

class NetworkVC: AnimationHeaderViewController {

// MARK: - Constraints

// MARK: - Constants
fileprivate let cities = [
"Người dân",
"Doanh nghiệp",
"Mạng xã hội"
]
let pagingViewController = PagingViewController<CustomPagingItem>()

// MARK: - Variables
var listController = [UIViewController]()

// MARK: - Closures

// MARK: - Init & deinit

// MARK: - View life cycles
override func viewDidLoad() {
super.viewDidLoad()

mockData()
setupView()
}

// MARK: - Setup
func setupView() {
setTitle(title: "Lắng nghe mạng xã hội")
setupPageViewController()
}

private func setupPageViewController() {
pagingViewController.menuItemSource = .class(type: CustomPagingCell.self)
pagingViewController.dataSource = self
//pagingViewController.delegate = self
pagingViewController.menuItemSize = .fixed(width: SystemInfo.screenWidth/3, height: 40)
pagingViewController.indicatorColor = .clear
pagingViewController.menuBackgroundColor = .clear
pagingViewController.menuInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
pagingViewController.borderColor = .clear
addChild(pagingViewController)
view.addSubview(pagingViewController.view)
view.constrainToEdges(pagingViewController.view, topContraint: headerHeightConstraint.constant)
pagingViewController.didMove(toParent: self)
}

// MARK: - Data management
private func mockData() {
let networkDirectorVC = NetworkDirectorVC()
let testVC = UIViewController()
testVC.view.backgroundColor = .red
listController = [networkDirectorVC, networkDirectorVC, networkDirectorVC]
}

// MARK: - Action
override func didTapBackButton() {
navigationController?.popViewController(animated: true)
}

// MARK: - Update UI

// MARK: - Supporting methods
}

// MARK: - PagingViewControllerDataSource
extension NetworkVC: PagingViewControllerDataSource {

func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
return CustomPagingItem(icon: "icon_dot_page", index: index, title: cities[index]) as! T
}

func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
//        let viewController = listController[index]

// Inset the table view with the height of the menu height.
//        let menuHeight = pagingViewController.options.menuHeight
//        let insets = UIEdgeInsets(top: menuHeight+32, left: 0, bottom: 0, right: 0)
//        viewController.tableView.contentInset = insets
//        viewController.tableView.scrollIndicatorInsets = insets

// Set delegate so that we can listen to scroll events.
//        viewController.tableView.delegate = self

return NetworkDirectorVC()
}

func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
return cities.count
}

}

extension NetworkVC: UITableViewDelegate {
override func scrollViewDidScroll(_ scrollView: UIScrollView) {

}
}
