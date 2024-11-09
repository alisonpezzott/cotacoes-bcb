let
    Source = 
        "Moeda|Nome|Formatacao
        BRL|Real brasileiro|R$ #,##0.00;R$ #,##0.00;-
        AUD|Dólar australiano|$ #,##0.00;$ #,##0.00;-
        CAD|Dólar canadense|$ #,##0.00;$ #,##0.00;-
        CHF|Franco suíço|Fr #,##0.00;Fr #,##0.00;-
        DKK|Coroa dinamarquesa|kr #,##0.00;kr #,##0.00;-
        EUR|Euro|€ #,##0.00;€ #,##0.00;-
        GBP|Libra Esterlina|£ #,##0.00;£ #,##0.00;-
        JPY|Iene|¥ #,##0;¥ #,##0;-
        NOK|Coroa norueguesa|kr #,##0.00;kr #,##0.00;-
        SEK|Coroa sueca|kr #,##0.00;kr #,##0.00;-
        USD|Dólar dos Estados Unidos|$ #,##0.00;$ #,##0.00;-",
    csv = Table.PromoteHeaders(Csv.Document(Source, 3, "|"))
in
    csv
