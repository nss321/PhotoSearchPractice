//
//  LevelViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class LevelViewController: BaseViewController {

    let segmentedControl = UISegmentedControl(items: ["상", "중", "하"])
    var level: Level?
    
    @objc func okButtonTapped() {
        print(#function)
        NotificationCenter.default.post(
            name: NSNotification.Name("level"),
            object: nil,
            userInfo: [
                "index": segmentedControl.selectedSegmentIndex,
                "text": segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) ?? ""
            ]
        )
        navigationController?.popViewController(animated: true)
    }
    override func configHierarchy() {
        view.addSubview(segmentedControl)
    }
    
    override func configLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    override func configView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        
        if let level {
            segmentedControl.selectedSegmentIndex = level.index
        } else {
            segmentedControl.selectedSegmentIndex = 0
        }
    }

}
