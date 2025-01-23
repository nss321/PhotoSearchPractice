//
//  NicknameViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class NicknameViewController: BaseViewController {

    let textField = UITextField()
    var contents: ((String)->Void)?
    
    @objc func okButtonTapped() {
        print(#function)
        contents!(textField.text!)
        navigationController?.popViewController(animated: true)
    }

    override func configHierarchy() {
        view.addSubview(textField)

    }
    override func configLayout() {
        textField.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    override func configView() {
        textField.placeholder = "닉네임을 입력해주세요"
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        
        
    }
}
