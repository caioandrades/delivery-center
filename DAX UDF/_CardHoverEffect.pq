DEFINE
    FUNCTION _CardHoverEffect = (
        vTitle: string, 
        vValue: expr,
        vTarget: expr, 
        vSubtitle: string
    ) => 

    --------------------------------
    -- Global Variables 
    --------------------------------
    VAR vTitle     = vTitle
    VAR vValueFmt  = FORMAT(vValue, "0.00%")
    VAR vTargetFmt = FORMAT(vTarget, "0.00%")
    VAR vSubtitleF = "Meta: " & FORMAT(vTarget, "0%")

    --------------------------------
    -- Layout e medidas base
    --------------------------------
    VAR vBarX   = 30
    VAR vBarY   = 125
    VAR vBarW   = 1
    VAR vBarH   = 10

    VAR vFillW  = vBarW * vValue
    VAR vGoalX  = vBarX + (vTarget * vBarW)
    VAR vPctX   = vBarX + vFillW + 8

    --------------------------------
    -- Fontes
    --------------------------------
    VAR vTitleFont = "Segoe UI"
    VAR vValueFont = "Segoe UI Semibold"

    RETURN
"
<svg width='280' height='180' viewBox='0 0 280 180' xmlns='http://www.w3.org/2000/svg'>
  <defs>
    <linearGradient id='grad-normal' x1='0' y1='0' x2='1' y2='1'>
      <stop offset='0%' stop-color='#ffffff'/>
      <stop offset='100%' stop-color='#f5f6f8'/>
    </linearGradient>
    <linearGradient id='grad-hover' x1='0' y1='0' x2='1' y2='1'>
      <stop offset='0%' stop-color='#f1f3f6'/>
      <stop offset='100%' stop-color='#e7e9ed'/>
    </linearGradient>
  </defs>

  <style>
    .card-group { transition: all 0.35s ease; cursor: pointer; }
    .card-group:hover { transform: translateY(-4px); filter: drop-shadow(0 6px 10px rgba(0,0,0,0.18)); }

    .card-bg { fill: url(#grad-normal); stroke: #d6d8dc; stroke-width:1; rx:14; ry:14; transition: fill 0.35s ease; }
    .card-group:hover .card-bg { fill: url(#grad-hover); }

    .title { font-family:'" & vTitleFont & "', sans-serif; font-size:15px; fill:#374151; font-weight:600; }
    .value { font-family:'" & vValueFont & "', sans-serif; font-size:38px; fill:#111827; font-weight:700; }
    .label { font-family:'" & vTitleFont & "', sans-serif; font-size:14px; fill:#6b7280; }
    .percent { font-family:'" & vTitleFont & "', sans-serif; font-size:14px; fill:#2563eb; font-weight:600; }

    .divider { stroke: #d1d5db; stroke-width: 1; }
    .progress-bg { fill: #e5e7eb; rx: 3; ry: 3; }
    .progress-fill { fill: #3b82f6; rx: 3; ry: 3; transition: width 0.35s ease; }
    .goal-line { stroke: #6b7280; stroke-width: 2; }
  </style>

  <g class='card-group'>
    <!-- Fundo -->
    <rect class='card-bg' x='10' y='10' width='260' height='160'/>

    <!-- Título -->
    <text x='30' y='45' class='title'>" & vTitle & "</text>

    <!-- Valor principal -->
    <text x='30' y='95' class='value'>" & vValueFmt & "</text>

    <!-- Divisor -->
    <line x1='30' y1='115' x2='250' y2='115' class='divider'/>

    <!-- Barra de progresso -->
    <rect x='" & vBarX & "' y='" & vBarY & "' width='" & vBarW & "' height='" & vBarH & "' class='progress-bg'/>
    
    <!-- Preenchimento da barra -->
    <rect x='" & vBarX & "' y='" & vBarY & "' width='" & MIN( 190,  MAX( 0, ROUND( 131 * vTarget , 0 ) ) )  & "' height='" & vBarH & "' class='progress-fill'/>
	
    <!-- Linha da meta -->
    <rect x='0'  y='04' width='" & MIN( 190,  MAX( 0, ROUND( 131 * vTarget , 0 ) ) )  & " ' height='" & vBarH + 10 & "' fill='#3f3f3f' />

    <!-- Texto da meta -->
    <text x='30' y='155' class='label'>" & vSubtitleF & "</text>

    <!-- Percentual concluído fora da barra -->
    <text x='" & vPctX & "' y='" & (vBarY + 9) & "' class='percent'>" & vValueFmt & "</text>
  </g>
</svg>"
