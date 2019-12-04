# Sign In With Apple

##### Why ‘Sign in with Apple’?

  - In one word- privacy. 
  - ‘Sign in with Apple’ is a fast, easy way to sign in, without all the tracking, said Craig Federighi, Apple’s software engineering chief, probably taking a dig at Apple’s competitors. The only data that is collected is the user’s name and email address. The user can even choose to hide their email address in the app.

# Steps to integrate ‘Sign in with Apple’ feature in your iOS app

##### STEP 1– Create a New Project in Xcode
  - File > New > Project > Enter required details and select language to swift
  ![Screenshot 2019-12-04 at 10.57.28 AM.png](https://www.dropbox.com/s/nefkfhtk1gelc2t/Screenshot%202019-12-04%20at%2010.57.28%20AM.png?dl=0&raw=1)

  
##### STEP 2– Go to “Target” and click on “Capability”
  - Select your project > Signin & Capabilities > Target 
  
  ![Screenshot 2019-12-04 at 10.57.49 AM.png](https://www.dropbox.com/s/gpit5h14ri9t4zx/Screenshot%202019-12-04%20at%2010.57.49%20AM.png?dl=0&raw=1)

##### STEP 3– Add the “Sign in with Apple” Capability in your project
  - click on +Capability > Select Sign in with apple
  

![Screenshot 2019-12-04 at 10.58.39 AM.png](https://www.dropbox.com/s/v7u4ajg76yve3or/Screenshot%202019-12-04%20at%2010.58.39%20AM.png?dl=0&raw=1)

##### STEP 4 – Go to the “ViewController.swift” and Import ASAuthenticationServices framework (framework for “Sign In with Apple”)
```import AuthenticationServices```
above import provide us ASAuthorizationAppleID button

##### STEP 5– Add the “Sign in with Apple” button in ViewController after adding the target for TouchUpInside action and add action to the login button click.

```
override func viewDidLoad() {
        super.viewDidLoad()     
        // Do any additional setup after loading the view.
        self.setupSOAppleSignIn()
    }

       func setupSOAppleSignIn() {
       
        let btnAuthorization = ASAuthorizationAppleIDButton()
        btnAuthorization.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        btnAuthorization.center = self.view.center
        btnAuthorization.addTarget(self, action: #selector(actionHandleAppleSignin), for: .touchUpInside)
        self.view.addSubview(btnAuthorization)
    }

@objc func actionHandleAppleSignin() {

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
```

##### STEP 6 – Handle ASAuthorizationController Delegate and Presentation Context for success / failure response.


```
extension ViewController: ASAuthorizationControllerDelegate {

     // ASAuthorizationControllerDelegate function for authorization failed
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }

       // ASAuthorizationControllerDelegate function for successful authorization

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account as per your requirement
            let appleId = appleIDCredential.user
            let appleUserFirstName = appleIDCredential.fullName?.givenName
            let appleUserLastName = appleIDCredential.fullName?.familyName
            let appleUserEmail = appleIDCredential.email
            //Write your code

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {

            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            //Write your code

        }
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {

    //For present window
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
```
##### STEP 7– You need to enable Sign in with Apple in your developer account.
Go to  “Certificates, Identifiers & Profile” section and then click on the “Keys” option.

![Screenshot 2019-12-04 at 10.47.42 AM.png](https://www.dropbox.com/s/js3mxscl50zf9dr/Screenshot%202019-12-04%20at%2010.47.42%20AM.png?dl=0&raw=1)


Click on “Create a key” option. Enter the name of the key and enable the “Sign in with Apple” option

![register-a-new-key.png](https://www.dropbox.com/s/kk1svwaxh5phhir/register-a-new-key.png?dl=0&raw=1)

###### (Note : This feature is supported in iOS 13 or later only)
