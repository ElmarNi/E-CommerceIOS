//
//  ProfileViewModel.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 01.02.24.
//

import Foundation

final class ProfileViewModel {
    private let policyTexts: KeyValuePairs<String, [String]> =
    [
        "Our Policy":
            [
                "At QuickMart, we are committed to protecting the privacy and security of our users' personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard the information obtained through our e-commerce app. By using QuickMart, you consent to the practices described in this policy."
            ],
        "1. Information Collection:":
            [
                " - Personal Information: We may collect personal information such as name, address, email, and phone number when you create an account, make a purchase, or interact with our services.",
                " - Transaction Details: We collect information related to your purchases, including order history, payment method, and shipping details.",
                " - Usage Data: We may collect data on how you interact with our app, such as browsing activity, search queries, and preferences."
            ],
        "2. Information Use:":
            [
                " - Provide Services: We use the collected information to process orders, deliver products, and provide customer support.",
                " - Personalization: We may use your information to personalize your shopping experience, recommend products, and display targeted advertisements.",
                " - Communication: We may use your contact information to send important updates, promotional offers, and newsletters. You can opt-out of these communications at any time."
            ],
        "3. Information Sharing:":
            [
                " - Third-Party Service Providers: We may share your information with trusted third-party service providers who assist us in operating our app, fulfilling orders, and improving our services.",
                " - Legal Compliance: We may disclose personal information if required by law or in response to a valid legal request from authorities."
            ],
        "4. Data Security:":
            [
                " - We implement appropriate security measures to protect your information from unauthorized access, alteration, disclosure, or destruction.",
                " - However, please note that no data transmission over the internet or electronic storage is 100% secure. We cannot guarantee absolute security of your information."
            ],
        "5. User Rights:":
            [
                " - Access and Update: You have the right to access, correct, or update your personal information stored in our app.",
                " - Data Retention: We retain your personal information as long as necessary to provide our services and comply with legal obligations."
            ],
        "6. Children's Privacy:":
            [
                " - QuickMart is not intended for children under the age of 13. We do not knowingly collect or solicit personal information from children."
            ],
        "7. Updates to the Privacy Policy:":
            [
                "   - We reserve the right to update this Privacy Policy from time to time. Any changes will be posted on our app, and the revised policy will be effective upon posting."
            ],
        "":
            [
                "If you have any questions or concerns about our Privacy Policy, please contact our customer support. By using QuickMart, you acknowledge that you have read and understood this Privacy Policy and agree to its terms and conditions."
            ]
    ]
    
    private let termsTexts: KeyValuePairs<String, [String]> =
    [
        "Terms & Conditions":
            [
                "Welcome to QuickMart! These Terms and Conditions (\"Terms\") govern your use of our e-commerce app. By accessing or using QuickMart, you agree to be bound by these Terms. Please read them carefully before proceeding."
            ],
        "1. Account Registration":
            [
                " - You must create an account to use certain features of QuickMart.",
                " - You are responsible for providing accurate and up-to-date information during the registration process.",
                " - You must safeguard your account credentials and notify us immediately of any unauthorized access or use of your account."
            ],
        "2. Product Information and Pricing":
            [
                " - QuickMart strives to provide accurate product descriptions, images, and pricing information.",
                " - We reserve the right to modify product details and prices without prior notice.",
                " - In the event of an error, we may cancel or refuse orders placed for incorrectly priced products."
            ],
        "3. Order Placement and Fulfillment":
            [
                " - By placing an order on QuickMart, you agree to purchase the selected products at the stated price.",
                " - We reserve the right to accept or reject any order, and we may cancel orders due to product unavailability, pricing errors, or suspected fraudulent activity.",
                " - Once an order is confirmed, we will make reasonable efforts to fulfill and deliver it in a timely manner."
            ],
        "4. Payment":
            [
                " - QuickMart supports various payment methods, including credit/debit cards and online payment platforms.",
                " - By providing payment information, you represent and warrant that you are authorized to use the chosen payment method.",
                " - All payments are subject to verification and approval by relevant financial institutions."
            ],
        "5. Shipping and Delivery":
            [
                " - QuickMart will make reasonable efforts to ensure timely delivery of products.",
                " - Shipping times may vary based on factors beyond our control, such as location, weather conditions, or carrier delays.",
                " - Risk of loss or damage to products passes to you upon delivery."
            ],
        "6. Returns and Refunds":
            [
                " - QuickMart's return and refund policies are outlined separately and govern the process for returning products and seeking refunds.",
                " - Certain products may be non-returnable or subject to specific conditions."
            ],
        "7. Intellectual Property":
            [
                " - QuickMart and its content, including logos, trademarks, text, images, and software, are protected by intellectual property rights.",
                " - You may not use, reproduce, modify, distribute, or display any part of QuickMart without our prior written consent."
            ],
        "8. User Conduct":
            [
                " - You agree to use QuickMart in compliance with applicable laws and regulations.",
                " - You will not engage in any activity that disrupts or interferes with the functioning of QuickMart or infringes upon the rights of others.",
                " - Any unauthorized use or attempt to access restricted areas or user accounts is strictly prohibited."
            ],
        "9. Limitation of Liability":
            [
                " - QuickMart and its affiliates shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising from the use or inability to use our app or any products purchased through it.",
                " - We do not guarantee the accuracy, completeness, or reliability of information provided on QuickMart."
            ],
        "10. Governing Law":
            [
                "    - These Terms shall be governed by and construed in accordance with the laws of [Jurisdiction].",
                "    - Any disputes arising out of or relating to these Terms shall be resolved in the courts of [Jurisdiction]."
            ],
        "": [
            "If you have any questions or concerns regarding these Terms and Conditions, please contact our customer support. By using QuickMart, you acknowledge that you have read, understood, and agreed to these Terms and Conditions."
        ]
    ]
    
