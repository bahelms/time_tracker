jQuery ->
  return unless $("@stopwatch_button").length
  new StopwatchController($("@stopwatch_button"))

class StopwatchController
  constructor: (@$stopwatchButton) ->
    @stopwatch = new Stopwatch(@update, 50)
    @taskController = new TaskController(@stopwatch)
    @$stopwatchReset = $("@stopwatch_reset")
    @$clock = $("@clock_label")
    @running = false
    @initEvents()

  initEvents: ->
    @handleStartStop()

  handleStartStop: ->
    @$stopwatchButton.click( =>
      if @running
        @stop()
        # Ajax update stop_time and duration
      else
        @taskController.createTask()
        @start()
    )

  start: ->
    @$stopwatchButton.html("Stop")
    @$stopwatchButton.removeClass("btn-success")
    @$stopwatchButton.addClass("btn-danger")
    @running = true
    @stopwatch.start()

  stop: ->
    @stopwatch.stop()
    @stopwatch.reset()
    @update()
    @$stopwatchButton.html("Start")
    @$stopwatchButton.removeClass("btn-danger")
    @$stopwatchButton.addClass("btn-success")
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
