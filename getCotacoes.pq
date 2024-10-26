(#"DataInicial" as date, #"DataFinal" as date) as table =>
let
    dataInicial = #"DataInicial", //#date(2024, 10, 1),
    dataFinal =  #"DataFinal", //DateTime.Date(DateTime.LocalNow()),
    moedas = {"USD", "EUR", "JPY", "GBP", "INR"},

    getCotacoes = ( Data as date, Moeda as text) as nullable number =>
    let
        // Data = #date(2024, 10, 14),
        // Moeda = "USD",
        startDateTxt = Date.ToText(Data, "yyyyMMdd"),
        endDateTxt = Date.ToText(Data, "yyyyMMdd"),

        url = "https://economia.awesomeapi.com.br",
        endpoint = "json/daily/" & Moeda,
        query = [
            start_date = startDateTxt,
            end_date = endDateTxt
        ],

        request = Web.Contents (
            url,
            [
                RelativePath = endpoint,
                Query = query
            ]
        ),

        response = try Number.From(Json.Document(request, 65001){0}[bid], "en-US") otherwise null
    in
        response,

    getCotacoesPorMoeda = (dataInicial, dataFinal, moeda) =>
        let
            geraDados = List.Generate(
                () => [ 
                    Data = dataInicial, 
                    Cotacao = getCotacoes(Data, moeda), 
                    Moeda = moeda 
                ],
                each [Data] <= dataFinal,
                each [ 
                    Data = Date.AddDays([Data], 1), 
                    Cotacao = getCotacoes(Data, moeda),
                    Moeda = moeda
                ]
            ),
            saida = Table.FromRecords(geraDados),
            preenchidoAbaixo = Table.FillDown(saida,{"Cotacao"}),
            tipoAlterado = Table.TransformColumnTypes(
                preenchidoAbaixo,{
                    {"Data", type date}, 
                    {"Cotacao", Currency.Type}, 
                    {"Moeda", type text}
                }
            )
        in
            tipoAlterado,
            

    saida = Table.Combine(
        List.Transform(moedas, each getCotacoesPorMoeda(dataInicial, dataFinal, _))
    )
in
    saida