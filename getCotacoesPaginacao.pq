(dataInicial as date, dataFinal as date, moeda as text) as table =>
let
    
    get = List.Generate(
        ( ) => [ pagina = 1, cotacao = try getCotacoes(dataInicial, dataFinal, moeda, pagina) otherwise null ],
            each [cotacao] <> null,
            each [ pagina = [pagina] + 1, cotacao = try getCotacoes( dataInicial, dataFinal, moeda, pagina ) otherwise null],
            each [cotacao]
    ),
    
    output = Table.Combine(get)    
in
    output
