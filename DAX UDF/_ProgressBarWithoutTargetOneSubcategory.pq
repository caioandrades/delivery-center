DEFINE 
    FUNCTION _ProgressBarWithoutTargetOneSubcategory = (
        vValor1: expr, 
        vSubcategoryTitle1: string,
        vValor2: expr,
        vBarColor: string
    ) =>  

--------------------------------
-- Global Variables  
--------------------------------

VAR vValor1 =  vValor1  
VAR vRotulo_subcategoria1 = vSubcategoryTitle1
VAR vValor2 = vValor2
VAR vBarra_progresso_cor = vBarColor
VAR vBarra =  1



--------------------------------
-- FORMAT  
--------------------------------

VAR vFonte = "Verdana"
VAR vRotulo_categoria_cor = "#3f3f3f"
VAR vRotulo_categoria_tam = 10

VAR vRotulo_categoria_meta =   "100%"   --- "Target: " & FORMAT(vMeta, "0%")


VAR vBarra_altura = 10



VAR vBarra_fundo_cor = "#DCDCDC"
VAR vBarra_fundo_opacidade = 9



RETURN 

"data:image/svg+xml;utf8,
<svg width='200' height='70' viewBox='0 0 200 70' fill='none' xmlns='http://www.w3.org/2000/svg'>
   
    <!-- Barra de Fundo -->
    <rect id='f001' x='0' y='8' width='" & MIN(190, MAX(0, ROUND(131 * vBarra, 0))) & "' height='" & vBarra_altura & "' fill='" & vBarra_fundo_cor & "' opacity='0." & vBarra_fundo_opacidade & "' rx='5' ry='5' />
    <!-- Barra de Progresso -->
    <rect id='f002' x='0' y='8' width='" & MIN(190, MAX(0, ROUND(131 * vValor1, 0))) & "' height='" & vBarra_altura & "' fill='" & vBarra_progresso_cor & "' rx='5' ry='5' />
        
    <!-- Texto da Categoria Meta -->
    <text id='f006' fill='" & vRotulo_categoria_cor & "' font-family='" & vFonte & "' font-size='" & vRotulo_categoria_tam & "' font-weight='400'>
        <tspan x='135' y='17'> " & vRotulo_categoria_meta & "</tspan>
    </text>

    <!-- Texto de Subcategoria e Valor Automatizado -->
    <text id='f003' fill='#3f3f3f' font-family='" & vFonte & "' font-size='12' font-weight='400'>
        <tspan x='0' y='40'>" & vRotulo_subcategoria1 & "</tspan>
        <tspan dx='1'>" & vValor2 & "</tspan>
    </text>

</svg>"