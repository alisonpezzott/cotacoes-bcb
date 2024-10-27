let
    moedas = Table.Buffer(dMoedas[[Moeda]]),

    addDatas = Table.AddColumn(
        moedas,
        "Datas",
        each Table.FromList(
            List.Dates(
                dataInicial,
                Duration.Days(dataFinal-dataInicial)+1,
                #duration(1, 0, 0, 0)
            ),
            Splitter.SplitByNothing(),
            type table [ Data = date ]
        ),
        type table [ Data = date ]
    ),

    addCotacoes = Table.AddColumn(
        addDatas,
        "Cotacoes",
        each getCotacoesPaginacao(
            dataInicial,
            dataFinal,
            [Moeda]
        ),
        type table [ DataCotacao = date, Cotacao = Currency.Type ]
    ),

    addJoin = Table.AddColumn(
        addCotacoes, 
        "Join", each Table.Join(
            [Datas], "Data", 
            [Cotacoes], "DataCotacao", 
            JoinKind.LeftOuter
        ),
        type table [ Data = date, DataCotacao = date, Cotacao = Currency.Type ]
    ), 

    colunasSelecionadas = addJoin[[Moeda],[Join]],
    
    tratamentoColunas = Table.TransformColumns(
        colunasSelecionadas, {
            {
                "Join",
                each Table.FillDown(Table.Sort(_[[Data],[Cotacao]], {"Data", Order.Ascending}), {"Cotacao"}),
                type table [Data=date, Cotacao = Currency.Type]
            }
        }
    ),

    expJoin = Table.ExpandTableColumn(
        tratamentoColunas, 
        "Join", 
        {"Data", "Cotacao"}
    )
in
    expJoin
