//
//  ViewController.swift
//  SpeedTypingTest
//
//  Created by Эл on 24.07.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var timer:Timer?
    var timeLeft = 60
    var errorsCount = 0
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    
    private let labelView : UIView = {
       
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.frame = self.view.bounds
        //view.contentSize = contentViewSize
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    private lazy var containerView : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        //view.frame.size = contentViewSize

        return view
    }()
    
    
    
    
    
    private let textLabel: UILabel = {
        let label = UILabel()
        
        let textArray = ["There are a text, which you must text to get the last character of this label!", "France, officially the French Republic, is a transcontinental country spanning Western Europe and several overseas regions and territories. Its metropolitan area extends from the Rhine to the Atlantic Ocean and from the Mediterranean Sea to the English Channel and the North Sea. Overseas territories include French Guiana in South America and several islands in the Atlantic, Pacific and Indian Oceans. France borders Belgium, Luxembourg, and Germany to the northeast, Switzerland, Monaco and Italy to the east, Andorra and Spain to the south, as well as the Netherlands, Suriname, and Brazil in the Americas. Its eighteen integral regions (five of which are overseas) span a combined area of 643,801 km2 (248,573 sq mi) and over 67 million people (as of May 2021). France is a unitary semi-presidential republic with its capital in Paris, the country's largest city and main cultural and commercial centre; other major urban areas include Lyon, Marseille, Toulouse, Bordeaux, Lille, and Nice. Including its overseas territories, France has twelve time zones, the most of any country.", "Saudi Arabia, officially the Kingdom of Saudi Arabia (KSA), is a country in Western Asia. It spans the vast majority of the Arabian Peninsula, with a land area of approximately 2,150,000 km2 (830,000 sq mi). Saudi Arabia is the largest country in the Middle East, and the second-largest country in the Arab world. It is bordered by Jordan and Iraq to the north, Kuwait to the northeast, Qatar, Bahrain, and the United Arab Emirates to the east, Oman to the southeast and Yemen to the south. It is separated from Egypt and Israel in the north-west by the Gulf of Aqaba. Saudi Arabia is the only country with a coastline along both the Red Sea and the Persian Gulf, and most of its terrain consists of arid desert, lowland, steppe and mountains. Its capital and largest city is Riyadh, with Mecca and Medina serving as important cultural and religious centers.", "England is a country that is part of the United Kingdom. It shares land borders with Wales to its west and Scotland to its north. The Irish Sea lies northwest of England and the Celtic Sea to the southwest. England is separated from continental Europe by the North Sea to the east and the English Channel to the south. The country covers five-eighths of the island of Great Britain, which lies in the North Atlantic, and includes over 100 smaller islands, such as the Isles of Scilly and the Isle of Wight. England's terrain is chiefly low hills and plains, especially in central and southern England. However, there is upland and mountainous terrain in the north (for example, the Lake District and Pennines) and in the west (for example, Dartmoor and the Shropshire Hills). The capital is London, which has the largest metropolitan area in both the United Kingdom and, prior to Brexit, the European Union. England's population of 56.3 million comprises 84% of the population of the United Kingdom, largely concentrated around London."]
        
        let randomText : Int = Int(arc4random_uniform(UInt32(textArray.count)))
        let answer = textArray[randomText]
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = answer
        label.sizeToFit()
        label.textColor = .black
        
        
        
        return label
    }()
    
    private var errorsLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0 Errors"
        label.sizeToFit()
        
        return label
    }()
    
    private let totalCount: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total count:"
        label.sizeToFit()
        
        return label
    }()
    
    private let textField : UITextField = {
        let text = UITextField(frame: CGRect(x: 20, y: 700, width: 300, height: 40))
        
        text.placeholder = "Enter text Here!"
        text.font = UIFont.systemFont(ofSize: 15)
        text.autocorrectionType = UITextAutocorrectionType.no
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.clearButtonMode = UITextField.ViewMode.never
        text.keyboardAppearance = .dark
        text.addTarget(self, action: #selector(checkWrongOrRight(_:)), for: .editingChanged)
        
        return text
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(labelView)
        labelView.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(textLabel)
        view.addSubview(textField)
        view.addSubview(totalCount)
        view.addSubview(errorsLabel)
        textField.delegate = self
        setUpConstraints()
        
        // Do any additional setup after loading the view.
    }
     
    @objc func checkWrongOrRight(_ textField: UITextField) {
        
        
        textLabel.attributedText = displayString(input: textLabel.text, expected: textField.text)
        
        }
        
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      if string.isEmpty {
        return false
      }
        
        return textField.text?.count ?? 0 < textLabel.attributedText?.length ?? 0
    }

    
    func setUpConstraints() {
        
        labelView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        labelView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        labelView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        labelView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600).isActive = true
        
        
        
        scrollView.centerXAnchor.constraint(equalTo: self.labelView.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.labelView.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.labelView.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.labelView.bottomAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        
        textLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        textLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        textLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
        
        
        totalCount.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        totalCount.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        totalCount.topAnchor.constraint(equalTo: self.labelView.bottomAnchor, constant: 50).isActive = true
        
        errorsLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        errorsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        errorsLabel.topAnchor.constraint(equalTo: self.totalCount.bottomAnchor, constant: 50).isActive = true
        
    }
    
    // чтобы получить количество символов в минуту, то для моего приложения нужно будет из общего количества символов вычесть количество ошибок и применить формулу для расчета количества символов в минуту
    
    
    
    func displayString(input: String?, expected: String?) -> NSAttributedString {
        
            guard let input = input,
                  let expected = expected
            else {
                return NSAttributedString(string: "")
            }
            
        let errorRanges = zip((0...), zip(input, expected).map(==)).filter { !$1 }.map { NSRange(location: $0.0, length: 1) }
        let notErrorRanges = zip((0...), zip(input, expected).map(==)).filter { $1 }.map { NSRange(location: $0.0, length: 1) }
        
            let attString = NSMutableAttributedString(string: input, attributes: [.foregroundColor: UIColor.black])
        
        
            notErrorRanges.forEach { notErrorRange in
                attString.addAttribute(.foregroundColor, value: UIColor.green, range: notErrorRange)
                attString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: notErrorRange)
                totalCount.text = "Total count: \(textField.text?.count ?? 0) characters"
                
        }
            
            errorRanges.forEach { range in
                
                attString.addAttribute(.foregroundColor, value: UIColor.red, range: range)
                attString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue, range: range)
                errorsLabel.text = "\(errorsCount) Errors!!!"
                errorsCount += 1
                textField.deleteBackward()
                
                    }
        
            return attString
        }
    
    
    
    

    
    func checkMaxLength(string: String, maxLength: Int) {
        if textField.text?.count ?? 0 >= maxLength {
            textField.deleteBackward()
        }
    }

    
    
}


