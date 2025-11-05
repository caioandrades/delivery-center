	DEFINE
		function _ProgressBarWithTarget =
			(
			        vValor: expr, 
			        vMeta: expr,  
			        vBarra_progresso_cor: expr,
                    vSubcategoryTitle1: string,
                    vValor2: expr,
                    vSubcategoryTitle2: string,
                    vValor3: expr,  
			) =>  
			
			
			VAR vValor =  vValor       
			VAR vMeta =  vMeta   
            VAR vRotulo_subcategoria1 = vSubcategoryTitle1
            VAR vValor2 = vValor2
            VAR vRotulo_subcategoria2 = vSubcategoryTitle2
            VAR vValor3 =  vValor3       
			VAR vBarra =  1   
			
			--------------------------------
			-- FORMATAÇÕES   
			--------------------------------
			
			VAR vFonte = "Verdana"
			VAR vRotulo_categoria_cor = "#3f3f3f"
			VAR vRotulo_categoria_tam = 12
			
			VAR vRotulo_categoria_meta = "Meta: " & FORMAT(vMeta, "0%")
			
			
			VAR vBarra_altura = 10
			
			VAR vBarra_progresso_cor = vBarra_progresso_cor
			
			VAR vBarra_fundo_cor = "#DCDCDC"
			VAR vBarra_fundo_opacidade = 9
			
			VAR vLinha_meta_larg =  1
			VAR vLinha_meta_cor = "#3f3f3f"
			
			
			RETURN 
			
			"data:image/svg+xml;utf8,
			<svg width='200' height='70' viewBox='0 0 200 70' fill='none' xmlns='http://www.w3.org/2000/svg'>
			   
			    <!-- Barra de Fundo -->
			    <rect id='f001' x='0' y='8' width='" & MIN(190, MAX(0, ROUND(131 * vBarra, 0))) & "' height='" & vBarra_altura & "' fill='" & vBarra_fundo_cor & "' opacity='0." & vBarra_fundo_opacidade & "' rx='5' ry='5' />
			    <!-- Barra de Progresso -->
			    <rect id='f002' x='0' y='8' width='" & MIN(190, MAX(0, ROUND(131 * vValor, 0))) & "' height='" & vBarra_altura & "' fill='" & vBarra_progresso_cor & "' rx='5' ry='5' />
			    
				<!-- Linha de Meta -->
 				<rect id='f005' x='0" & MIN( 190, MAX( 0, ROUND( 131 * vMeta , 0 ) ) ) & " ' y='04' width='" & vLinha_meta_larg & "' height='" & vBarra_altura + 10 & "' fill='" & vLinha_meta_cor & "' />   
			
			    <!-- Texto da Categoria Meta -->
			    <text id='f006' fill='" & vRotulo_categoria_cor & "' font-family='" & vFonte & "' font-size='" & vRotulo_categoria_tam & "' font-weight='400'>
			        <tspan x='135' y='17'> " & vRotulo_categoria_meta & "</tspan>
			    </text>
                <!-- Texto de Subcategoria e Valor Automatizado -->
                <text id='f003' fill='#3f3f3f' font-family='" & vFonte & "' font-size='12' font-weight='400'>
                    <tspan x='0' y='40'>" & vRotulo_subcategoria1 & "</tspan>
                    <tspan dx='1'>" & vValor2 & "</tspan>
                </text>

                <!-- Texto de Subcategoria e Valor Automatizado -->
                <text id='f003' fill='#3f3f3f' font-family='" & vFonte & "' font-size='12' font-weight='400'>
                    <tspan x='0' y='57'>" & vRotulo_subcategoria2 & "</tspan>
                    <tspan dx='1'>" & vValor3 & "</tspan>
                </text> 
			</svg>"