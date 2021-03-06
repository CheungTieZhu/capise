//
//  UserOperationController.swift
//  capisce
//
//  Created by zxbMacPro on 2017/12/23.
//  Copyright © 2017年 capisce. All rights reserved.
//

import UIKit

enum userPosition: String {
    case administator     = "管理员"
    case manager          = "经理"
    case apartmentLeadr   = "部长"
    case teamLeader       = "组长"
    case teamMember       = "成员"
}

class UserOperationController: UITableViewController{
    
    @IBOutlet var userOperationTable: UITableView!
    var level: Int?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //查看公司介绍
        if segue.identifier == "viewTheCompanyDetail"{
            if let showInfoVC = segue.destination as? ShowCompanyInfoController{
                 if let parentVC = self.parent as? UserInfoController{
                    showInfoVC.companyDictionary = parentVC.companyDict
                    showInfoVC.index = parentVC.companyIndex
                }
            }
        }
        //添加部门
        if segue.identifier == "addDepartment"{
            if let showInfoVC = segue.destination as? AddOrganizationController{
                if let parentVC = self.parent as? UserInfoController{
                    showInfoVC.request = 0
                    showInfoVC.companyDictionary = parentVC.companyDict
                    showInfoVC.index = parentVC.companyIndex
                }
            }
        }
        //添加小组
        if segue.identifier == "addTeam"{
            if let showInfoVC = segue.destination as? AddOrganizationController{
                if let parentVC = self.parent as? UserInfoController{
                    showInfoVC.request = 1
                    showInfoVC.companyDictionary = parentVC.companyDict
                    showInfoVC.index = parentVC.companyIndex
                }
            }
        }
        //添加成员
        if segue.identifier == "addMember"{
            if let showInfoVC = segue.destination as? AddMemberController{
                if let parentVC = self.parent as? UserInfoController{
                    showInfoVC.companyDictionary = parentVC.companyDict
                    showInfoVC.index = parentVC.companyIndex
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userOperationTable.tableFooterView = UIView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getUserLevel()
        userOperationTable.reloadData()
    }
    
    private func getUserLevel(){
        if let parentVC = self.parent as? UserInfoController{
            let companyIndex = parentVC.companyIndex
            level = parentVC.companyDict?.company[companyIndex].level
        }
    }
}
extension UserOperationController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getUserLevel()
        switch level {
        case 4?:
            return 10
        case 3?:
            return 9
        case 2?:
            return 8
        case 1?:
            return 6
        case 0?:
            return 5
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userOperationTable.dequeueReusableCell(withIdentifier: "userOperationCellId", for: indexPath) as! UserOperationCell
        cell.itemImage.layer.masksToBounds = true
        cell.itemImage.layer.cornerRadius = CGFloat(Int(cell.itemImage.frame.width)/2)
        if let parentVC = self.parent as? UserInfoController{
            let companyIndex = parentVC.companyIndex
            if let company = parentVC.companyDict?.company[companyIndex].company,let apartment = parentVC.companyDict?.company[companyIndex].apartment,let team = parentVC.companyDict?.company[companyIndex].team,let position = level{
                switch indexPath.row{
                case 0:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_company")
                    cell.itemNameLabel.text = "公司："
                    cell.itemExpressionLabel.text = company
                case 1:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_department")
                    cell.itemNameLabel.text = "部门："
                    cell.itemExpressionLabel.text = apartment
                case 2:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_team")
                    cell.itemNameLabel.text = "小组："
                    cell.itemExpressionLabel.text = team
                case 3:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_position")
                    cell.itemNameLabel.text = "职位："
                    switch position{
                    case 4:
                        cell.itemExpressionLabel.text = userPosition.administator.rawValue
                    case 3:
                        cell.itemExpressionLabel.text = userPosition.manager.rawValue
                    case 2:
                        cell.itemExpressionLabel.text = userPosition.apartmentLeadr.rawValue
                    case 1:
                        cell.itemExpressionLabel.text = userPosition.teamLeader.rawValue
                    default:
                        cell.itemExpressionLabel.text = userPosition.teamMember.rawValue
                    }
                case 4:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_view")
                    cell.itemNameLabel.text = "查看："
                    cell.itemExpressionLabel.text = "成员"
                case 5:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_manage")
                    cell.itemNameLabel.text = "管理："
                    cell.itemExpressionLabel.text = "任务"
                case 6:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_manage_member")
                    cell.itemNameLabel.text = "管理："
                    cell.itemExpressionLabel.text = "成员"
                case 7:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_add_department")
                    cell.itemNameLabel.text = "新增："
                    cell.itemExpressionLabel.text = "小组"
                case 8:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_add_team")
                    cell.itemNameLabel.text = "新增："
                    cell.itemExpressionLabel.text = "部门"
                case 9:
                    cell.itemImage.image = #imageLiteral(resourceName: "capisce_add_menber")
                    cell.itemNameLabel.text = "新增："
                    cell.itemExpressionLabel.text = "成员"
                default:
                    cell.itemNameLabel.text = "company"
                    cell.itemExpressionLabel.text = company
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "viewTheCompanyDetail", sender: nil)
        case 1:
            performSegue(withIdentifier: "viewTheApartmentDetail", sender: nil)
        case 2:
            performSegue(withIdentifier: "viewTheTeamDetail", sender: nil)
        case 4:
            performSegue(withIdentifier: "viewTheMemberDetail", sender: nil)
        case 5:
            performSegue(withIdentifier: "manageTheTask", sender: nil)
        case 6:
            performSegue(withIdentifier: "ManageMember", sender: nil)
        case 7:
            performSegue(withIdentifier: "addTeam", sender: nil)
        case 8:
            performSegue(withIdentifier: "addDepartment", sender: nil)
        case 9:
            performSegue(withIdentifier: "addMember", sender: nil)
        default:
            print("WTF")
        }
    }
    
}

