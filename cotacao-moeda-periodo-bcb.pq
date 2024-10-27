(dataInicial as date, dataFinal as date, moeda as text, pagina as number ) =>

let
    // https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoMoedaPeriodo(moeda=@moeda,dataInicial=@dataInicial,dataFinalCotacao=@dataFinalCotacao)?@moeda='EUR'&@dataInicial='01-01-2024'&@dataFinalCotacao='10-27-2024'&$top=100&$skip=0&$format=json&$select=cotacaoCompra,dataHoraCotacao,tipoBoletim

    dataInicialTxt = "'" & Date.ToText(dataInicial, "MM-dd-yyyy") & "'",
    dataFinalTxt = "'" & Date.ToText(dataFinal, "MM-dd-yyyy") & "'",
    moeda = "'" & moeda & "'",
 
    url = "https://olinda.bcb.gov.br/olinda",
    endpoint = "servico/PTAX/versao/v1/odata/CotacaoMoedaPeriodo(moeda=@moeda,dataInicial=@dataInicial,dataFinalCotacao=@dataFinalCotacao)",

    query = [
        #"@moeda" = moeda,
        #"@dataInicial" = dataInicialTxt,
        #"@dataFinalCotacao" = dataFinalTxt,
        #"$top" = Number.ToText(100),
        #"$skip" = Number.ToText((pagina - 1) * 100),
        #"$format" = "json",
        #"$select" = "cotacaoCompra,dataHoraCotacao,tipoBoletim"
    ],

    request = Web.Contents(
        url,
        [
            RelativePath = endpoint,
            Query = query
        ]
    ),

    response = Json.Document(request, 65001),
    lista = response[value],
    tabela = Table.FromRecords(lista),
    apenasFechamento = Table.SelectRows(tabela, each ([tipoBoletim] = "Fechamento"))[[cotacaoCompra], [dataHoraCotacao]],
    colunasFormatadas = Table.TransformColumns(apenasFechamento,{{"dataHoraCotacao", each DateTime.Date(DateTime.From(_)), type date}, {"cotacaoCompra", Number.From, Currency.Type}})
in
    colunasFormatadas
