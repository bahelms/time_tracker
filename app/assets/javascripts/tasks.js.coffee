jQuery ->
  return unless $("@tasks_page").length
  new TasksController($("@tasks_page"))

class TasksController
  constructor: (@$container) ->
    @handleTaskDurationClick()
    @handleTaskDurationFocusOut()

  handleTaskDurationClick: ->
    @$container.on "click", ".duration_value", (e) ->
      $field = $(e.target).siblings()
      $(e.target).hide()
      $field.show()
      $field.focus()

  handleTaskDurationFocusOut: ->
    @$container.on "focusout", $("@task_duration_field"), (e) ->
      $(e.target).hide()
      $(e.target).siblings().show()
