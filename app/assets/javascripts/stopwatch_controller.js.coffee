ready = ->
  return unless $("@stopwatch_button").length
  new StopwatchController($("@stopwatch_button"))

jQuery -> ready()
$(document).on("page:load", ready)

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
      if @running then @stop() else @start()
    )

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
    @startTime = 0
    @stopTime = 0
    @task_id = 0

  createTask: ->
    $.ajax(
      type: "POST"
      url: "tasks"
      data: task:
        name: @name
        project_id: ""
        start_time: @startTime = @findSeconds()
      success: (data) =>
        console.log "Create Success"
        @task_id = data.id
        $("@task_field").data("task_id", @task_id)
      error: ->
        console.log "You suck at creating"
    )

  updateTask: ->
    $.ajax(
      type: "PATCH"
      url: "tasks/#{@task_id}"
      data: task:
        stop_time: @stopTime = @findSeconds()
        duration: @stopTime - @startTime
      success: =>
        console.log "Update Success"
      error: ->
        console.log "You suck at updating"
    )

  findSeconds: -> Math.round(new Date().getTime()/1000)
