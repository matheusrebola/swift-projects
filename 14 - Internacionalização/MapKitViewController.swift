import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Coordenadas do local
        let latitude: CLLocationDegrees = -29.9948  // Exemplo: São Paulo, Brasil
        let longitude: CLLocationDegrees = -50.2025
        
        // Configurar o Pin
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        pin.title = "Parque Eólico de Osório"
        pin.subtitle = "Energia limpa e renovável"
        
        // Adicionar o Pin ao Mapa
        mapView.addAnnotation(pin)
        
        // Aproximar o Mapa
        let region = MKCoordinateRegion(
            center: pin.coordinate,
            latitudinalMeters: 200,  // Aproximação de 200 metros
            longitudinalMeters: 200
        )
        mapView.setRegion(region, animated: true)
    }
}
