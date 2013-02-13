(function() {
  // Categories
  var MISC = 0;
  var EQUAL = 1;
  var ROUND_TRIP = 2;
  var PROPERTY = 3;
  var categories = [MISC, EQUAL, ROUND_TRIP, PROPERTY];
  var cat_names = {}
  cat_names[MISC] = "Miscellaneous";
  cat_names[EQUAL] = "Function Equality";
  cat_names[ROUND_TRIP] = "Round Trip";
  cat_names[PROPERTY] = "Property Preservation";

  var size_names = ["Tiny", "Small", "Medium", "Large"];
  var theorems = data;

  for (var i in theorems) {
    var tmp = document.createElement('div');
    tmp.innerHTML = theorems[i].body;
    theorems[i].search = theorems[i].description.toLowerCase() + ' ' +
      (tmp.textContent || tmp.innerText).toLowerCase();
  }

  var THM_TMPL = '<div class="theorem" id="theorem_{{id}}"><h2>{{description}}</h2><span class="category cat_{{category}}">{{cat_name}}</span><pre><code>{{body}}</pre></code></div>';

  var FILTER_TMPL = '<input type="checkbox" class="filter_button" id="{{type}}_{{id}}" /><label for="{{type}}_{{id}}" class="{{type}}_{{id}}">{{name}}</label>';

  var all = [];

  function check_filters() {
    var filter = document.getElementById('filter');
    selected = []
    for (var i in categories) {
      var cat = categories[i];
      if (document.getElementById('cat_' + i).checked) {
        selected.push(cat);
      }
    }
    var to_show = [];
    var query = filter.value.toLowerCase();
    for (var i in all) {
      var thm = theorems[i];
      if (thm.search.indexOf(query) != -1 &&
          (selected.length == 0 || member(thm.category, selected))) {
        to_show.push(i);
      }
    }
    show(to_show);
    if (to_show.length == 0) {
      document.getElementById('no_results').style.display = 'block';
    } else {
      document.getElementById('no_results').style.display = 'none';
    }
    var new_hash = '';
    if (query.length > 0) {
      new_hash += 'q=' + escape(query);
    }
    if (query.length > 0 && selected.length > 0) {
      new_hash += '&';
    }
    if (selected.length > 0 && selected.length < categories.length) {
      new_hash += 'cats=' + selected;
    }
    document.location.hash = new_hash;
  };

  function parse_hash() {
    hash = document.location.hash.substr(1);
    parts = hash.split('&');
    if (parts[0].charAt(0) == 'q') {
      document.getElementById('filter').value = unescape(parts[0].substr(2));
      parts.shift();
    }
    if (parts.length > 0 && parts[0].length > 0) {
      selected = parts[0].substr(5).split(',');
      for (var i in selected) {
        var cat = selected[i];
        document.getElementById('cat_' + cat).checked = true;
      }
    }
    check_filters();
  }

  function show(indices) {
    var i = 0;
    for (var j in all) {
      thm = document.getElementById('theorem_' + j);
      if (indices[i] == all[j]) {
        thm.style.display = "block";
        i++;
      } else {
        thm.style.display = "none";
      }
    }
  }

  function render_with(tmpl, obj) {
    for (var key in obj) {
      tmpl = tmpl.replace(new RegExp("{{" + key + "}}", 'g'), obj[key]);
    }
    return tmpl
  }

  function member(e, xs) {
    var ret = false;
    for (var i in xs) {
      ret = ret || e === xs[i];
    }
    return ret;
  }

  window.onload = function() {
    var filters = document.getElementById('filters');
    // Create the filter buttons
    var rendered_filters = ''
    for (var i in categories) {
      rendered_filters += render_with(FILTER_TMPL,
          { type: 'cat',
            id: categories[i],
            name: cat_names[categories[i]] });
    }
    rendered_filters += '<span class="divider"></span>';
    for (var i = 0; i < size_names.length; i++) {
      rendered_filters += render_with(FILTER_TMPL,
          { type: 'size',
            id: i,
            name: size_names[i] });
    }
    filters.innerHTML += rendered_filters
    // Render the theorems
    var results = document.getElementById("results");
    var rendered = '';
    for (var idx in theorems) {
      var theorem = theorems[idx];
      theorem.id = idx;
      theorem.cat_name = cat_names[theorem.category];
      all.push(idx);
      rendered += render_with(THM_TMPL, theorem);
    }
    results.innerHTML += rendered;
    parse_hash();
    var filter = document.getElementById('filter');
    filter.onkeyup = filter.onclick = check_filters;
    for (var i in categories) {
      document.getElementById("cat_" + categories[i]).onchange = check_filters;
    }
  }
})();
