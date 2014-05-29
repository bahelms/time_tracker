jQuery ->
  return unless $("@tasks_page").length
  new TasksController($("@tasks_page"))

class TasksController
  constructor: (@$container) ->
    @handleTaskTimeSpanClick()
    @handleTaskTimeSpanEditBlur()

  handleTaskTimeSpanClick: ->
    @$container.on "click", ".time_span", (e) ->
      $field = $(e.target).siblings()
      $(e.target).hide()
      $field.show()
      $field.focus()

  handleTaskTimeSpanEditBlur: ->
    @$container.on "blur", ".time_span_edit", (e) ->
      console.log $(e.target)
      $(e.target).hide()
      $(e.target).siblings().show()

