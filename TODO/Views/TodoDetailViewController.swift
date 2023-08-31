import UIKit

class TodoDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
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


    @IBOutlet weak var taskTitle: UILabel!
    
    @IBOutlet weak var taskMenu: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.text = task?.title
        if task?.menu == .study {
            taskMenu.text = "study"
        } else {
            taskMenu.text = "work"
        }
    }
    
    @IBAction func didTapEditButton() {
        

        let alertController = UIAlertController(title: "수정하기 \n\n\n\n\n\n\n",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "수정 내용을 입력하세요"
        }
        let addAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            guard let self, let task else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                self.selectedRow = self.focusedRow
                var defaultMenu = task.menu
                if selectedRow == 0 {
                    defaultMenu = TaskMenu.work
                } else {
                    defaultMenu = TaskMenu.study
                }
                TaskList.editTask(task: task, title: title)
                TaskList.editMenu(task: task, menu: defaultMenu)
                self.taskMenu.text = pickerMenu[selectedRow]
                self.taskTitle.text = title
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        pickerView.frame = CGRect(x: 0, y:50, width: 270, height: 130)
        pickerView.delegate = self
        pickerView.dataSource = self
        alertController.view.addSubview(pickerView)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "삭제하기",
                                                message: "정말 삭제하겠습니까?",
                                                preferredStyle: .alert)
        let addAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self, let task else { return }
            TaskList.deleteTask(task: task)
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
}
