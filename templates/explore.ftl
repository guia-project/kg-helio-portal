<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Explorar el Knowledge Graph</title>

  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/jquery/jquery-3.4.0.min.js"></script>
  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/bootstrap/bootstrap.min.js"></script>
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/helio.css" rel="stylesheet">

  <!-- Sparnatural -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sparnatural@latest/dist/sparnatural.min.css">
  <script src="https://cdn.jsdelivr.net/npm/sparnatural@latest/dist/sparnatural.min.js"></script>
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
      max-width: 1280px;
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

    h1, h2 {
      margin-top: 0;
    }

    h1 {
      color: var(--accent);
      margin-bottom: 8px;
    }

    .muted {
      color: var(--muted);
    }

    .grid {
      display: grid;
      grid-template-columns: 1.3fr 1fr;
      gap: 18px;
      align-items: start;
    }

    .box-title {
      margin-bottom: 12px;
      color: var(--accent);
      font-weight: bold;
    }

    #queryBox {
      width: 100%;
      min-height: 240px;
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 12px;
      font-family: monospace;
      font-size: 13px;
      background: #fbfbfd;
      resize: vertical;
    }

    .actions {
      margin-top: 12px;
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
    }

    .btn-guia {
      background: #0b3c5d;
      color: white;
      border: none;
      border-radius: 8px;
      padding: 10px 14px;
      cursor: pointer;
    }

    .btn-guia:hover {
      background: #145374;
    }

    .status {
      margin-top: 10px;
      color: var(--muted);
      font-size: 14px;
    }

    .table-wrap {
      overflow-x: auto;
      margin-top: 12px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      text-align: left;
      border-bottom: 1px solid var(--line);
      padding: 10px 8px;
      vertical-align: top;
      font-size: 14px;
    }

    th {
      background: #fafafa;
    }

    td code {
      font-family: monospace;
      font-size: 13px;
      word-break: break-word;
    }

    a {
      color: var(--accent);
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }

    .empty {
      padding: 20px 0;
      color: var(--muted);
    }

    @media (max-width: 1000px) {
      .page-wrap {
        padding: 14px;
      }

      .grid {
        grid-template-columns: 1fr;
      }
    }
  </style>
    <!-- Footer Style -->
  <style> 

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

    .footer-separator {
      opacity: 0.7;
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
        <li><a href="/graph">Explorador Gráfico</a></li>
        <li><a href="/about">API</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="page-wrap">
  <div class="container-narrow">

    <div class="card">
      <h1>Exploración visual del Knowledge Graph</h1>
      <p class="muted">
        Esta vista usa Sparnatural para construir consultas SPARQL de forma visual sobre el grafo.
      </p>
    </div>

    <div class="card">
      <div class="box-title">Explorador visual</div>

      <!-- Ajusta src a la ruta real de tu configuración SHACL -->
      <spar-natural
        id="sparnatural"
        src="https://raw.githubusercontent.com/guia-project/kg-helio-portal/refs/heads/main/sparnatural-config.ttl?v=4"
        endpoint="/api/sparql"
        lang="es"
        defaultLang="en"
        distinct="true"
        limit="100"
        debug="true">
      </spar-natural>

      <div id="exploreStatus" class="status">Esperando configuración…</div>
    </div>

    <div class="grid">
      <div class="card">
        <div class="box-title">Consulta generada</div>
        <textarea id="queryBox" readonly></textarea>

        <div class="actions">
          <button id="runQueryBtn" class="btn-guia" type="button">Ejecutar consulta</button>
          <button id="copyQueryBtn" class="btn-guia" type="button">Copiar consulta</button>
          <button id="openSparqlBtn" class="btn-guia" type="button">Abrir en SPARQL</button>
        </div>
      </div>

      <div class="card">
        <div class="box-title">Ayuda</div>
        <p class="muted">
          La interfaz mostrará solo las clases y propiedades definidas en la configuración SHACL.
        </p>
        <p class="muted">
          Si el panel sale vacío o incompleto, normalmente significa que falta ajustar el fichero de configuración.
        </p>
      </div>
    </div>

    <div class="card">
      <div class="box-title">Resultados</div>
      <div id="resultsMeta" class="status">Sin resultados todavía.</div>
      <div class="table-wrap">
        <table id="resultsTable" style="display:none;">
          <thead id="resultsHead"></thead>
          <tbody id="resultsBody"></tbody>
        </table>
      </div>
      <div id="resultsEmpty" class="empty">Ejecuta una consulta para ver resultados.</div>
    </div>

  </div>
</div>

<script>
  var sparnatural = document.getElementById("sparnatural");
  var queryBox = document.getElementById("queryBox");
  var exploreStatus = document.getElementById("exploreStatus");
  var resultsMeta = document.getElementById("resultsMeta");
  var resultsTable = document.getElementById("resultsTable");
  var resultsHead = document.getElementById("resultsHead");
  var resultsBody = document.getElementById("resultsBody");
  var resultsEmpty = document.getElementById("resultsEmpty");
  var runQueryBtn = document.getElementById("runQueryBtn");
  var copyQueryBtn = document.getElementById("copyQueryBtn");
  var openSparqlBtn = document.getElementById("openSparqlBtn");

  var currentQuery = "";

  function escapeHtml(str) {
    return String(str)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;");
  }

  function safeDecode(value) {
    if (!value) return value;
    try {
      return decodeURIComponent(value);
    } catch (e) {
      return value;
    }
  }

  function compactUri(uri) {
    try {
      var url = new URL(uri);
      var path = url.pathname && url.pathname !== "/" ? url.pathname : "";
      return safeDecode(url.hostname + path + (url.hash || "")).replace(/_/g, " ");
    } catch (e) {
      var hashIndex = uri.lastIndexOf("#");
      if (hashIndex >= 0 && hashIndex < uri.length - 1) return safeDecode(uri.substring(hashIndex + 1)).replace(/_/g, " ");
      var slashIndex = uri.lastIndexOf("/");
      if (slashIndex >= 0 && slashIndex < uri.length - 1) return safeDecode(uri.substring(slashIndex + 1)).replace(/_/g, " ");
      return safeDecode(uri).replace(/_/g, " ");
    }
  }

  function renderCell(binding) {
    if (!binding) return '<span class="muted">—</span>';

    if (binding.type === "uri") {
      return '<a href="' + escapeHtml(binding.value) + '"><code>' + escapeHtml(compactUri(binding.value)) + '</code></a>';
    }

    if (binding.type === "literal") {
      return '<code>' + escapeHtml(binding.value) + '</code>';
    }

    return '<code>' + escapeHtml(binding.value || "") + '</code>';
  }

  function renderResults(json) {
    var vars = (json.head && json.head.vars) ? json.head.vars : [];
    var bindings = (json.results && json.results.bindings) ? json.results.bindings : [];

    resultsHead.innerHTML = "";
    resultsBody.innerHTML = "";

    if (!vars.length || !bindings.length) {
      resultsTable.style.display = "none";
      resultsEmpty.style.display = "block";
      resultsMeta.textContent = "La consulta no devolvió resultados.";
      return;
    }

    var headHtml = "<tr>";
    for (var i = 0; i < vars.length; i++) {
      headHtml += "<th>" + escapeHtml(vars[i]) + "</th>";
    }
    headHtml += "</tr>";
    resultsHead.innerHTML = headHtml;

    for (var r = 0; r < bindings.length; r++) {
      var row = bindings[r];
      var rowHtml = "<tr>";
      for (var c = 0; c < vars.length; c++) {
        var v = vars[c];
        rowHtml += "<td>" + renderCell(row[v]) + "</td>";
      }
      rowHtml += "</tr>";
      resultsBody.innerHTML += rowHtml;
    }

    resultsTable.style.display = "table";
    resultsEmpty.style.display = "none";
    resultsMeta.textContent = "Resultados: " + bindings.length;
  }

  async function executeQuery(query) {
    resultsMeta.textContent = "Ejecutando consulta…";
    resultsEmpty.style.display = "none";

    var response = await fetch("/api/sparql?query=" + encodeURIComponent(query), {
      method: "GET",
      headers: {
        "Accept": "application/sparql-results+json"
      }
    });

    if (!response.ok) {
      throw new Error("Error del endpoint SPARQL: " + response.status + " " + response.statusText);
    }

    var json = await response.json();
    renderResults(json);
  }

  sparnatural.addEventListener("init", function() {
  exploreStatus.textContent = "Sparnatural cargado correctamente.";
});

sparnatural.addEventListener("queryUpdated", function(event) {
  var rawQuery = "";

  if (event.detail && event.detail.queryString) {
    rawQuery = event.detail.queryString;
  }

  if (rawQuery) {
    try {
      currentQuery = sparnatural.expandSparql(rawQuery);
    } catch (e) {
      currentQuery = rawQuery;
    }
  } else {
    currentQuery = "";
  }

  queryBox.value = currentQuery;
  exploreStatus.textContent = currentQuery
    ? "Consulta actualizada."
    : "Define criterios para generar una consulta.";
});

sparnatural.addEventListener("submit", function() {
  if (!currentQuery) {
    resultsTable.style.display = "none";
    resultsEmpty.style.display = "block";
    resultsMeta.textContent = "No hay ninguna consulta generada todavía.";
    return;
  }

  resultsMeta.textContent = "Ejecutando consulta…";

  executeQuery(currentQuery).catch(function(err) {
    resultsTable.style.display = "none";
    resultsEmpty.style.display = "block";
    resultsMeta.textContent = "Error ejecutando la consulta.";
    console.error(err);
  });
});

sparnatural.addEventListener("reset", function() {
  currentQuery = "";
  queryBox.value = "";
  resultsTable.style.display = "none";
  resultsBody.innerHTML = "";
  resultsHead.innerHTML = "";
  resultsEmpty.style.display = "block";
  resultsMeta.textContent = "Consulta reiniciada.";
});

runQueryBtn.addEventListener("click", function() {
  if (!currentQuery) {
    resultsTable.style.display = "none";
    resultsEmpty.style.display = "block";
    resultsMeta.textContent = "No hay ninguna consulta generada todavía.";
    return;
  }

  executeQuery(currentQuery).catch(function(err) {
    resultsTable.style.display = "none";
    resultsEmpty.style.display = "block";
    resultsMeta.textContent = "Error ejecutando la consulta.";
    console.error(err);
  });
});

  copyQueryBtn.addEventListener("click", function() {
    if (!currentQuery) return;
    navigator.clipboard.writeText(currentQuery);
  });

  openSparqlBtn.addEventListener("click", function() {
    if (!currentQuery) {
      window.location.href = "/sparql";
      return;
    }
    window.location.href = "/sparql?query=" + encodeURIComponent(currentQuery);
  });
</script>
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