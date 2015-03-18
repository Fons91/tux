
var margin = {top: 50, right: 20, bottom: 20, left: 100},
width = 960 - margin.left - margin.right,
height = 500 - margin.top - margin.bottom;

function setupSemesterSVG(module){

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
        url:"/semester?node="+module,
        type: 'get',
        success: function(result,status){
        console.log("dasdsa ")
          console.log(result);


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

          console.log(result);
          console.log(status)
        }

      });

}



//Autoclmplete
$(function() {

    $("#searchfield").autocomplete({
        source: "/modules",
        minLength: 2,
        select: function(event, ui) {
            var element = ui.item.value;

            console.log(element);

            if(element != '#') {
                setupSemesterSVG(element);
            }

        },

        html: true, // optional (jquery.ui.autocomplete.html.js required)

      // optional (if other layers overlap autocomplete list)
    /*    open: function(event, ui) {
            $(".ui-autocomplete").css("z-index", 1000);
        }
        */
    });

});


