(dataInicial as date, dataFinal as date, moeda as text, optional pagina as nullable number) =>
let
    get = List.Generate(
        ()=> [ pagina = 1, cotacao = try getCotacoes(dataInicial, dataFinal, moeda, 1) otherwise null ],
        each [cotacao] <> null,
        each [ pagina = [pagina] + 1, cotacao = try getCotacoes(dataInicial, dataFinal, moeda, pagina) otherwise null ],
        each [cotacao]
    ),
    output = Table.Combine(get)
in
    output
