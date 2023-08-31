import UIKit

class TodoListViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerMenu.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerMenu[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        30
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        focusedRow = row
    }
    
    
    var task: Task?
    let pickerMenu = ["work","study"]
    let pickerView: UIPickerView = UIPickerView()
    var focusedRow: Int = 0
    var selectedRow: Int = 0
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? TodoListTableViewCell else { return }
        if segue.identifier == "detail" {
            if let vc = segue.destination as? TodoDetailViewController {
                vc.task = cell.task
            }
        }
    }
    
    @IBAction func didTapAdd(_ sender: Any) {
        let alertController = UIAlertController(title: "할 일 추가 \n\n\n\n\n\n\n",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "할 일을 입력하세요"
        }
        
        
        let addAction = UIAlertAction(title: "추가",
                                      style: .default) { [weak self] _ in
            guard let self else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                self.selectedRow = self.focusedRow
                var defaultMenu = TaskMenu.study
                if selectedRow == 0 {
                    defaultMenu = TaskMenu.work
                }
                let newItem = Task(id: (TaskList.taskList().last?.id ?? -1) + 1,
                                   title: title,
                                   isCompleted: false,
                                   menu: defaultMenu)
                TaskList.addTask(newItem)
                self.tableView?.insertRows(at: [IndexPath(row: TaskList.filterbyMenu(menu: defaultMenu).count - 1, section: defaultMenu.toIndex())], with: .automatic)
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        pickerView.frame = CGRect(x: 0, y:50, width: 270, height: 130)
        pickerView.delegate = self
        pickerView.dataSource = self
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        alertController.view.addSubview(pickerView)
        present(alertController, animated: true)
    }
    
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TaskMenu.work.toIndex() {
            return TaskList.filterbyMenu(menu: .work).count
        } else if section == TaskMenu.study.toIndex() {
            return TaskList.filterbyMenu(menu: .study).count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard TaskList.taskList().count != 0 else { return nil }
        guard let menu = TaskMenu.menu(from: section) else { return nil }
        let titleHeader = menu.rawValue
        return TaskList.filterbyMenu(menu: menu).isEmpty ? nil : titleHeader
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoListTableViewCell
        if indexPath.section == TaskMenu.work.toIndex() {
            cell.setTask(TaskList.filterbyMenu(menu: .work)[indexPath.row])
        } else if indexPath.section == TaskMenu.study.toIndex() {
            cell.setTask(TaskList.filterbyMenu(menu: .study)[indexPath.row])
        }else {
            return UITableViewCell()
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return TaskMenu.allCases.count
    }
}
