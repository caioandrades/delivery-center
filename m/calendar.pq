let
    Origem =  List.Dates(#date(2022, 1, 1), 730, #duration(1, 0, 0, 0)),
    #"Convertido em Tabela" = Table.FromList(Origem, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Colunas com Nome Mudado" = Table.RenameColumns(#"Convertido em Tabela", {{"Column1", "Data"}}),
    #"Tipo Alterado" = Table.TransformColumnTypes(#"Colunas com Nome Mudado", {{"Data", type date}}),
    #"Ano Inserido" = Table.AddColumn(#"Tipo Alterado", "Ano", each Date.Year([Data]), Int64.Type),
    #"Mês Inserido" = Table.AddColumn(#"Ano Inserido", "Mês", each Date.Month([Data]), Int64.Type),
    #"Nome do Mês Inserido" = Table.AddColumn(#"Mês Inserido", "Nome do Mês", each Date.MonthName([Data]), type text),
    #"Semana do Mês Inserida" = Table.AddColumn(
        #"Nome do Mês Inserido", "Semana do Mês", each Date.WeekOfMonth([Data]), Int64.Type
    ),
    #"Prefixo Inserido" = Table.AddColumn(
        #"Semana do Mês Inserida", "Prefixo", each "W" & Text.From([Semana do Mês], "pt-PT"), type text
    ),
    #"Colunas com Nome Mudado1" = Table.RenameColumns(#"Prefixo Inserido", {{"Prefixo", "Semana"}}),
    #"Semana do Ano Inserida" = Table.AddColumn(
        #"Colunas com Nome Mudado1", "Semana do Ano", each Date.WeekOfYear([Data]), Int64.Type
    ),
    #"Prefixo Inserido1" = Table.AddColumn(
        #"Semana do Ano Inserida", "Prefixo", each "W" & Text.From([Semana do Ano], "pt-PT"), type text
    ),
    #"Colunas com Nome Mudado2" = Table.RenameColumns(
        #"Prefixo Inserido1", {{"Semana do Ano", "Número da semana do Ano"}, {"Prefixo", "Semana do Ano"}}
    )
in
    #"Colunas com Nome Mudado2"
