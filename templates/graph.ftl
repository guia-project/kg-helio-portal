<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Graph Explorer - GUIA Knowledge Graph</title>

  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/jquery/jquery-3.4.0.min.js"></script>
  <script src="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/js/bootstrap/bootstrap.min.js"></script>
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/bootstrap/bootstrap.min.css" rel="stylesheet">
  <link href="https://oeg-upm.github.io/helio-publisher/src/main/resources/static/css/helio.css" rel="stylesheet">

  <script src="https://d3js.org/d3.v7.min.js"></script>
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
      --incoming: #f59e0b;
      --outgoing: #94a3b8;
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

    .controls {
      display: grid;
      grid-template-columns: 2fr auto auto auto auto;
      gap: 10px;
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

    .field input {
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 14px;
      background: white;
    }

    .btn-guia {
      background: #0b3c5d;
      color: white;
      border: none;
      border-radius: 8px;
      padding: 10px 14px;
      cursor: pointer;
      height: 42px;
    }

    .btn-guia:hover {
      background: #145374;
    }

    .status {
      margin-top: 12px;
      color: var(--muted);
      font-size: 14px;
    }

    .graph-wrap {
      width: 100%;
      height: 760px;
      border: 1px solid var(--line);
      border-radius: 10px;
      background: white;
      overflow: hidden;
      position: relative;
    }

    #graphSvg {
      width: 100%;
      height: 100%;
      display: block;
      cursor: grab;
    }

    #graphSvg:active {
      cursor: grabbing;
    }

    .legend {
      position: absolute;
      right: 14px;
      top: 14px;
      background: rgba(255,255,255,0.95);
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 12px;
      color: var(--muted);
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }

    .legend-row {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 6px;
    }

    .legend-row:last-child {
      margin-bottom: 0;
    }

    .legend-line {
      width: 22px;
      height: 0;
      border-top: 2px solid var(--outgoing);
    }

    .legend-line.incoming {
      border-top-color: var(--incoming);
      border-top-style: dashed;
    }

    .legend-dot {
      width: 12px;
      height: 12px;
      border-radius: 50%;
      background: var(--accent);
    }

    .legend-dot.seed {
      background: #145374;
      width: 16px;
      height: 16px;
    }

    .legend-dot.literal {
      background: var(--warn);
      border-radius: 4px;
    }

    .info-grid {
      display: grid;
      grid-template-columns: 1.3fr 1fr;
      gap: 18px;
    }

    .info-box {
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 14px;
      background: #fafafa;
      min-height: 180px;
    }

    .info-title {
      font-weight: bold;
      color: var(--accent);
      margin-bottom: 10px;
    }

    .uri-box {
      font-family: monospace;
      font-size: 13px;
      word-break: break-all;
    }

    .triple-list {
      margin: 0;
      padding-left: 18px;
    }

    .triple-list li {
      margin-bottom: 8px;
      word-break: break-word;
    }

    .graph-link {
      stroke-width: 2px;
      fill: none;
    }

    .graph-link.outgoing {
      stroke: var(--outgoing);
    }

    .graph-link.incoming {
      stroke: var(--incoming);
      stroke-dasharray: 6 4;
    }

    .graph-link-label {
      font-size: 10px;
      fill: #374151;
      pointer-events: none;
    }

    .node-circle {
      stroke: white;
      stroke-width: 2px;
    }

    .node-circle.uri {
      fill: var(--accent);
    }

    .node-circle.seed {
      fill: #145374;
    }

    .node-circle.literal {
      fill: var(--warn);
    }

    .node.selected .node-circle {
      stroke: #111827;
      stroke-width: 3px;
    }

    .node-label {
      font-size: 11px;
      fill: white;
      text-anchor: middle;
      dominant-baseline: middle;
      pointer-events: none;
      font-weight: 600;
      paint-order: stroke;
      stroke: rgba(17, 24, 39, 0.65);
      stroke-width: 3px;
      stroke-linejoin: round;
    }

    .tooltip-box {
      position: absolute;
      left: 14px;
      top: 14px;
      max-width: 340px;
      background: rgba(255,255,255,0.96);
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 10px 12px;
      font-size: 12px;
      color: var(--muted);
      box-shadow: 0 2px 8px rgba(0,0,0,0.05);
      display: none;
      z-index: 5;
    }

    a {
      color: var(--accent);
      text-decoration: none;
    }

    a:hover {
      text-decoration: underline;
    }

    @media (max-width: 1100px) {
      .controls,
      .info-grid {
        grid-template-columns: 1fr;
      }

      .graph-wrap {
        height: 620px;
      }
    }

    @media (max-width: 800px) {
      .page-wrap {
        padding: 14px;
      }

      .graph-wrap {
        height: 520px;
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
      <h1>Explorador visual del grafo</h1>
      <p class="muted">
        Introduce una URI semilla o llega directamente con <code>/graph?uri=...</code>. La visualización carga automáticamente el recurso y permite expandir relaciones salientes y entrantes.
      </p>

      <div class="controls">
        <div class="field">
          <label for="uriInput">URI semilla</label>
          <input id="uriInput" type="text" placeholder="https://w3id.org/guia#..." />
        </div>
        <button id="loadBtn" class="btn-guia" type="button">Cargar</button>
        <button id="expandBtn" class="btn-guia" type="button">Expandir nodo</button>
        <button id="resourceBtn" class="btn-guia" type="button">Abrir recurso</button>
        <button id="centerBtn" class="btn-guia" type="button">Centrar</button>
      </div>

      <div id="status" class="status">Esperando una URI.</div>
    </div>

    <div class="card">
      <div class="graph-wrap" id="graphContainer">
        <svg id="graphSvg"></svg>

        <div class="legend">
          <div class="legend-row">
            <span class="legend-dot seed"></span>
            <span>Semilla</span>
          </div>
          <div class="legend-row">
            <span class="legend-dot"></span>
            <span>Recurso URI</span>
          </div>
          <div class="legend-row">
            <span class="legend-dot literal"></span>
            <span>Literal</span>
          </div>
          <div class="legend-row">
            <span class="legend-line"></span>
            <span>Relación saliente</span>
          </div>
          <div class="legend-row">
            <span class="legend-line incoming"></span>
            <span>Relación entrante</span>
          </div>
        </div>

        <div id="tooltipBox" class="tooltip-box"></div>
      </div>
    </div>

    <div class="info-grid">
      <div class="card info-box">
        <div class="info-title">Nodo seleccionado</div>
        <div id="selectedNode" class="uri-box muted">No hay nodo seleccionado.</div>
      </div>

      <div class="card info-box">
        <div class="info-title">Relaciones cargadas</div>
        <ul id="triplePreview" class="triple-list muted">
          <li>No hay relaciones cargadas.</li>
        </ul>
      </div>
    </div>

  </div>
</div>

<script>
  var SPARQL_ENDPOINT = "/api/sparql";

  var uriInput = document.getElementById("uriInput");
  var loadBtn = document.getElementById("loadBtn");
  var expandBtn = document.getElementById("expandBtn");
  var resourceBtn = document.getElementById("resourceBtn");
  var centerBtn = document.getElementById("centerBtn");
  var statusBox = document.getElementById("status");
  var selectedNodeBox = document.getElementById("selectedNode");
  var triplePreview = document.getElementById("triplePreview");
  var tooltipBox = document.getElementById("tooltipBox");

  var graphContainer = document.getElementById("graphContainer");
  var svg = d3.select("#graphSvg");

  var width = graphContainer.clientWidth;
  var height = graphContainer.clientHeight;

  var selectedUri = null;
  var seedUri = null;
  var loadedUris = {};

  var nodes = [];
  var links = [];
  var nodeIndex = {};
  var linkIndex = {};

  var zoomLayer = svg.append("g");
  var linkLayer = zoomLayer.append("g");
  var linkLabelLayer = zoomLayer.append("g");
  var nodeLayer = zoomLayer.append("g");

  var defs = svg.append("defs");

  defs.append("marker")
    .attr("id", "arrow-out")
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 22)
    .attr("refY", 0)
    .attr("markerWidth", 7)
    .attr("markerHeight", 7)
    .attr("orient", "auto")
    .append("path")
    .attr("d", "M0,-5L10,0L0,5")
    .attr("fill", "#94a3b8");

  defs.append("marker")
    .attr("id", "arrow-in")
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 22)
    .attr("refY", 0)
    .attr("markerWidth", 7)
    .attr("markerHeight", 7)
    .attr("orient", "auto")
    .append("path")
    .attr("d", "M0,-5L10,0L0,5")
    .attr("fill", "#f59e0b");

  var zoom = d3.zoom()
    .scaleExtent([0.2, 4])
    .on("zoom", function(event) {
      zoomLayer.attr("transform", event.transform);
    });

  svg.call(zoom);

  var linkSelection = null;
  var linkLabelSelection = null;
  var nodeSelection = null;

  function getNodeObj(ref) {
    return typeof ref === "object" ? ref : nodeIndex[ref];
  }

  function ticked() {
    if (linkSelection) {
      linkSelection
        .attr("x1", function(d) { return getNodeObj(d.source).x; })
        .attr("y1", function(d) { return getNodeObj(d.source).y; })
        .attr("x2", function(d) { return getNodeObj(d.target).x; })
        .attr("y2", function(d) { return getNodeObj(d.target).y; });
    }

    if (linkLabelSelection) {
      linkLabelSelection
        .attr("x", function(d) { return (getNodeObj(d.source).x + getNodeObj(d.target).x) / 2; })
        .attr("y", function(d) { return (getNodeObj(d.source).y + getNodeObj(d.target).y) / 2 - 4; });
    }

    if (nodeSelection) {
      nodeSelection
        .attr("transform", function(d) {
          return "translate(" + d.x + "," + d.y + ")";
        });
    }
  }

  var simulation = d3.forceSimulation(nodes)
    .force("link", d3.forceLink(links).id(function(d) { return d.id; }).distance(150).strength(0.25))
    .force("charge", d3.forceManyBody().strength(-520))
    .force("center", d3.forceCenter(width / 2, height / 2))
    .force("collision", d3.forceCollide().radius(function(d) {
      return d.type === "literal" ? 42 : (d.type === "seed" ? 42 : 36);
    }).strength(0.9))
    .force("x", d3.forceX(width / 2).strength(0.03))
    .force("y", d3.forceY(height / 2).strength(0.03))
    .alphaDecay(0.03)
    .velocityDecay(0.25)
    .on("tick", ticked);

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
      if (hashIndex >= 0 && hashIndex < uri.length - 1) {
        return safeDecode(uri.substring(hashIndex + 1)).replace(/_/g, " ");
      }
      var slashIndex = uri.lastIndexOf("/");
      if (slashIndex >= 0 && slashIndex < uri.length - 1) {
        return safeDecode(uri.substring(slashIndex + 1)).replace(/_/g, " ");
      }
      return safeDecode(uri).replace(/_/g, " ");
    }
  }

  function shortenLabel(value, maxLen) {
    var text = value || "";
    if (text.length <= maxLen) return text;
    return text.substring(0, maxLen - 3) + "...";
  }

  function getUriParam() {
    var params = new URLSearchParams(window.location.search);
    return params.get("uri") || "";
  }

  function edgeId(source, predicate, target) {
    return source + "||" + predicate + "||" + target;
  }

  function buildNeighbourQuery(uri) {
    return (
      "SELECT ?direction ?s ?p ?o WHERE {\n" +
      "  {\n" +
      "    BIND(\"out\" AS ?direction)\n" +
      "    BIND(<" + uri + "> AS ?s)\n" +
      "    <" + uri + "> ?p ?o .\n" +
      "  }\n" +
      "  UNION\n" +
      "  {\n" +
      "    BIND(\"in\" AS ?direction)\n" +
      "    ?s ?p <" + uri + "> .\n" +
      "    BIND(<" + uri + "> AS ?o)\n" +
      "  }\n" +
      "}\n" +
      "LIMIT 200"
    );
  }

  async function runSparql(query) {
    var response = await fetch(SPARQL_ENDPOINT + "?query=" + encodeURIComponent(query), {
      method: "GET",
      headers: {
        "Accept": "application/sparql-results+json"
      }
    });

    if (!response.ok) {
      throw new Error("SPARQL endpoint error: " + response.status + " " + response.statusText);
    }

    return await response.json();
  }

  function addNodeIfMissing(id, uri, label, type, fullValue) {
    if (nodeIndex[id]) return nodeIndex[id];

    var node = {
      id: id,
      uri: uri || "",
      label: label || id,
      type: type || "uri",
      fullValue: fullValue || label || id
    };

    nodes.push(node);
    nodeIndex[id] = node;
    return node;
  }

  function addUriNodeIfMissing(uri, type) {
    return addNodeIfMissing(
      uri,
      uri,
      shortenLabel(compactUri(uri), type === "seed" ? 36 : 20),
      type || "uri",
      uri
    );
  }

  function addLiteralNodeIfMissing(id, value) {
    return addNodeIfMissing(
      id,
      "",
      shortenLabel(value, 24),
      "literal",
      value
    );
  }

  function addLinkIfMissing(sourceId, predicate, targetId, direction) {
    var id = edgeId(sourceId, predicate, targetId);
    if (linkIndex[id]) return linkIndex[id];

    var link = {
      id: id,
      source: sourceId,
      target: targetId,
      predicate: predicate,
      label: shortenLabel(compactUri(predicate), 26),
      direction: direction || "out"
    };

    links.push(link);
    linkIndex[id] = link;
    return link;
  }

  function updatePreview(rows) {
    triplePreview.innerHTML = "";

    if (!rows.length) {
      triplePreview.innerHTML = "<li>No hay relaciones cargadas.</li>";
      triplePreview.className = "triple-list muted";
      return;
    }

    triplePreview.className = "triple-list";

    for (var i = 0; i < rows.length && i < 12; i++) {
      var row = rows[i];
      var li = document.createElement("li");

      if (row.dir === "in") {
        li.innerHTML =
          "<strong>" + escapeHtml(compactUri(row.p)) + "</strong> ← " +
          escapeHtml(row.otherLabel);
      } else {
        li.innerHTML =
          "<strong>" + escapeHtml(compactUri(row.p)) + "</strong> → " +
          escapeHtml(row.otherLabel);
      }

      triplePreview.appendChild(li);
    }
  }

  function setSelectedNode(nodeData) {
    if (!nodeData) return;

    selectedUri = nodeData.uri || "";

    if (nodeData.type === "literal") {
      selectedNodeBox.textContent = nodeData.fullValue || nodeData.label;
    } else {
      selectedNodeBox.textContent = nodeData.uri;
    }

    renderGraph();
  }

  function wrapSvgText(textSel, text, widthPx, maxLines, fontSizePx) {
    var words = (text || "").split(/\s+/).filter(Boolean);
    textSel.text(null);

    textSel.style("font-size", fontSizePx + "px");

    if (!words.length) return;

    var line = [];
    var lineNumber = 0;
    var lineHeight = 1.05;
    var y = 0;
    var dy = 0;

    var tspan = textSel.append("tspan")
      .attr("x", 0)
      .attr("y", y)
      .attr("dy", dy + "em");

    for (var i = 0; i < words.length; i++) {
      line.push(words[i]);
      tspan.text(line.join(" "));

      if (tspan.node().getComputedTextLength() > widthPx && line.length > 1) {
        line.pop();
        tspan.text(line.join(" "));
        line = [words[i]];
        lineNumber++;

        if (lineNumber >= maxLines) {
          var previous = textSel.select("tspan:last-child");
          var currentText = previous.text();
          if (currentText.length > 3) {
            previous.text(currentText.substring(0, Math.max(1, currentText.length - 3)) + "...");
          } else {
            previous.text("...");
          }
          return;
        }

        tspan = textSel.append("tspan")
          .attr("x", 0)
          .attr("y", y)
          .attr("dy", (lineNumber * lineHeight) + "em")
          .text(words[i]);
      }
    }

    if (lineNumber >= maxLines) {
      var last = textSel.select("tspan:last-child");
      var txt = last.text();
      if (!txt.endsWith("...")) {
        last.text(txt.substring(0, Math.max(1, txt.length - 3)) + "...");
      }
    }
  }

  function showTooltip(d) {
    var html = "";

    if (d.type === "literal") {
      html += "<strong>Literal</strong><br>";
      html += escapeHtml(d.fullValue || d.label);
    } else {
      html += "<strong>URI</strong><br>";
      html += escapeHtml(d.uri || d.id);
    }

    tooltipBox.innerHTML = html;
    tooltipBox.style.display = "block";
  }

  function hideTooltip() {
    tooltipBox.style.display = "none";
  }

  function dragStarted(event, d) {
    if (!event.active) simulation.alphaTarget(0.2).restart();
    d.fx = d.x;
    d.fy = d.y;
  }

  function dragged(event, d) {
    d.fx = event.x;
    d.fy = event.y;
  }

  function dragEnded(event, d) {
    if (!event.active) simulation.alphaTarget(0);
    d.fx = null;
    d.fy = null;
  }

  function renderGraph() {
    linkSelection = linkLayer
      .selectAll("line")
      .data(links, function(d) { return d.id; });

    linkSelection.exit().remove();

    var linkEnter = linkSelection.enter()
      .append("line")
      .attr("class", function(d) {
        return "graph-link " + (d.direction === "in" ? "incoming" : "outgoing");
      })
      .attr("marker-end", function(d) {
        return d.direction === "in" ? "url(#arrow-in)" : "url(#arrow-out)";
      });

    linkSelection = linkEnter.merge(linkSelection);

    linkLabelSelection = linkLabelLayer
      .selectAll("text")
      .data(links, function(d) { return d.id; });

    linkLabelSelection.exit().remove();

    var linkLabelEnter = linkLabelSelection.enter()
      .append("text")
      .attr("class", "graph-link-label")
      .text(function(d) { return d.label; });

    linkLabelSelection = linkLabelEnter.merge(linkLabelSelection);

    nodeSelection = nodeLayer
      .selectAll("g.node")
      .data(nodes, function(d) { return d.id; });

    nodeSelection.exit().remove();

    var nodeEnter = nodeSelection.enter()
      .append("g")
      .attr("class", "node")
      .call(
        d3.drag()
          .on("start", dragStarted)
          .on("drag", dragged)
          .on("end", dragEnded)
      )
      .on("click", function(event, d) {
        event.stopPropagation();
        setSelectedNode(d);
      })
      .on("dblclick", function(event, d) {
        event.stopPropagation();
        if (d.type !== "literal" && d.uri) {
          expandUri(d.uri, false);
        }
      })
      .on("mouseover", function(event, d) {
        showTooltip(d);
      })
      .on("mouseout", function() {
        hideTooltip();
      });

    nodeEnter.each(function(d) {
      var g = d3.select(this);

      if (d.type === "literal") {
        g.append("rect")
          .attr("class", "node-circle literal")
          .attr("x", -42)
          .attr("y", -20)
          .attr("width", 84)
          .attr("height", 40)
          .attr("rx", 8)
          .attr("ry", 8);
      } else {
        g.append("circle")
          .attr("class", "node-circle " + (d.type === "seed" ? "seed" : "uri"))
          .attr("r", d.type === "seed" ? 36 : 28);
      }

      g.append("text")
        .attr("class", "node-label")
        .attr("dy", "0.35em")
        .each(function(nodeData) {
          var text = d3.select(this);

          if (nodeData.type === "seed") {
            wrapSvgText(text, nodeData.label, 86, 3, 11);
          } else if (nodeData.type === "literal") {
            wrapSvgText(text, nodeData.label, 76, 2, 10);
          } else {
            wrapSvgText(text, nodeData.label, 62, 2, 10);
          }
        });
    });

    nodeSelection = nodeEnter.merge(nodeSelection)
      .classed("selected", function(d) {
        return !!selectedUri && d.uri === selectedUri;
      });

    simulation.nodes(nodes);
    simulation.force("link").links(links);
    simulation.alpha(0.9).restart();
  }

  function centerGraph() {
    var bounds = zoomLayer.node().getBBox();

    if (!bounds || !isFinite(bounds.x)) return;

    var fullWidth = graphContainer.clientWidth;
    var fullHeight = graphContainer.clientHeight;
    var scale = Math.min(
      0.9,
      0.85 / Math.max(bounds.width / fullWidth, bounds.height / fullHeight)
    );

    if (!isFinite(scale) || scale <= 0) {
      scale = 1;
    }

    var translateX = fullWidth / 2 - scale * (bounds.x + bounds.width / 2);
    var translateY = fullHeight / 2 - scale * (bounds.y + bounds.height / 2);

    svg.transition()
      .duration(500)
      .call(
        zoom.transform,
        d3.zoomIdentity.translate(translateX, translateY).scale(scale)
      );
  }

  async function expandUri(uri, isSeed) {
    if (!uri) return;

    statusBox.textContent = "Cargando relaciones de " + uri + "...";

    if (!seedUri) {
      seedUri = uri;
    }

    var currentNode = addUriNodeIfMissing(uri, isSeed ? "seed" : (uri === seedUri ? "seed" : "uri"));
    currentNode.type = uri === seedUri ? "seed" : currentNode.type;

    var query = buildNeighbourQuery(uri);
    var json = await runSparql(query);
    var bindings = json.results && json.results.bindings ? json.results.bindings : [];

    var previewRows = [];

    for (var i = 0; i < bindings.length; i++) {
      var b = bindings[i];
      if (!b.p || !b.direction) continue;

      var direction = b.direction.value;
      var predicate = b.p.value;

      if (direction === "out") {
        if (!b.o) continue;

        var objectValue = b.o.value;
        var objectType = b.o.type;

        if (objectType === "uri") {
          addUriNodeIfMissing(objectValue, objectValue === seedUri ? "seed" : "uri");
          addLinkIfMissing(uri, predicate, objectValue, "out");

          previewRows.push({
            dir: "out",
            p: predicate,
            otherLabel: compactUri(objectValue)
          });
        } else {
          var literalId = "lit::" + uri + "::" + predicate + "::out::" + i;
          addLiteralNodeIfMissing(literalId, objectValue);
          addLinkIfMissing(uri, predicate, literalId, "out");

          previewRows.push({
            dir: "out",
            p: predicate,
            otherLabel: objectValue
          });
        }
      }

      if (direction === "in") {
        if (!b.s) continue;

        var subjectValue = b.s.value;
        addUriNodeIfMissing(subjectValue, subjectValue === seedUri ? "seed" : "uri");
        addLinkIfMissing(subjectValue, predicate, uri, "in");

        previewRows.push({
          dir: "in",
          p: predicate,
          otherLabel: compactUri(subjectValue)
        });
      }
    }

    loadedUris[uri] = true;
    updatePreview(previewRows);
    renderGraph();

    if (!selectedUri) {
      selectedUri = uri;
      selectedNodeBox.textContent = uri;
      renderGraph();
    }

    setTimeout(function() {
      centerGraph();
    }, 400);

    statusBox.textContent = "Relaciones cargadas para " + compactUri(uri) + ".";
  }

  function loadSeedFromInput() {
    var uri = uriInput.value.trim();
    if (!uri) {
      statusBox.textContent = "Introduce una URI válida.";
      return;
    }

    nodes = [];
    links = [];
    nodeIndex = {};
    linkIndex = {};
    loadedUris = {};
    selectedUri = uri;
    seedUri = uri;
    selectedNodeBox.textContent = uri;
    updatePreview([]);

    renderGraph();

    expandUri(uri, true).catch(function(err) {
      console.error(err);
      statusBox.textContent = "Error cargando el nodo inicial.";
    });
  }

  loadBtn.addEventListener("click", loadSeedFromInput);

  expandBtn.addEventListener("click", function() {
    if (!selectedUri) {
      statusBox.textContent = "Selecciona un nodo URI primero.";
      return;
    }

    expandUri(selectedUri, false).catch(function(err) {
      console.error(err);
      statusBox.textContent = "Error expandiendo el nodo seleccionado.";
    });
  });

  resourceBtn.addEventListener("click", function() {
    if (!selectedUri) {
      statusBox.textContent = "Selecciona un nodo URI primero.";
      return;
    }

    window.location.href = selectedUri;
  });

  centerBtn.addEventListener("click", centerGraph);

  uriInput.addEventListener("keydown", function(e) {
    if (e.key === "Enter") {
      loadSeedFromInput();
    }
  });

  window.addEventListener("resize", function() {
    width = graphContainer.clientWidth;
    height = graphContainer.clientHeight;
    simulation.force("center", d3.forceCenter(width / 2, height / 2));
    simulation.alpha(0.4).restart();
  });

  svg.on("click", function() {
    hideTooltip();
  });

  var initialUri = getUriParam();
  if (initialUri) {
    uriInput.value = initialUri;
    loadSeedFromInput();
  } else {
    renderGraph();
  }
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