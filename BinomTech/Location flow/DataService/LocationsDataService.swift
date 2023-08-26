import Foundation
import MapKit

///mock data hard code
class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "Плотинка",
            cityName: "Екатеринбург",
            coordinates: CLLocationCoordinate2D(latitude: 56.8383, longitude: 60.6036),
            description: "Плоти́на Городско́го пруда́ на реке́ Исе́ть — плотина, расположенная на реке Исеть в Историческом сквере Екатеринбурга. Построена в 1723 году, впоследствии многократно перестраивалась. Жители города называют её «Плотинка». Традиционное место массовых народных гуляний и праздников.",
            imageNames: [
                "ekb-dam-1",
                "ekb-dam-2",
                "ekb-dam-3",
            ]),
        Location(
            name: "Администрация",
            cityName: "Екатеринбург",
            coordinates: CLLocationCoordinate2D(latitude: 56.837173462, longitude: 60.597740173),
            description: "Здание Свердловского городского Совета народных депутатов — памятник архитектуры Екатеринбурга (регионального значения), административное здание, расположенное на Площади 1905 года (Проспект Ленина, 24 а). На 2023 год в здании размещаются Администрация города Екатеринбурга и Екатеринбургская городская Дума.",
            imageNames: [
                "ekb-administation-1",
                "ekb-administation-2",
                "ekb-administation-3",
            ]),
        Location(
            name: "Театр оперы и балета",
            cityName: "Екатеринбург",
            coordinates: CLLocationCoordinate2D(latitude: 56.838871002, longitude: 60.616722107),
            description: "Екатеринбýргский госудáрственный академи́ческий теáтр óперы и бале́та — стационарный театр оперы и балета в Екатеринбурге, основанный в 1912 году. Здание построено по проекту инженера В. Н. Семёнова.",
            imageNames: [
                "ekb-theater-1",
                "ekb-theater-2",
                "ekb-theater-3",
            ])
        
    ]
    
}
