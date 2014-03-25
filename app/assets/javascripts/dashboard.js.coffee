jQuery ->
  return unless $("@stopwatch").length
  new StopwatchController($("@stopwatch"))

class StopwatchController
  constructor: (@$stopwatch) ->
    @time = 0
    @offset = 0
    @$clock = $("@clock")
    @handleStart()

  handleStart: ->
    self = @
    @$stopwatch.click( ->
      if $(@).data("status")
        self.stop()
        $(@).data("status", false)
      else
        self.start()
        $(@).data("status", true)
    )

  start: ->
    alert Date.now()
    @offset = Date.now()
    interval = setInterval(@update, 1000)

  stop: ->
    alert "Stopped"

  update: ->
    @time += @delta()
    @render()

  delta: ->
    now = Date.now()
    delta = now - @offset
    @offset = now
    delta

  render: ->
    @$clock.html(@time/1000)
