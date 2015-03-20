var svg ;

function setupStudySVG(course){
      var margin = {top: 50, right: 20, bottom: 20, left: 100},
  width = 960 - margin.left - margin.right,
  height = 500 - margin.top - margin.bottom;


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

    if(svg!==undefined){
          d3.select("#viewsvg").select("svg").remove()
    }
    svg= d3.select("#viewsvg").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");





  $.ajax({
        url:"/study?course="+course,
        type: 'get',
        success: function(data,status){
          console.log(data);
          x.domain(data.map(function(d) { console.log("data is ");console.log(d.study_plan);return parseInt(d.study_plan); }));
          y.domain([0, d3.max(data, function(d) { return parseInt(d.attendance); })]);

          svg.append("g")
              .attr("class", "x axis")
              .attr("transform", "translate(0," + height + ")")
              .call(xAxis)



          svg.append("g")
              .attr("class", "y axis")
              .call(yAxis)
            .append("text")
              .attr("transform", "rotate(-90)")
              .attr("y", 6)
              .attr("dy", ".71em")
              .style("text-anchor", "end")
              .text("Number of students");


          svg.selectAll(".bar")
              .data(data)
            .enter().append("rect")
              .attr("class", "bar")
              .attr("x", function(d) { return x(d.study_plan); })
              .attr("width", x.rangeBand())
              .attr("y", function(d) { return y(d.attendance); })
              .attr("height", function(d) { return height - y(d.attendance); });


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
                setupStudySVG(element);
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


