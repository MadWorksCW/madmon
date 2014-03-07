class Madmon.DatapointsChartsPage

  constructor: ->
    dcp = this
    $.ajax
      type: 'GET'
      dataType: 'json'
      url: '/datapoints'
      success: (resp) ->
        datapoints = resp.datapoints

        for datapoint in datapoints
          datapoint.time = new Date(datapoint.time)

        ndx = crossfilter(datapoints)

        timeDim = ndx.dimension( (datapoint) -> datapoint.time )
        valueGroup = timeDim.group().reduceSum( (datapoint) -> datapoint.value )

        minDate = timeDim.bottom(1)[0].time
        maxDate = timeDim.top(1)[0].time

        valueOverTime = dc.lineChart('#valueOverTime')
                          .height(500)
                          .width(1000)
                          .x(d3.time.scale().domain([minDate, maxDate]))
                          .brushOn(false)
                          .dimension(timeDim)
                          .group(valueGroup)

        dc.renderAll()

  print_filter: (filter) ->
      f = eval(filter)
      if (f.top?)
        f = f.top(Infinity)
      if (f.dimension?)
        f = f.dimension(((d) -> "")).top(Infinity)
      console.log(filter + "(" + f.length + ") = " + JSON.stringify(f).replace('[',"[\n\t").replace(/}\,/g,"},\n\t").replace("]","\n]"))
