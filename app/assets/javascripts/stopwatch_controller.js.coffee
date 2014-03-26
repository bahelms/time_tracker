jQuery ->
  return unless $("@stopwatch_button").length
  new StopwatchController($("@stopwatch_button"))

class StopwatchController
  constructor: (@$stopwatchButton) ->
    @stopwatch = new Stopwatch()
    @interval = 0
    @$clock = $("@clock_label")
    @handleStart()

  handleStart: ->
    self = @
    @$stopwatchButton.click( ->
      if self.interval
        console.log "Stop"
        self.stopwatch.stop()
        clearInterval(self.interval)
      else
        console.log "Start"
        self.stopwatch.start()
        self.interval = setInterval(self.update(), 1000)
    )

  update: ->
    @$clock.html(@stopwatch.toString())
