<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Recurso RDF</title>

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

    h1, h2 {
      margin-top: 0;
    }

    h1 {
      color: var(--accent);
      margin-bottom: 8px;
      word-break: break-word;
    }

    .resource-uri {
      word-break: break-all;
      font-family: monospace;
      font-size: 15px;
      color: var(--muted);
      margin-top: 8px;
      line-height: 1.5;
    }

    .resource-uri a {
      color: var(--accent);
      text-decoration: none;
    }

    .resource-uri a:hover {
      text-decoration: underline;
    }

    .toolbar {
      display: grid;
      grid-template-columns: 2fr 1fr 1fr;
      gap: 12px;
      align-items: end;
    }

    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .field label {
      font-size: 13px;
      color: var(--muted);
      font-weight: bold;
    }

    .field input,
    .field select {
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 14px;
      background: white;
    }

    .summary {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      margin-top: 14px;
    }

    .pill {
      display: inline-flex;
      align-items: center;
      padding: 6px 10px;
      border-radius: 999px;
      font-size: 12px;
      font-weight: bold;
    }

    .pill.total {
      color: var(--accent);
      background: var(--accent-soft);
    }

    .pill.literal {
      color: var(--warn);
      background: var(--warn-bg);
    }

    .pill.uri {
      color: var(--ok);
      background: var(--ok-bg);
    }

    .table-wrap {
      overflow-x: auto;
    }

    table {
      width: 100%;
      border-collapse: collapse;
    }

    th, td {
      text-align: left;
      border-bottom: 1px solid var(--line);
      padding: 12px 10px;
      vertical-align: top;
      font-size: 14px;
    }

    th {
      background: #fafafa;
      position: sticky;
      top: 0;
      z-index: 1;
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

    .muted {
      color: var(--muted);
    }

    .empty {
      padding: 24px;
      text-align: center;
      color: var(--muted);
    }

    .kind-badge {
      display: inline-block;
      font-size: 12px;
      font-weight: bold;
      padding: 4px 8px;
      border-radius: 999px;
      white-space: nowrap;
    }

    .kind-uri {
      background: var(--ok-bg);
      color: var(--ok);
    }

    .kind-literal {
      background: var(--warn-bg);
      color: var(--warn);
    }

    .kind-incoming {
      background: var(--accent-soft);
      color: var(--accent);
    }

    .predicate-cell {
      width: 28%;
    }

    .object-cell {
      width: 58%;
    }

    .type-cell {
      width: 14%;
    }

    .literal-value {
      white-space: pre-wrap;
      word-break: break-word;
    }

    .meta {
      margin-top: 6px;
      font-size: 12px;
      color: var(--muted);
    }

    .small-btn {
      background: white;
      color: var(--accent);
      border: 1px solid var(--line);
      border-radius: 8px;
      padding: 6px 10px;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      font-size: 13px;
      margin-right: 6px;
      margin-top: 4px;
    }

    .small-btn:hover {
      text-decoration: none;
      background: #f8fafc;
    }

    .small-btn.visual-btn {
      background: var(--ok-bg);
      color: var(--ok);
      border-color: #86efac;
    }

    .small-btn.visual-btn:hover {
      background: #bbf7d0;
      color: var(--ok);
    }

    .actions-inline {
      margin-top: 10px;
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
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

    @media (max-width: 900px) {
      .page-wrap {
        padding: 14px;
      }

      .toolbar {
        grid-template-columns: 1fr;
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
      <h1 id="resourceTitle">Recurso RDF</h1>
      <div id="resourceUri" class="resource-uri"></div>
      <div class="actions-inline">
        <a id="graphBtn" class="small-btn visual-btn" href="#" style="display:none;">Visual Exploration</a>
      </div>
    </div>

    <div class="card">
      <h2>Filtros de propiedades salientes</h2>

      <div class="toolbar">
        <div class="field">
          <label for="searchInput">Búsqueda libre</label>
          <input id="searchInput" type="text" placeholder="Buscar en predicado u objeto" />
        </div>

        <div class="field">
          <label for="propertyTypeFilter">Tipo de propiedad</label>
          <select id="propertyTypeFilter">
            <option value="all">Todas</option>
            <option value="datatype">Datatype properties</option>
            <option value="object">Object properties</option>
          </select>
        </div>

        <div class="field">
          <label for="predicateFilter">Predicado</label>
          <select id="predicateFilter">
            <option value="all">Todos</option>
          </select>
        </div>
      </div>

      <div class="summary">
        <span class="pill total">Salientes: <span id="totalCount" style="margin-left:6px;">0</span></span>
        <span class="pill total">Filtradas: <span id="filteredCount" style="margin-left:6px;">0</span></span>
        <span class="pill literal">Datatype: <span id="literalCount" style="margin-left:6px;">0</span></span>
        <span class="pill uri">Object: <span id="uriCount" style="margin-left:6px;">0</span></span>
      </div>
    </div>

    <div class="card">
      <h2>Propiedades salientes</h2>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th class="predicate-cell">Predicado</th>
              <th class="object-cell">Objeto</th>
              <th class="type-cell">Tipo</th>
            </tr>
          </thead>
          <tbody id="triplesTableBody"></tbody>
        </table>
      </div>
      <div id="emptyState" class="empty" style="display:none;">No hay resultados con los filtros actuales.</div>
    </div>

    <div class="card">
      <h2>Propiedades entrantes</h2>
      <div class="table-wrap">
        <table>
          <thead>
            <tr>
              <th class="predicate-cell">Predicado</th>
              <th class="object-cell">Recurso que apunta aquí</th>
              <th class="type-cell">Tipo</th>
            </tr>
          </thead>
          <tbody id="incomingTriplesTableBody"></tbody>
        </table>
      </div>
      <div id="incomingEmptyState" class="empty" style="display:none;">No hay propiedades entrantes.</div>
    </div>

  </div>
</div>

<script>
  const NTRIPLES_RAW = "${data?js_string}";

  function safeDecode(value) {
    if (!value) return value;
    try {
      return decodeURIComponent(value);
    } catch (e) {
      return value;
    }
  }

  function isUri(value) {
    return /^(https?:\/\/|urn:|mailto:)/i.test(value);
  }

  function escapeHtml(str) {
    return String(str)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;");
  }

  function compactUri(uri) {
    try {
      const url = new URL(uri);
      const path = url.pathname && url.pathname !== "/" ? url.pathname : "";
      return url.hostname + path + (url.hash || "");
    } catch (e) {
      var hashIndex = uri.lastIndexOf("#");
      if (hashIndex >= 0 && hashIndex < uri.length - 1) {
        return uri.substring(hashIndex + 1);
      }
      var slashIndex = uri.lastIndexOf("/");
      if (slashIndex >= 0 && slashIndex < uri.length - 1) {
        return uri.substring(slashIndex + 1);
      }
      return uri;
    }
  }

  function humanUriLabel(uri) {
    return safeDecode(compactUri(uri)).replace(/_/g, " ");
  }

  function buildLink(value, label) {
    return '<a href="' + escapeHtml(value) + '" title="' + escapeHtml(value) + '">' +
      '<code>' + escapeHtml(label || value) + '</code></a>';
  }

  function renderUri(value) {
    return buildLink(value, compactUri(value));
  }

  function renderLiteral(value) {
    return '<div class="literal-value"><code>' + escapeHtml(value) + '</code></div>';
  }

  function parseObjectToken(token) {
    var trimmed = token.trim();

    if (trimmed.startsWith("<") && trimmed.endsWith(">")) {
      var uri = trimmed.slice(1, -1);
      return {
        raw: trimmed,
        value: uri,
        display: uri,
        kind: "uri",
        language: null,
        datatype: null,
        isUri: true
      };
    }

    var literalWithLang = trimmed.match(/^"(.*)"@([a-zA-Z\-]+)$/s);
    if (literalWithLang) {
      return {
        raw: trimmed,
        value: literalWithLang[1],
        display: literalWithLang[1],
        kind: "literal",
        language: literalWithLang[2],
        datatype: null,
        isUri: false
      };
    }

    var literalWithDatatype = trimmed.match(/^"(.*)"\^\^<(.+)>$/s);
    if (literalWithDatatype) {
      return {
        raw: trimmed,
        value: literalWithDatatype[1],
        display: literalWithDatatype[1],
        kind: "literal",
        language: null,
        datatype: literalWithDatatype[2],
        isUri: false
      };
    }

    var plainLiteral = trimmed.match(/^"(.*)"$/s);
    if (plainLiteral) {
      return {
        raw: trimmed,
        value: plainLiteral[1],
        display: plainLiteral[1],
        kind: "literal",
        language: null,
        datatype: null,
        isUri: false
      };
    }

    return {
      raw: trimmed,
      value: trimmed,
      display: trimmed,
      kind: isUri(trimmed) ? "uri" : "literal",
      language: null,
      datatype: null,
      isUri: isUri(trimmed)
    };
  }

  function parseNTriplesLine(line) {
    var trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) return null;

    var match = trimmed.match(/^<([^>]+)>\s+<([^>]+)>\s+(.+)\s+\.\s*$/s);
    if (!match) return null;

    var subject = match[1];
    var predicate = match[2];
    var objectToken = match[3];
    var parsedObject = parseObjectToken(objectToken);

    return {
      subject: subject,
      predicate: predicate,
      object: parsedObject.value,
      objectDisplay: parsedObject.display,
      objectKind: parsedObject.kind,
      language: parsedObject.language,
      datatype: parsedObject.datatype,
      isObjectUri: parsedObject.isUri,
      searchBlob: (
        subject + " " +
        predicate + " " +
        parsedObject.display + " " +
        (parsedObject.language || "") + " " +
        (parsedObject.datatype || "")
      ).toLowerCase()
    };
  }

  function parseNTriplesDocument(ntriples) {
    return ntriples
      .split(/\r?\n/)
      .map(parseNTriplesLine)
      .filter(Boolean);
  }

  function detectResourceUri(triples) {
    if (!triples.length) return "";

    var counts = {};
    for (var i = 0; i < triples.length; i++) {
      var t = triples[i];
      counts[t.subject] = (counts[t.subject] || 0) + 1;
      if (isUri(t.object)) {
        counts[t.object] = (counts[t.object] || 0) + 1;
      }
    }

    var bestUri = "";
    var bestCount = -1;
    for (var uri in counts) {
      if (counts[uri] > bestCount) {
        bestCount = counts[uri];
        bestUri = uri;
      }
    }

    return bestUri;
  }

  function splitTriplesByDirection(triples, resourceUri) {
    var outgoing = [];
    var incoming = [];

    for (var i = 0; i < triples.length; i++) {
      var t = triples[i];
      if (t.subject === resourceUri) {
        outgoing.push(t);
      } else if (t.object === resourceUri) {
        incoming.push(t);
      }
    }

    return {
      outgoing: outgoing,
      incoming: incoming
    };
  }

  var triples = parseNTriplesDocument(NTRIPLES_RAW);
  var resourceUriValue = detectResourceUri(triples);
  var split = splitTriplesByDirection(triples, resourceUriValue);

  var outgoingTriples = split.outgoing;
  var incomingTriples = split.incoming;

  var searchInput = document.getElementById("searchInput");
  var propertyTypeFilter = document.getElementById("propertyTypeFilter");
  var predicateFilter = document.getElementById("predicateFilter");

  var triplesTableBody = document.getElementById("triplesTableBody");
  var incomingTriplesTableBody = document.getElementById("incomingTriplesTableBody");

  var emptyState = document.getElementById("emptyState");
  var incomingEmptyState = document.getElementById("incomingEmptyState");

  var totalCount = document.getElementById("totalCount");
  var filteredCount = document.getElementById("filteredCount");
  var literalCount = document.getElementById("literalCount");
  var uriCount = document.getElementById("uriCount");

  var resourceUri = document.getElementById("resourceUri");
  var resourceTitle = document.getElementById("resourceTitle");
  var graphBtn = document.getElementById("graphBtn");

  function populateFilters(data) {
    var predicates = Array.from(new Set(data.map(function(t) { return t.predicate; }))).sort();
    for (var i = 0; i < predicates.length; i++) {
      var pred = predicates[i];
      var option = document.createElement("option");
      option.value = pred;
      option.textContent = compactUri(pred);
      option.title = pred;
      predicateFilter.appendChild(option);
    }
  }

  function applyFilters(data) {
    var search = searchInput.value.trim().toLowerCase();
    var propType = propertyTypeFilter.value;
    var predicate = predicateFilter.value;

    return data.filter(function(t) {
      if (search && t.searchBlob.indexOf(search) === -1) return false;
      if (propType === "datatype" && t.objectKind !== "literal") return false;
      if (propType === "object" && t.objectKind !== "uri") return false;
      if (predicate !== "all" && t.predicate !== predicate) return false;
      return true;
    });
  }

  function renderObjectCell(row) {
    var html = "";

    if (row.isObjectUri) {
      html += renderUri(row.object);
    } else {
      html += renderLiteral(row.objectDisplay);
    }

    if (row.language || row.datatype) {
      html += '<div class="meta">';
      if (row.language) {
        html += 'Idioma: <code>' + escapeHtml(row.language) + '</code>';
      }
      if (row.language && row.datatype) {
        html += ' · ';
      }
      if (row.datatype) {
        html += 'Datatype: ' + renderUri(row.datatype);
      }
      html += '</div>';
    }

    return html;
  }

  function renderOutgoingTable(rows) {
    triplesTableBody.innerHTML = "";

    if (!rows.length) {
      emptyState.style.display = "block";
      return;
    }

    emptyState.style.display = "none";

    for (var i = 0; i < rows.length; i++) {
      var row = rows[i];
      var tr = document.createElement("tr");

      var html = "";
      html += "<td class=\"predicate-cell\">" + renderUri(row.predicate) + "</td>";
      html += "<td class=\"object-cell\">" + renderObjectCell(row) + "</td>";
      html += "<td class=\"type-cell\">";
      html += "<span class=\"kind-badge " + (row.objectKind === "uri" ? "kind-uri" : "kind-literal") + "\">";
      html += escapeHtml(row.objectKind);
      html += "</span>";
      html += "</td>";

      tr.innerHTML = html;
      triplesTableBody.appendChild(tr);
    }
  }

  function renderIncomingTable(rows) {
    incomingTriplesTableBody.innerHTML = "";

    if (!rows.length) {
      incomingEmptyState.style.display = "block";
      return;
    }

    incomingEmptyState.style.display = "none";

    for (var i = 0; i < rows.length; i++) {
      var row = rows[i];
      var tr = document.createElement("tr");

      var html = "";
      html += "<td class=\"predicate-cell\">" + renderUri(row.predicate) + "</td>";
      html += "<td class=\"object-cell\">" + renderUri(row.subject) + "</td>";
      html += "<td class=\"type-cell\"><span class=\"kind-badge kind-incoming\">incoming</span></td>";

      tr.innerHTML = html;
      incomingTriplesTableBody.appendChild(tr);
    }
  }

  function renderSummary(allRows, visibleRows) {
    totalCount.textContent = allRows.length;
    filteredCount.textContent = visibleRows.length;
    literalCount.textContent = visibleRows.filter(function(r) { return r.objectKind === "literal"; }).length;
    uriCount.textContent = visibleRows.filter(function(r) { return r.objectKind === "uri"; }).length;
  }

  function renderResourceHeader(resourceUriValue) {
    if (!resourceUriValue) {
      resourceTitle.textContent = "Recurso RDF";
      resourceUri.textContent = "Sin tripletas";
      graphBtn.style.display = "none";
      return;
    }

    resourceTitle.textContent = humanUriLabel(resourceUriValue);
    resourceUri.innerHTML = 'URI del recurso: ' + renderUri(resourceUriValue);
    graphBtn.href = "/graph?uri=" + encodeURIComponent(resourceUriValue);
    graphBtn.style.display = "inline-block";
  }

  function refresh() {
    var filteredOutgoing = applyFilters(outgoingTriples);
    renderSummary(outgoingTriples, filteredOutgoing);
    renderOutgoingTable(filteredOutgoing);
    renderIncomingTable(incomingTriples);
  }

  populateFilters(outgoingTriples);
  renderResourceHeader(resourceUriValue);
  refresh();

  searchInput.addEventListener("input", refresh);
  propertyTypeFilter.addEventListener("change", refresh);
  predicateFilter.addEventListener("change", refresh);
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