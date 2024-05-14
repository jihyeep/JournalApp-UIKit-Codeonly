//
//  ViewController.swift
//  JRNL-Codeonly
//
//  Created by 박지혜 on 5/13/24.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddJournalControllerDelegate {
    // MARK: - 초기화
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var sampleJournalEntryData = SampleJournalEntryData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sampleJournalEntryData.createSampleJournalEntryData()
        
        // delegation 설정
        tableView.dataSource = self
        tableView.delegate = self
        // dequeueReusableCell을 사용하기 위한 셀 생성
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell")

        // MARK: - 뷰 설정
        // 배경색 설정
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        // 컨스트레인트 수동 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        // 컨스트레인트 설정
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addJournal))
    }
    
    // MARK: - UITableViewDataSource
    // 테이블뷰 행 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleJournalEntryData.journalEntries.count
    }
    // 테이블뷰 행에 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        cell.configureCell(journalEntry: journalEntry)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    // 테이블뷰 행 클릭 시 디테일 뷰 보여짐
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        let journalDetailViewController = JournalDetailViewController(journalEntry: journalEntry)
        show(journalDetailViewController, sender: self)
    }
    
    // 테이블뷰 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    // MARK: - Methods
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let navigationController = UINavigationController(rootViewController: addJournalViewController)
        addJournalViewController.delegate = self
    
        // 모달 뷰
        present(navigationController, animated: true)
    }
    
    public func saveJournalEntry(_ journalEntry: JournalEntry) {
        sampleJournalEntryData.journalEntries.append(journalEntry)
        tableView.reloadData() // 화면갱신 필수
    }


}

