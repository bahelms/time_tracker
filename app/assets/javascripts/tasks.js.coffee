jQuery ->
  return unless $("@tasks_page").length
  new TasksController($("@tasks_page"))

class TasksController
  constructor: (@$container) ->
    @$popoverForm = $("@popover_form")
    @initPopover()
    @handleTaskDurationClick()
    @handleTaskDurationBlur()

  initPopover: ->
    self = @
    @$container.popover(
      html: true
      content: self.$popoverForm.html()
      placement: "bottom"
      selector: "[rel=popover]"
    )

  handleTaskDurationClick: ->
    @$container.on "click", ".duration_value", (e) ->
      $field = $(e.target).siblings()
      $(e.target).hide()
      $field.show()
      $field.focus()

  handleTaskDurationBlur: ->
    self = @
    @$container.on "blur", ".task_duration_field", (e) ->
      if self.$popoverForm.children().is(":focus")
      # if $("@manual_start_time").has(":focus").length
        $(e.target).hide()
        $(e.target).siblings().popover("hide")
        $(e.target).siblings().show()

