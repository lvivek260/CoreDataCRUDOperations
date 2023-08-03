//
//  AddStudentVC.swift
//  CoreData_Basic
//
//  Created by PHN MAC 1 on 07/07/23.
//

import UIKit

class AddStudentVC: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var add_UpdateBtn: UIButton!
    
    let coreDataHelper = CoreDataManager()
    var isUpdate: Bool = false
    var studentEntity : Student?
    
// MARK: - ViewLifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

// MARK: - IBActions
    @IBAction func add_UpdateAction(_ sender: Any) {
        guard let firstName = firstNameTxt.text, !firstNameTxt.text!.isEmpty else{
            self.showAlert(message: "First Name should not be Empty")
            return
        }
        guard let lastName = lastNameTxt.text, !lastNameTxt.text!.isEmpty else{
            self.showAlert(message: "Last Name should not be Empty")
            return
        }
        guard let email = emailTxt.text, !emailTxt.text!.isEmpty else{
            self.showAlert(message: "Email id should not be Empty")
            return
        }
        guard let mobileNumber = mobileNumberTxt.text, !mobileNumberTxt.text!.isEmpty else{
            self.showAlert(message: "mobile Number should not be Empty")
            return
        }
        
        let student = StudentModel(
            firstName: firstName,
            lastName: lastName,
            email: email,
            mobileNumber: mobileNumber)
        
        if isUpdate{
            //update student here
            guard let studentEntity = self.studentEntity else {return}
            coreDataHelper.updateStudent(newStudent: student, oldStudent: studentEntity)
        }
        else {
           //new student add here
            coreDataHelper.saveStudent(student)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Configurations
extension AddStudentVC{
    private func configuration(){
        if isUpdate{
            //setValue
            self.firstNameTxt.text = self.studentEntity?.firstName
            self.lastNameTxt.text = self.studentEntity?.lastName
            self.emailTxt.text = self.studentEntity?.email
            self.mobileNumberTxt.text = self.studentEntity?.mobileNumber
            //change Titles
            self.title = "Update Student"
            self.add_UpdateBtn.setTitle("Update", for: .normal)
        }
        else{
            self.title = "Add Student"
            self.add_UpdateBtn.setTitle("Add", for: .normal)
        }
    }
}

// MARK: - UIViewController Extension
extension UIViewController{
    func showAlert(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok: UIAlertAction = .init(title: "Okey", style: .cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
