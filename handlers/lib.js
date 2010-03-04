$(document).ready(function() {

//From Barney B: http://www.barneyb.com/barneyblog/2009/06/03/jquery-tablesorter-comma-parser/
jQuery.tablesorter.addParser({
  id: "commaDigit",
  is: function(s, table) {
    var c = table.config;
    return jQuery.tablesorter.isDigit(s.replace(/,/g, ""), c);
  },
  format: function(s) {
    return jQuery.tablesorter.formatFloat(s.replace(/,/g, ""));
  },
  type: "numeric"
});

$("#allData").tablesorter({
	headers: {1: {sorter:"commaDigit"}},
	widgets: ["zebra"]
});
$("#extData").tablesorter({
	headers: {2: {sorter:"commaDigit"}},
	widgets: ["zebra"]
});
$("#folderData").tablesorter({
	headers: {2: {sorter:"commaDigit"}},
	widgets: ["zebra"]	
});

})