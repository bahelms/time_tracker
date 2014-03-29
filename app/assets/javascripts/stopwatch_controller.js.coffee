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
      if @running
        @stop()
        # Ajax stop_time and duration
      else
        new TaskController(@stopwatch).createTask()
        @start()
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


class TaskController
  constructor: (@stopwatch) ->
    @name = $("@task_field").val()

  createTask: ->
    $.ajax(
      type: "POST"
      url: "tasks"
      data: task:
        name: @name
        project_id: ""
        time:
          start_time: ""
      success: ->
        console.log "Success"
      error: ->
        console.log "You suck at this"
    )
