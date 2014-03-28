jQuery ->
  return unless $("@stopwatch_button").length
  new StopwatchController($("@stopwatch_button"))

class StopwatchController
  constructor: (@$stopwatchButton) ->
    @stopwatch = new Stopwatch(@update, 50)
    @$stopwatchReset = $("@stopwatch_reset")
    @running = false
    @$clock = $("@clock_label")
    @initialize()

  initialize: ->
    @handleStartStop()
    @handleReset()

  handleStartStop: ->
    @$stopwatchButton.click( =>
      if @running then @stop() else @start()
    )

  handleReset: ->
    @$stopwatchReset.click( =>
      @stopwatch.reset()
      @update()
    )

  start: ->
    @$stopwatchButton.html("Stop")
    @running = true
    @stopwatch.start()

  stop: ->
    @$stopwatchButton.html("Start")
    @stopwatch.stop()
    @running = false

  update: =>
    ms = parseInt(@stopwatch.getElapsed().milliseconds/100)
    @$clock.html(@stopwatch.toString() + "." + ms)
