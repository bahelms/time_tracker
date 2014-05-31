ready = ->
  return unless $("@stopwatch_button").length
  new StopwatchController($("@stopwatch_button"))

jQuery -> ready()
$(document).on("page:load", ready)

class StopwatchController
  constructor: (@$stopwatchButton) ->
    @stopwatch = new Stopwatch(@updateClock, 50)
    @taskController = new Task.Controller(@stopwatch)
    @$stopwatchReset = $("@stopwatch_reset")
    @$clock = $("@clock_label")
    @$projectSelect = $("@select_project")
    @running = false
    @initEvents()

  initEvents: ->
    @handleStartStop()

  handleStartStop: ->
    @$stopwatchButton.click( => if @running then @stop() else @start())

  start: ->
    @$stopwatchButton.html("Stop")
    @$stopwatchButton.removeClass("btn-success")
    @$stopwatchButton.addClass("btn-danger")
    @running = true
    @taskController.createTask()
    @stopwatch.start()

  stop: ->
    @stopwatch.stop()
    @stopwatch.reset()
    @taskController.updateTask()
    @resetStopwatchView()
    @running = false

  resetStopwatchView: ->
    @updateClock()
    @$stopwatchButton.html("Start")
    @$stopwatchButton.removeClass("btn-danger")
    @$stopwatchButton.addClass("btn-success")
    @$projectSelect.val("")
    $("@task_field").val("")

  updateClock: =>
    ms = parseInt(@stopwatch.getElapsed().milliseconds/100)
    @$clock.html(@stopwatch.toString() + "." + ms)

