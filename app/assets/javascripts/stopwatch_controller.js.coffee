jQuery ->
  return unless $("@stopwatch_button").length
  new StopwatchController($("@stopwatch_button"))

class StopwatchController
  constructor: (@$stopwatchButton) ->
    @stopwatch = new Stopwatch(@update, 50)
    @running = false
    @$clock = $("@clock_label")
    @initialize()

  initialize: ->
    @handleStart()

  handleStart: ->
    @$stopwatchButton.click( =>
      if @running then @stop() else @start()
    )

  start: ->
    console.log "Start"
    @$stopwatchButton.html("Stop")
    @running = true
    @stopwatch.start()

  stop: ->
    console.log "Stop"
    @$stopwatchButton.html("Start")
    @stopwatch.stop()
    @running = false

  update: =>
    ms = parseInt(@stopwatch.getElapsed().milliseconds/100)
    @$clock.html(@stopwatch.toString() + "." + ms)
