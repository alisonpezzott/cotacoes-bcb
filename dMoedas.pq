let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("hZFBTsMwEEWvYjksQ5V9V22TUmgFVaosUNrFkFiVhbGFXV+Aq1SIDay4QXITTsIYS7VpEV3N+M/7tmemrum4XNCUlgwEedBguGBcK6dckCRNkmyQZcM4v6SbtKajKkcm7z8FaALW7DQIDtIZI/bENhlFtgYktEwads40myIx1SAbRYztP/o3984apcGaBvpE8PZ8Pkd6orQC0nIJT6CfLTOA4qMOcJx7Y1GVyBT2ZxxfL++h/uvg4avxEqkFxxmSwuyYFvgUKt3+AHb7Y9PN8h6RaybdCLpXXx4eEg/d3oX/S6Ut2/75+6OrV0VwGcua8+1Wq2g3rTKuDXCxkhzDf0vafAM=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Moeda = _t, Nome = _t, Formatacao = _t])
in
    Source
