import Foundation

extension Date {
    
    /// получение актуальной даты с таймзоной
    func localDate() -> Date {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: Date()))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: Date()) else {return Date()}
        
        return localDate
    }
    
    
    /// конвертирование из String в Date
    func convertStringToDate(dataString: String) -> Date {
        
        let timeZoneOffset = (Double(TimeZone.current.secondsFromGMT(for: Date()))) / 3600
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC + \(timeZoneOffset)")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return formatter.date(from: dataString)!
    }
    
    
    /// конвертирование из Date в String
    func convertDateToString(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC)")
        formatter.dateFormat = "dd.MM.yyyy' / 'HH:mm:ss"
        let dataString = formatter.string(from: date)
        return dataString
    }
    
    
    
    /// расчет между 2 датами
    func calculateBetweenDate(startDate: Date, endDate: Date) -> Int {
        
        let secStart = startDate.secondsSince1970
        let secEnd = endDate.secondsSince1970
        
        return Int(((secEnd - secStart) / 60.0 / 60.0 / 24.0).rounded())
    }
    
    /// даты проведения / тайминг
    func getRangeStringTwoDate(startDate: String, endDate: String) -> String {
        
        let dateFormatterForView = DateFormatter()
        dateFormatterForView.timeZone = TimeZone(identifier: "UTC")
        dateFormatterForView.dateFormat = "dd.MM/HH:mm"
        let startDate = Date().convertStringToDate(dataString: startDate)
        let finishDate = Date().convertStringToDate(dataString: endDate)
        let startDateSting = dateFormatterForView.string(from: startDate)
        let finishDateSting = dateFormatterForView.string(from: finishDate)
        
        return startDateSting + " – " + finishDateSting
    }
    
}

extension Date {
    var secondsSince1970: Double {
        return self.timeIntervalSince1970.rounded()
    }
    
    init(seconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(seconds) / 10)
    }
}

