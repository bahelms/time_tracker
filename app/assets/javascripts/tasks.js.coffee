jQuery ->
  return unless $("@tasks_page").length
  new TasksController($("@tasks_page"))

class TasksController
  constructor: (@$container) ->
    @initPopover()
    @handleTaskDurationClick()
    @handleTaskDurationFocusOut()

  initPopover: ->
    @$container.popover(
      html: true
      content: $("@popover_form").html()
      placement: "bottom"
      selector: "[rel=popover]"
    )

  handleTaskDurationClick: ->
    @$container.on "click", ".duration_value", (e) ->
      $field = $(e.target).siblings()
      $(e.target).hide()
      $field.show()
      $field.focus()

  handleTaskDurationFocusOut: ->
    @$container.on "focusout", ".task_duration_field", (e) ->
      $(e.target).hide()
      $(e.target).siblings().popover("hide")
      $(e.target).siblings().show()

