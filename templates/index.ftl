<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>GUIA Knowledge Graph</title>

  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/jquery/jquery-3.4.0.min.js"></script>
  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/bootstrap/bootstrap.min.js"></script>
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/helio.css" rel="stylesheet">
  <link rel="icon" type="image/png" href="https://avatars.githubusercontent.com/u/206107082?s=200&v=4">

  <style>
    :root {
      --bg: #f7f7fb;
      --card: #ffffff;
      --text: #1f2937;
      --muted: #6b7280;
      --line: #e5e7eb;
      --accent: #0b3c5d;
      --accent-soft: #dbeafe;
      --ok: #065f46;
      --ok-bg: #d1fae5;
      --warn: #92400e;
      --warn-bg: #fef3c7;
    }

    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background: var(--bg);
      color: var(--text);
    }

    .guia-navbar {
      background-color: #0b3c5d;
      border: none;
      border-radius: 0;
      margin-bottom: 0;
    }

    .guia-navbar .navbar-brand,
    .guia-navbar .navbar-nav > li > a {
      color: white !important;
    }

    .guia-navbar .navbar-nav > li > a:hover,
    .guia-navbar .navbar-nav > li > a:focus {
      background-color: #145374 !important;
      color: white !important;
    }

    .guia-navbar .navbar-toggle .icon-bar {
      background-color: white;
    }

    .page-wrap {
      padding: 24px;
    }

    .container-narrow {
      max-width: 1200px;
      margin: 0 auto;
    }

    .card {
      background: var(--card);
      border: 1px solid var(--line);
      border-radius: 14px;
      padding: 20px;
      margin-bottom: 18px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    h1, h2, h3 {
      margin-top: 0;
    }

    h1 {
      color: var(--accent);
      margin-bottom: 8px;
    }

    .lead {
      font-size: 16px;
      line-height: 1.6;
      color: var(--text);
    }

    .muted {
      color: var(--muted);
    }

    .metrics {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 16px;
      margin-top: 18px;
    }

    .metric {
      background: #fbfbfd;
      border: 1px solid var(--line);
      border-radius: 12px;
      padding: 18px;
      text-align: center;
    }

    .metric h2 {
      margin: 0;
      color: var(--accent);
      font-size: 30px;
    }

    .metric p {
      margin: 8px 0 0 0;
      color: var(--muted);
      font-size: 14px;
      font-weight: bold;
    }

    .section-intro {
      margin-bottom: 14px;
      color: var(--muted);
      line-height: 1.6;
    }

    .cta {
      margin-top: 18px;
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
    }

    .cta a {
      padding: 10px 14px;
      background: #0b3c5d;
      color: white;
      border-radius: 8px;
      text-decoration: none;
      font-weight: bold;
    }

    .cta a:hover {
      background: #145374;
    }

    .cta a.secondary {
      background: #ffffff;
      color: var(--accent);
      border: 1px solid var(--line);
    }

    .cta a.secondary:hover {
      background: #f8fafc;
    }

    .grid {
      display: grid;
      grid-template-columns: 1.2fr 1fr;
      gap: 18px;
      align-items: start;
    }

    .chart-wrap {
      background: #fbfbfd;
      border: 1px solid var(--line);
      border-radius: 12px;
      padding: 16px;
    }

    .bar-chart {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .bar-row {
      display: grid;
      grid-template-columns: 240px 1fr 90px;
      gap: 10px;
      align-items: center;
    }

    .bar-label {
      font-size: 13px;
      color: var(--text);
      word-break: break-word;
    }

    .bar-track {
      width: 100%;
      background: #e5e7eb;
      border-radius: 999px;
      height: 14px;
      overflow: hidden;
    }

    .bar-fill {
      height: 100%;
      background: linear-gradient(90deg, #0b3c5d, #3b82f6);
      border-radius: 999px;
    }

    .bar-value {
      text-align: right;
      font-size: 13px;
      color: var(--muted);
      font-weight: bold;
      white-space: nowrap;
    }

    .list-clean {
      margin: 0;
      padding-left: 18px;
    }

    .list-clean li {
      margin-bottom: 8px;
      line-height: 1.5;
    }

    .pill {
      display: inline-flex;
      align-items: center;
      padding: 6px 10px;
      border-radius: 999px;
      font-size: 12px;
      font-weight: bold;
      color: var(--accent);
      background: var(--accent-soft);
      margin-right: 8px;
      margin-bottom: 8px;
    }

    .footer {
      margin-top: 30px;
      padding: 18px 24px;
      background: #0b3c5d;
      color: white;
      border-top: 1px solid rgba(255,255,255,0.12);
    }

    .footer-inner {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      flex-wrap: wrap;
      text-align: center;
    }

    .footer a {
      color: white;
      text-decoration: none;
      font-weight: bold;
    }

    .footer a:hover {
      text-decoration: underline;
    }

    .footer-logo {
      width: 28px;
      height: 28px;
      object-fit: contain;
    }

    @media (max-width: 1000px) {
      .metrics,
      .grid {
        grid-template-columns: 1fr;
      }

      .bar-row {
        grid-template-columns: 1fr;
      }

      .bar-value {
        text-align: left;
      }
    }

    @media (max-width: 900px) {
      .page-wrap {
        padding: 14px;
      }
    }
  </style>
</head>
<body>

<nav class="navbar guia-navbar">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#guiaNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="/">GUIA Knowledge Graph</a>
    </div>
    <div class="collapse navbar-collapse" id="guiaNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="/">Home</a></li>
        <li><a href="/resources">Recursos</a></li>
        <li><a href="/search">Búsqueda</a></li>
        <li><a href="/sparql">SPARQL</a></li>
        <li><a href="/explore">SPARQL Gráfico</a></li>
        <li><a href="/graph">Explorador del Grafo</a></li>
        <li><a href="/about">API</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="page-wrap">
  <div class="container-narrow">

    <div class="card">
      <h1>GUIA Knowledge Graph</h1>
      <p class="lead">
        Este portal publica el <strong>Knowledge Graph del proyecto GUIA</strong>, una iniciativa orientada a la
        estructuración, integración y explotación de documentación universitaria mediante tecnologías semánticas.
        El grafo sigue la ontología definida en 
        <a href="https://github.com/guia-project/guia-ontology" target="_blank" rel="noopener noreferrer">
          el repositorio oficial de GitHub,</a> que describe el modelo de datos y las relaciones entre entidades.
        Puedes consultar más información sobre el proyecto en su web oficial:
        <a href="https://guia-project.github.io/.github/" target="_blank" rel="noopener noreferrer">GUIA Project</a>.
      </p>

      <p class="muted">
        El portal permite explorar, consultar y reutilizar los datos mediante estándares de la Web Semántica.
        En particular, utiliza tecnologías como
        <a href="https://www.w3.org/TR/rdf11-concepts/" target="_blank" rel="noopener noreferrer">RDF</a>,
        <a href="https://www.w3.org/TR/sparql11-query/" target="_blank" rel="noopener noreferrer">SPARQL 1.1</a>
        y modelos ontológicos basados en
        <a href="https://www.w3.org/TR/owl2-overview/" target="_blank" rel="noopener noreferrer">OWL 2</a>,
        todos ellos estándares del <a href="https://www.w3.org/" target="_blank" rel="noopener noreferrer">W3C</a>.
      </p>

      <div class="cta">
        <a href="/resources">Explorar recursos</a>
        <a href="/sparql">Consultar SPARQL</a>
        <a href="/explore">SPARQL gráfico</a>
        <a href="/graph">Abrir explorador gráfico</a>
        <a href="/about">Ver documentación API</a>
      </div>
    </div>

    <div class="card">
      <h2>Resumen del dataset</h2>
      <p class="section-intro">
        Esta sección ofrece una visión general del tamaño y la cobertura del grafo. Los indicadores permiten entender
        rápidamente la escala del dataset publicado y el volumen de conocimiento estructurado disponible.
      </p>

      <div class="metrics">
        <div class="metric">
          <h2>20</h2>
          <p>Entidades / Tipos</p>
        </div>

        <div class="metric">
          <h2>592,615</h2>
          <p>Instancias</p>
        </div>

        <div class="metric">
          <h2>&gt; 3M</h2>
          <p>Tripletas RDF</p>
        </div>
      </div>
    </div>

    <div class="card">
      <h2>Distribución por tipo</h2>
      <p class="section-intro">
        A continuación se muestra cómo se distribuyen las instancias entre las diferentes clases del grafo.
        La gráfica facilita identificar qué partes del modelo concentran mayor volumen de datos y ofrece
        una visión general de la cobertura del Knowledge Graph.
      </p>

      <div class="grid">
        <div class="chart-wrap">
          <h3>Gráfica de distribución</h3>
          <div class="bar-chart">
            <div class="bar-row">
              <div class="bar-label">https://guia.org/SyllabusItem</div>
              <div class="bar-track"><div class="bar-fill" style="width:100%;"></div></div>
              <div class="bar-value">124,251</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/ScheduleEvent</div>
              <div class="bar-track"><div class="bar-fill" style="width:80.20%;"></div></div>
              <div class="bar-value">99,647</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/ActivityType1</div>
              <div class="bar-track"><div class="bar-fill" style="width:78.94%;"></div></div>
              <div class="bar-value">98,077</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/EvaluationTrial</div>
              <div class="bar-track"><div class="bar-fill" style="width:35.93%;"></div></div>
              <div class="bar-value">44,645</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/DidacticResource</div>
              <div class="bar-track"><div class="bar-fill" style="width:35.12%;"></div></div>
              <div class="bar-value">43,637</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/Competency</div>
              <div class="bar-track"><div class="bar-fill" style="width:32.64%;"></div></div>
              <div class="bar-value">40,560</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/EvaluationActivity</div>
              <div class="bar-track"><div class="bar-fill" style="width:31.69%;"></div></div>
              <div class="bar-value">39,372</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/LearningResult</div>
              <div class="bar-track"><div class="bar-fill" style="width:26.08%;"></div></div>
              <div class="bar-value">32,399</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/ActivityType2</div>
              <div class="bar-track"><div class="bar-fill" style="width:23.23%;"></div></div>
              <div class="bar-value">28,857</div>
            </div>
            <div class="bar-row">
              <div class="bar-label">https://guia.org/RequiredKnowledge</div>
              <div class="bar-track"><div class="bar-fill" style="width:4.70%;"></div></div>
              <div class="bar-value">5,843</div>
            </div>
          </div>
        </div>

        <div class="chart-wrap">
          <h3>Qué puedes hacer desde este portal</h3>
          <p class="muted">
            El portal ofrece distintas formas de acceso al Knowledge Graph para perfiles técnicos y no técnicos.
            Los datos se publican siguiendo estándares de la Web Semántica, especialmente
            <a href="https://www.w3.org/TR/rdf11-concepts/" target="_blank" rel="noopener noreferrer">RDF</a>,
            <a href="https://www.w3.org/TR/sparql11-query/" target="_blank" rel="noopener noreferrer">SPARQL 1.1</a>
            y
            <a href="https://www.w3.org/TR/owl2-overview/" target="_blank" rel="noopener noreferrer">OWL 2</a>,
            todos ellos promovidos por el
            <a href="https://www.w3.org/" target="_blank" rel="noopener noreferrer">W3C</a>.
          </p>
          <ul class="list-clean">
            <li><strong>Resources:</strong> navegar por tipos e instancias publicadas en el grafo.</li>
            <li><strong>SPARQL:</strong> ejecutar consultas formales sobre el dataset RDF.</li>
            <li><strong>SPARQL Gráfico:</strong> construir consultas visualmente sin escribir SPARQL a mano.</li>
            <li><strong>Explorador del Grafo:</strong> recorrer relaciones entre recursos de forma interactiva.</li>
            <li><strong>API:</strong> consultar la documentación técnica y los endpoints disponibles.</li>
          </ul>

          <div style="margin-top:14px;">
            <span class="pill">RDF · W3C</span>
            <span class="pill">SPARQL 1.1 · W3C</span>
            <span class="pill">OWL 2 · W3C</span>
            <span class="pill">Knowledge Graph</span>
            <span class="pill">Linked Data</span>
          </div>
        </div>
      </div>
    </div>

  </div>
</div>

<footer class="footer">
  <div class="footer-inner">
    <span>Powered by</span>
    <a href="https://github.com/helio-ecosystem" target="_blank" rel="noopener noreferrer">
      <img
        class="footer-logo"
        src="https://avatars.githubusercontent.com/u/94366057?s=200&v=4"
        alt="Helio"
      />
    </a>
    <a href="https://github.com/helio-ecosystem/helio-publisher" target="_blank" rel="noopener noreferrer">
      Helio Publisher
    </a>
  </div>
</footer>

</body>
</html>