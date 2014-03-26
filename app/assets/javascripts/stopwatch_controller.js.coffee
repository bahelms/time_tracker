jQuery ->
  return unless $("@stopwatch_button").length
  new StopwatchController($("@stopwatch_button"))

class StopwatchController
  constructor: (@$stopwatchButton) ->
    @stopwatch = new Stopwatch()
    @$clock = $("@clock_label")
    @handleStart()

  handleStart: ->
    self = @
    @$stopwatchButton.click( ->
      if $(@).data("status")
        console.log "Stop"
        $(@).data("status", false)
        self.stopwatch.stop()
        clearInterval(@time)
      else
        console.log "Start"
        console.log @stopwatch
        $(@).data("status", true)
        self.stopwatch.start()
        @time = setInterval(self.update(), 1000)
    )

  update: ->
    @$clock.html("#{@stopwatch.toString()}")

  # start: ->
  #   unless @running
  #     console.log "Start"
  #     @running = true
  #     @startTime = @getTime()

  # stop: ->
  #   if @running
  #     console.log "Stop"
  #     @running = false
  #     @stopTime = @getTime()

  # duration: ->
  #   unless @startTime? or @stopTime?
  #     (@stopTime - @startTime) / 1000

  # reset: ->
  #   @time = 0
  #   @render()

  # getTime: ->
  #   (new Date).getTime()

  displayTime: ->
