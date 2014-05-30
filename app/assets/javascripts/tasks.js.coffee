jQuery ->
  return unless $("@tasks_page").length
  new TasksController($("@tasks_page"))

class TasksController
  constructor: (@$container) ->
    @handleTaskTimeSpanClick()
    @handleTaskTimeSpanEditBlur()

  handleTaskTimeSpanClick: ->
    @$container.on "click", ".time_span", (e) ->
      $time_field = $(e.target)
      $field = $time_field.siblings()
      $time_field.hide()
      $time_field.siblings().show()
      $time_field.siblings().focus()

  handleTaskTimeSpanEditBlur: ->
    @$container.on "blur", ".time_span_edit", (e) ->
      $(e.target).children().hide()

