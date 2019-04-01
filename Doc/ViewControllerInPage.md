class EmployeeOverviewVC: UIViewController {
// MARK: - Outlets
@IBOutlet weak var tableView: UITableView!

// MARK: - Constraints

// MARK: - Constants

// MARK: - Variables

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
setupTableView()
}

private func setupTableView() {
tableView.setup(input: self)
}

// MARK: - Data management
private func mockData() {

}

// MARK: - Action

// MARK: - Update UI

// MARK: - Supporting methods
}

// MARK: - UITableViewDataSource
extension EmployeeOverviewVC: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<#code#>
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<#code#>
}


}

// MARK: - UITableViewDelegate
extension EmployeeOverviewVC: UITableViewDelegate {

}
