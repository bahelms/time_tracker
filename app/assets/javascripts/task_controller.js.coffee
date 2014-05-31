namespace "Task", (window) ->
  class window.Controller
    constructor: (@stopwatch=null) ->
      @startTime = 0
      @stopTime = 0
      @task_id = 0
      @$tasks = $("@tasks")

    createTask: ->
      $.ajax(
        type: "POST"
        url: "tasks"
        data: task:
          name: $("@task_field").val()
          project_id: ""
          start_time: @startTime = @findSeconds()
          duration: 0
        success: (data) =>
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
          project_id: $("@select_project").val()
        success: (partial) ->
          $("@time_entry_list").html(partial)
        error: ->
          console.log "You suck at updating"
      )

    findSeconds: -> Math.round(new Date().getTime()/1000)
