var margin = {top: 50, right: 20, bottom: 20, left: 100},
width = 960 - margin.left - margin.right,
height = 500 - margin.top - margin.bottom;

function setupViewsSVG(){
 /*
  var parseDate = d3.time.format("%d/%b/%Y").parse;

  var x = d3.time.scale()
      .range([0, width]);

  var y = d3.scale.linear()
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left");

  var line = d3.svg.line()
      .x(function(line) { console.log("date "+parseDate(line.split(",")[0]));  return x(parseDate(line.split(",")[0])); })
      .y(function(line) { console.log("views "+line.split(",")[1]);return y( line.split(",")[1]); });

  var svg = d3.select("#viewsvg").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
*/

  var x = d3.scale.ordinal()
      .rangeRoundBands([0, width], .1);

  var y = d3.scale.linear()
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left")
      .ticks(10, "%");

  var svg = d3.select("#viewsvg").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


  $.ajax({
        url:"/semester",
        type: 'get',
        success: function(result,status){
          console.log(result[2]);


/*
          x.domain(d3.extent(result, function(line) {return parseDate(line.split(",")[0]); }));
          y.domain([0,d3.max(result, function(line) {  return +line.split(",")[1]; }) ]);

         svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);

        svg.append("g")
          .attr("class", "y axis")
          .call(yAxis)
          .append("text")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", ".71em")
          .style("text-anchor", "end")
          .text("Views");

        svg.append("path")
          .datum(result)
          .attr("class", "line")
          .attr("d", line);

*/
        },
        error: function(result,status){

          console.log(data);
          console.log(status)
        }

      });

}

$( document ).ready(function() {
    setupViewsSVG();
});

