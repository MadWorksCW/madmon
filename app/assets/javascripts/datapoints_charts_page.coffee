# options.el: the element selector (#someId) to render to
# options.watch_id: which watch
# .height/width
class Madmon.DatapointsChartsPage
  constructor: (options={}) ->
    dcp = this
    options.height ||= 500
    options.width ||= 1000
    $.ajax
      type: 'GET'
      dataType: 'json'
      url: "/watches/#{options.watch_id}/datapoints"
      success: (resp) ->
        datapoints = resp.datapoints

        for datapoint in datapoints
          datapoint.time = new Date(datapoint.time)

        ndx = crossfilter(datapoints)

        timeDim = ndx.dimension( (datapoint) -> datapoint.time )
        valueGroup = timeDim.group().reduceSum( (datapoint) -> datapoint.value )

        minDate = timeDim.bottom(1)[0].time
        maxDate = timeDim.top(1)[0].time

        valueOverTime = dc.lineChart(options.el)
                          .height(options.height)
                          .width(options.width)
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
