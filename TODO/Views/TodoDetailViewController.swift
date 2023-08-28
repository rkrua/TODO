import UIKit

class TodoDetailViewController: UIViewController {
    
    var task: Task?

    @IBOutlet weak var taskTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTitle.text = task?.title
    }

    @IBAction func didTapEditButton() {
        let alertController = UIAlertController(title: "수정하기",
                                                message: nil,
                                                preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "수정 내용을 입력하세요"
        }
        let addAction = UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            guard let self, let task else { return }
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                TaskList.editTask(task: task, title: title)
                self.taskTitle.text = title
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
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
