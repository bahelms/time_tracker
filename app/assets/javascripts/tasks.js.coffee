jQuery ->
  return unless $("@tasks_page").length
  new TasksController($("@tasks_page"))

class TasksController
  constructor: (@$container) ->
    @$taskDuration = @$container.find($("@task_duration"))
    @handleTaskDurationClick()

  handleTaskDurationClick: ->
    @$container.on "click", @$taskDuration, (e) ->
      console.log $(e.target).find($("@task_duration_field"))
      $(e.target).find($("@duration_value")).hide()
      $(e.target).find($("@task_duration_field")).show()

