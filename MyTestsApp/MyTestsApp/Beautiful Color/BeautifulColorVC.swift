//
//  BeautifulColorVC.swift
//  MyTestsApp
//
//  Created by Kanyan Zheng on 2022/3/12.
//

// https://www.zhihu.com/question/497851000/answer/2249878929

import UIKit

struct BeautifulColor {
    let name: String
    let color: UIColor
    let description: String
    let rgbText: String
}

class BeautifulColorVC: UITableViewController {
    private let colors = [
        BeautifulColor(name: "波尔多红", color: CustomColor.bordeauxRed, description: "深樱桃红，因法国波尔多红酒得名", rgbText: "RGB 76/0/9"),
        BeautifulColor(name: "普鲁士蓝", color: CustomColor.prussianBlue, description: "又称柏林蓝", rgbText: "RGB 0/49/83"),
        BeautifulColor(name: "勃艮第红", color: CustomColor.burgundyRed, description: "因法国出产的勃艮第酒颜色而得名", rgbText: "RGB 128/0/32"),
        BeautifulColor(name: "邦迪蓝", color: CustomColor.bondiBlue, description: "源自澳大利亚邦迪海滩", rgbText: "RGB 0/149/182"),
        BeautifulColor(name: "木乃伊棕", color: CustomColor.mummyBrown, description: "从古老的木乃伊中提炼出的颜色", rgbText: "RGB 143/75/40"),
        BeautifulColor(name: "卡布里蓝", color: CustomColor.capriBlue, description: "来自意大利卡布里岛的蓝洞湖水色", rgbText: "RGB 26/85/153"),
        BeautifulColor(name: "提香红", color: CustomColor.titianRed, description: "来自于精彩描绘金红发的画家提香", rgbText: "RGB 176/89/35"),
        BeautifulColor(name: "蒂芙尼蓝", color: CustomColor.tiffanyBlue, description: "纽约珠宝公司蒂芙尼所拥有的颜色俗称，为较浅的知更鸟淡蓝", rgbText: "RGB 129/216/208"),
        
        BeautifulColor(name: "覆盆子红", color: CustomColor.fupenziRed, description: "", rgbText: "RGB 158/46/36"),
        BeautifulColor(name: "虎皮黄", color: CustomColor.hupiYellow, description: "", rgbText: "RGB 226/175/66"),
        BeautifulColor(name: "薄荷绿", color: CustomColor.mintGreen, description: "", rgbText: "RGB 64/125/82"),
        BeautifulColor(name: "草黄", color: CustomColor.grassYellow, description: "", rgbText: "RGB 207/182/74"),
        BeautifulColor(name: "星蓝", color: CustomColor.starBlue, description: "", rgbText: "RGB 154/180/205"),
        BeautifulColor(name: "鸢尾蓝", color: CustomColor.irisBlue, description: "", rgbText: "RGB 65/138/180"),
        BeautifulColor(name: "苋菜紫", color: CustomColor.amaranthPurple, description: "", rgbText: "RGB 142/41/97"),
        BeautifulColor(name: "钢蓝", color: CustomColor.steelBlue, description: "", rgbText: "RGB 16/20/32"),
        BeautifulColor(name: "云峰白", color: CustomColor.yunfengWhite, description: "", rgbText: "RGB 218/227/230"),
        BeautifulColor(name: "岩石棕", color: CustomColor.rockBrown, description: "", rgbText: "RGB 140/80/44"),
        BeautifulColor(name: "橄榄石绿", color: CustomColor.olivineGreen, description: "", rgbText: "RGB 184/206/142"),
        BeautifulColor(name: "竹绿", color: CustomColor.bambooGreen, description: "", rgbText: "RGB 79/164/133"),
        BeautifulColor(name: "钴蓝", color: CustomColor.cobaltBlue, description: "", rgbText: "RGB 70/146/185"),
        BeautifulColor(name: "月影白", color: CustomColor.moonWhite, description: "", rgbText: "RGB 194/196/195"),
        BeautifulColor(name: "笋皮棕", color: CustomColor.sunpiBrown, description: "", rgbText: "RGB 107/51/26"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Colors"
        tableView.rowHeight = 40
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let model = colors[indexPath.row]
        cell.backgroundColor = model.color
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = model.name
        return cell
    }
}
