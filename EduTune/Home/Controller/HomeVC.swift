//
//  HomeVC.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 12/10/22.
//

import UIKit
import SafariServices

class HomeVC: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var bannerCV: UICollectionView!
    @IBOutlet weak var mentorsCV: UICollectionView!
    @IBOutlet weak var categoryCV: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notificationButton: UIButton!

    var homeData: HomeData?
    var categories = [String]()
    var categorySelected = "All"
    var allClasses = [Class]()
    
    var isLoggedIn = AppUserDefault.getIsLoggedIn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        bannerCV.delegate = self
        bannerCV.dataSource = self
        
        mentorsCV.delegate = self
        mentorsCV.dataSource = self
        
        categoryCV.delegate = self
        categoryCV.dataSource = self
        
        notificationButton.isHidden = !AppUserDefault.getIsLoggedIn()
        userImageView.sd_setImage(with: URL(string: AppUserDefault.getPicture() ?? "" ), placeholderImage: UIImage(named: "ic_user_blue"))
        statusLabel.text = getStatusText()
        welcomeLabel.text = AppUserDefault.getName() != nil ? "Welcome \(AppUserDefault.getName()!.components(separatedBy: " ")[0])" : "Welcome to EduTune"

        updateUI()
    }
    
    func getHomeData() {
        var params = [String: Any]()
        if AppUserDefault.getIsLoggedIn() {
            params["user_id"] = AppUserDefault.getUserId()
        }
        
        APIService.shared.getHomeData(params: params, completion: { homeData in
            if let homeData = homeData {
                self.homeData = homeData
                self.categories = homeData.program_wise_course.map({ $0.program_name ?? "" }).unique()
                
                self.categories.insert("All", at: 0)
                
                self.bannerCV.reloadData()
                self.mentorsCV.reloadData()
                self.categoryCV.reloadData()
                self.filterPrograms()
            }
        })
    }
    
    func filterPrograms() {
        self.allClasses.removeAll()
        for program in homeData?.program_wise_course ?? [] {
            self.allClasses.append(contentsOf: program.getClasses)
        }
        
        if categorySelected != "All" {
            self.allClasses = self.allClasses.filter({ $0.program_name == categorySelected })
        }
        self.tableView.reloadData()
        
    }
    
    func updateUI() {
        notificationButton.isHidden = !AppUserDefault.getIsLoggedIn()
        userImageView.sd_setImage(with: URL(string: AppUserDefault.getPicture() ?? "" ), placeholderImage: UIImage(named: "ic_user_blue"))
        statusLabel.text = getStatusText()
        welcomeLabel.text = AppUserDefault.getName() != nil ? "Welcome \(AppUserDefault.getName()!.components(separatedBy: " ")[0])" : "Welcome to EduTune"
       
        getHomeData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
       
        if isLoggedIn != AppUserDefault.getIsLoggedIn() {
            isLoggedIn = AppUserDefault.getIsLoggedIn()
            
            updateUI()

        }
    }
    
    func getStatusText() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        var timeString = ""
        if hour >= 0 && hour <= 11 {
            timeString = "morning"
        } else if hour > 11 && hour <= 17 {
            timeString = "day"
        } else if hour > 17 && hour <= 22 {
            timeString = "evening"
        } else {
            timeString = "night"
        }
        return "Good \(timeString)"
    }
    
    @IBAction func mentorsSeeAllButtonTap(_ sender: Any) {
        if let viewC: TopMentorsVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "TopMentorsVC") as? TopMentorsVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    @IBAction func popularCoursesSeeAllButtonTap(_ sender: Any) {
        if let viewC: MostPopularCoursesVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "MostPopularCoursesVC") as? MostPopularCoursesVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
    @IBAction func onProfileButtonTap(_ sender: Any) {
        if AppUserDefault.getIsLoggedIn() {
            
        } else {
            if let viewC: LetsInVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "LetsInVC") as? LetsInVC {
                self.navigationController?.pushViewController(viewC, animated: true)
            }
        }
    }
    
    @IBAction func onNotificationButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func onSearchButtonTap(_ sender: Any) {
        if let viewC: SearchVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC {
            self.navigationController?.pushViewController(viewC, animated: true)
        }
    }
    
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCV {
            return homeData?.popup_advertisements_v2.count ?? 0
        } else if collectionView == mentorsCV {
            return homeData?.top_educators.count ?? 0
        } else if collectionView == categoryCV {
            return categories.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannerCV {
            guard let cell: BannerCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCVCell", for: indexPath) as? BannerCVCell else {return UICollectionViewCell()}
            cell.advertisement = homeData?.popup_advertisements_v2[indexPath.item]
            return cell
            
        } else if collectionView == mentorsCV {
            guard let cell: MentorCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MentorCVCell", for: indexPath) as? MentorCVCell else {return UICollectionViewCell()}
            cell.teacher = homeData?.top_educators[indexPath.item]
            return cell
        } else if collectionView == categoryCV {
            guard let cell: CategoryCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCVCell", for: indexPath) as? CategoryCVCell else {return UICollectionViewCell()}
            let category = categories[indexPath.item]
            cell.configure(with: category, selected: categorySelected == category, height: 38)
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == bannerCV {
            return CGSize(width: ScreenSize.SCREEN_WIDTH-32, height: (ScreenSize.SCREEN_WIDTH-32)*(3/2))
        } else if collectionView == mentorsCV {
            return CGSize(width: 72, height: 102)
        } else if collectionView == categoryCV {
            var textWidth: CGFloat = 0.0
            let text = categories[indexPath.item]
            textWidth = text.widthWithConstrainedHeight(height: 38, font: UIFont.urbanist(style: .semiBold, ofSize: 16)) + 32
            return CGSize(width: textWidth, height: 38)
        }
        
        return CGSize(width: 0, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == bannerCV {
            let safariVC = SFSafariViewController(url: URL(string: homeData?.popup_advertisements_v2[indexPath.item].url ?? "")!)
            self.present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self
        } else if collectionView == mentorsCV {
            AppDelegate.shared().openMentorProfileVC(navigationController: self.navigationController, mentor: homeData!.top_educators[indexPath.item])
        } else if collectionView == categoryCV {
            categorySelected = categories[indexPath.item]
            categoryCV.reloadData()
            filterPrograms()
        }
        
    }
    
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return min(allClasses.count, 3)
        }else if section == 1 {
            return AppUserDefault.getIsLoggedIn() ? 0 : 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ClassTVCell") as? ClassTVCell else {return UITableViewCell()}
            
            let classData = allClasses[indexPath.row]
            cell.classData = classData
            return cell
        } else if indexPath.section == 1 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "LoginTVCell") as? LoginTVCell else {return UITableViewCell()}
            return cell
        } else if indexPath.section == 2 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "HomeHelpCell") as? HomeHelpCell else {return UITableViewCell()}
            cell.institution = homeData?.institution
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let params = ["class_id": allClasses[indexPath.row].id ?? -1]
            APIService.shared.getCourseDetails(params: params, completion: { clsDetail in
                if let viewC: ClassDetailsVC = UIStoryboard(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "ClassDetailsVC") as? ClassDetailsVC {
                    viewC.classDetail = clsDetail
                    self.navigationController?.pushViewController(viewC, animated: true)
                }
            })
        }
    }
    
}

extension HomeVC: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
