//
//  ViewController.swift
//  CoreData_Basic
//
//  Created by PHN MAC 1 on 07/07/23.
//

import UIKit

class StudentVC: UIViewController {
// MARK: - IBOutlets
    @IBOutlet weak var studentTableView: UITableView!
    var students: [Student] = []
    let coreDataHelper = CoreDataManager()
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        students = coreDataHelper.fetchStudent()
        studentTableView.reloadData()
    }

// MARK: - IBActions
    @IBAction func addStudentBtnClick(_ sender: Any) {
        let addStudentVC = self.storyboard?.instantiateViewController(withIdentifier: "AddStudentVC") as! AddStudentVC
        self.navigationController?.pushViewController(addStudentVC, animated: true)
    }
}

// MARK: - TableView DataSources
extension StudentVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = studentTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let student = students[indexPath.row]
        var context = cell.defaultContentConfiguration()
        context.text = student.firstName ?? "" + " " + (student.lastName ?? "")
        context.secondaryText = "Email:- " + (student.email ?? "")
        cell.contentConfiguration = context
        return cell
    }
}

// MARK: - TableView Delegate
extension StudentVC: UITableViewDelegate{
    //for Update button
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update"){ (_, _, _) in
            //Update Button Action here
            let updateStudentVC = self.storyboard?.instantiateViewController(withIdentifier: "AddStudentVC") as! AddStudentVC
            updateStudentVC.studentEntity = self.students[indexPath.row]
            updateStudentVC.isUpdate = true
            self.navigationController?.pushViewController(updateStudentVC, animated: true)
        }
        update.backgroundColor = .systemIndigo
        return UISwipeActionsConfiguration(actions: [update])
    }
    
    //for delete button
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            //Delete Button Action here
            self.coreDataHelper.deleteStudent(student: self.students[indexPath.row])
            self.students.remove(at: indexPath.row)
            self.studentTableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
