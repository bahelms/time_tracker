ready = ->
  return unless $("@tasks_page").length
  new TasksController($("@tasks_page"))

jQuery -> ready()
$(document).on("page:load", ready)

class TasksController
  constructor: (@$container) ->
    @handleTaskTimeSpanClick()
    @handleTaskTimeSpanEditBlur()
    @handleApplyButtonClick()

  handleTaskTimeSpanClick: ->
    @$container.on "click", ".time_span", (e) ->
      $time_field = $(e.target)
      $field = $time_field.siblings()
      $time_field.hide()
      $time_field.siblings().show()
      $time_field.siblings().first().focus()
      id = $time_field.closest(".task").data("id")
      $("@manual_time_button[data-id='#{id}'").show()

  handleTaskTimeSpanEditBlur: ->
    @$container.on "blur", ".time_span_edit", (e) ->
      $(e.target).children().hide()

  handleApplyButtonClick: ->
    self = @
    @$container.on "click", ".manual_time_button", (e) ->
      $button = $(e.target)
      time_start = $button.parent().find("@time_start").val()
      # TODO update manual tim
      # self.updateTime