    private let faqTexts: KeyValuePairs<String, [String]> =
    [
        "Can I cancel my order?":
            [
                "Yes, only if the order is not dispatched yet. You can contact our customer service department to get your order canceled."
            ],
        
        "Will I receive the same product I see in the photo?":
            [
                "Actual product color may vary from the images shown. Every monitor or mobile display has a different capability to display colors, and every individual may see these colors differently. In addition, lighting conditions at the time the photo was taken can also affect an image's color."
            ],
        
        "How can I recover the forgotten password?":
            [
                "If you have forgotten your password, you can recover it from the 'Login - Forgotten your password?' section. You will receive an e-mail with a link to enter and confirm your new password."
            ],
        
        "Is my personal information confidential?":
            [
                "Your personal information is confidential. We do not rent, sell, barter, or trade email addresses. When you place an order with us, we collect your name, address, telephone number, credit card information, and your email address. We use this information to fulfill your order and to communicate with you about your order. All your information is kept confidential and will not be disclosed to anybody unless ordered by government authorities."
            ],
        
        "What payment methods can I use to make purchases?":
            [
                "We offer the following payment methods: PayPal, VISA, MasterCard, and Voucher code, if applicable."
            ]
    ]
    
    enum Section {
        case personalInformation(data: [String])
        case supportAndInformation(data: KeyValuePairs<String, KeyValuePairs<String, [String]>>)
        case accountManagment(data: [String])
        
        var title: String {
            switch self {
            case .personalInformation:
                return "Personal Information"
            case .supportAndInformation:
                return "Support & Information"
            case .accountManagment:
                return "Account Management"
            }
        }
    }
    var sections = [Section]()
    
    init() {
        sections.append(.personalInformation(data: ["Shipping Address", "Payment Method"]))
        sections.append(.supportAndInformation(data: ["Privacy Policy": policyTexts, "Terms & Conditions": termsTexts, "FAQs": faqTexts]))
        sections.append(.accountManagment(data: ["Change Password"]))
    }
    
    var user: User? = nil
    
    func user(sessionDelegate: URLSessionDelegate?, userID: Int, completion: @escaping (_ isError: Bool, _ errorString: String?) -> Void) {
        DispatchQueue.main.async {[weak self] in
            NetworkManager.shared.request(sessionDelegate: sessionDelegate,
                                          requestBody: nil,
                                          type: User.self,
                                          url: "users/\(userID)",
                                          method: .GET)
            { response in
                switch response {
                case .success(let result):
                    self?.user = result
                    completion(false, nil)
                default:
                    completion(true, "Can't get user")
                }
            }
        }
    }
    
}
