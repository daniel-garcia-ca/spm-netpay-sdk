**Integración de el SDK de NetPay IOS a tu aplicación de Custom Checkout por medio del gestor de paquetes de Swift (SPM).**
<br/><br/>
<h2>1.Requerimientos</h2>
<ul>
    <li>Netpay API public key.</li>
    <li>iOS 8 o un target de implementación superior.</li>
    <li>Xcode 12.2 o superior.</li>
    <li>Swift 5.0 o superior (Swift 5.1)</li>
</ul>
<h2>2.Integración de SPM</h2>
<p>Para realizar la integración debe de dirigirse al menu <b>File>Swift Packages>Add Package</b>, después se mostrará una ventana donde se deberá de pegar el siguiente link para buscar el SPM con las librerías de NetPaySDK.</p>
<br/>
<ul><li>https://github.com/netpaymx/spm-netpay-sdk</li></ul>
<p>Posterior se tiene que seleccionar la versión  que se desea integrar, finalmente se muestra la lista de dependencias para agregar, se deberán de seleccionar las tres que se muestran.</p>
<ul>
    <li>NetPaySDK</li>
    <li>TMXProfiling</li>
    <li>TMXProfilingConnections</li>
</ul>
<h2>3. Construcción de formulario de cobro.</h2>
<p>NetPay iOS SDK proporciona formularios de interfaz de usuario fáciles de usar tanto para tokenizar una tarjeta de crédito como para crear una fuente de pago que se pueda integrar fácilmente en su aplicación.</p>
<h3>3.1 Uso de formulario de tarjeta.</h3>
<p>Para usar el controlador en su aplicación, modifique su controlador de vista con las siguientes adiciones:</p>
<ul>
    <li>Asignar llave pública (public key)</li>
</ul>

    private let publicKey = "pk_netpay_kSjXddOJMPuxfqEsEICyIOKUs"
    private let testMode = true

<ul>
    <li>Inicializar al cliente</li>
</ul>

    override func viewDidLoad() {
            super.viewDidLoad()
    
            let client = Client(publicKey: publicKey, testMode: testMode)
            client.capabilityDataWithCompletionHandler { (result) in
                if case .success(let capability) = result {
                    self.capability = capability
                }
            }
     }

<ul>
    <li>Asignar el identificador</li>
</ul>

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            if identifier == "PresentCreditFormWithModal" ||
                identifier == "ShowCreditForm" {
                return currentCodePathMode == .storyboard
            }
    
            return true
        }

<ul>
    <li>Asignar la llave pública y testMode al controlador del formulario de pago</li>
</ul>

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
    
            if segue.identifier == "PresentCreditFormWithModal",
                let creditCardFormNavigationController = segue.destination as? UINavigationController,
                let creditCardFormController = creditCardFormNavigationController.topViewController as? CreditCardFormViewController {
                creditCardFormController.publicKey = publicKey
                creditCardFormController.testMode = testMode
                creditCardFormController.handleErrors = true
                creditCardFormController.delegate = self
            } else if segue.identifier == "ShowCreditForm",
                let creditCardFormController = segue.destination as? CreditCardFormViewController {
                creditCardFormController.publicKey = publicKey
                creditCardFormController.testMode = testMode
                creditCardFormController.handleErrors = true
                creditCardFormController.delegate = self
            }
        }

<ul>
    <li>Crear modal de formulario</li>
</ul>


    Public
    import UIKit
    import NetPaySDK
        @IBAction func showModalCreditCardForm(_ sender: Any) {
            guard currentCodePathMode == .code else {
                return
            }
            let creditCardFormController = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: publicKey)
            creditCardFormController.handleErrors = true
            creditCardFormController.delegate = self
            let navigationController = UINavigationController(rootViewController: creditCardFormController)
            present(navigationController, animated: true, completion: nil)
        }

<ul>
    <li>Crear formulario push</li>
</ul>


    import UIKit
    import NetPaySDK
        @IBAction func showCreditCardForm(_ sender: UIButton) {
            guard currentCodePathMode == .code else {
                return
            }
            let creditCardFormController = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: publicKey)
            creditCardFormController.handleErrors = true
            creditCardFormController.delegate = self
            show(creditCardFormController, sender: self)
        }

<ul>
    <li>Delegate para View Controller del formulario de tarjeta</li>
</ul>



    extension ViewController: CreditCardFormViewControllerDelegate {
        func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
            dismissForm()
        }
        //Success
        func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
            dismissForm(completion: {
                let alertController = UIAlertController(
                    title: "Token Creado",
                    message: "El token: \(token.token) fué creado satisfactoriamente. Por favor envía el token a tu back-end para realizar el checkout.",
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
        //Error
        func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
            dismissForm(completion: {
                let alertController = UIAlertController(
                    title: "Error",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            })
        }
    }
