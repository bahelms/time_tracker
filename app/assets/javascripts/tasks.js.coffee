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
      start = $button.parent().find(".time_start").val()
      stop = $button.parent().find(".time_stop").val()
      self.updateTime($button.data("id"), start, stop)

  updateTime: (task_id, start, stop) ->
    $.ajax(
      type: "PATCH"
      url: "tasks/manual_update"
      data:
        id: task_id
        start_time: start
        stop_time: stop
      success: (data) ->
        if data.failed
          alert("Start time must be before stop time")
        else
          $("@time_entry_list").html(data)
      error: ->
        console.log "You can't manually update for crap."
        console.log "Start: #{start}; Stop: #{stop}; Task ID: #{task_id}"
    )
