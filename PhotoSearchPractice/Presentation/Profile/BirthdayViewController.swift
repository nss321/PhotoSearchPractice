//
//  BirthdayViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

protocol PassBirthdayDelegate {
    func receiveBirthday(value: String)
}

class BirthdayViewController: BaseViewController {
    
    let datePicker = UIDatePicker()
    var contents: PassBirthdayDelegate?
    
    @objc func okButtonTapped() {
        print(#function)
        let birthday = DateManager.shared.convertBirthday(date: datePicker.date)
        contents?.receiveBirthday(value: birthday)
        navigationController?.popViewController(animated: true)
    }

    override func configHierarchy() {
        view.addSubview(datePicker)
        
    }
    override func configLayout() {
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    override func configView() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
    }
    
}

