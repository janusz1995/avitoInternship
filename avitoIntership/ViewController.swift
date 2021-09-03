//
//  ViewController.swift
//  avitoIntership
//
//  Created by Janusz on 9/1/21.
//

import UIKit
import SnapKit

private var countCells = 4
let heightCell = 60
//private var heightTV = countCells * heightCell
let sideConstraint = 10
let host = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
let session = URLSession.shared
let tintText: CGFloat = 24


class ViewController: UIViewController {

    private var companyModel: model? = nil
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: tintText)
        label.text = "Name"
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: tintText)
        label.text = "Phone"
        return label
    }()

    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: tintText)
        label.text = "Skills"
        return label
    }()

    private let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.cornerRadius = 10.0
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        getCall()
        setupView()
        setupTableView()
        setupInfoView()
        setupNameLabel()
        setupPhoneLabel()
        setupSkillsLabel()
    }

    private func setupView() {
        view.addSubview(tableView)
        view.addSubview(infoView)
    }

    private func setupInfoView() {
        infoView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(sideConstraint)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-sideConstraint)
            make.height.equalTo(50)
        }
//        infoView.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        infoView.layer.cornerRadius = 8

        infoView.addSubview(nameLabel)
        infoView.addSubview(phoneLabel)
        infoView.addSubview(skillsLabel)
    }
    
    private func setupNameLabel() {
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(infoView).offset(15)
            make.centerY.equalTo(infoView)
        }
    }
    
    private func setupPhoneLabel() {
        phoneLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.centerX.equalTo(infoView)
        }
    }
    
    private func setupSkillsLabel() {
        skillsLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(infoView).offset(-15)
            make.centerY.equalTo(infoView)
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellTableView.self, forCellReuseIdentifier: "CellTableView")
        tableView.isScrollEnabled = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(sideConstraint)
            make.right.equalTo(view).offset(-sideConstraint)
            make.top.equalTo(view).offset(100)
            make.bottom.equalTo(view).offset(-10)
//            make.height.equalTo(heightCell * countCells)
//            make.right.equalTo(view.rightAnchor)
        }
    }
    
    

    private func getCall() {
        
        guard let url = URL(string: host) else {
            print("Failed url :(")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
            
            guard let responseData = data else {
                print("Error data :(")
                return
            }
            do {
                let json = try JSONDecoder().decode(model.self, from: responseData)
                self.companyModel = json
                guard let cm = self.companyModel else {
                    print("Can`t get company model")
                    return
                }
                countCells = cm.company.employees.count
                print(countCells)
                print(json)
//                heightTV = countCells * heightCell
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    print(countCells)
//                }
//                countCells = json.company.employees.count
            } catch {
                print("Error json :(")
            }
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
//                print("The Response is : ",json)
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
//            }
//            print(responseData)
        }.resume()
    }
}




extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightCell)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCells
//        return companyModel == nil ? 0 : companyModel!.company.employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "CellTableView", for: indexPath) as? CellTableView
        else {
            fatalError("Don't create CellTableView cell")
        }
        cell.setupCell(name: "Jack")
//        cell.setupCell(labelForCell: sideMenuButtonArray[indexPath.row].label, pathForImage: sideMenuButtonArray[indexPath.row].iconName)
//        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        cell.selectionStyle = .none
        return cell
    }
}

