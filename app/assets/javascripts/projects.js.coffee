jQuery ->
  return unless $("@projects").length
  new ProjectsController($("@create_project_form"))

class ProjectsController
  constructor: (@$form) ->
    @$createButton = $("@create_project_button")
    @$projectNameField = $("@project_name_field")
    @$projectsList = $("@projects_list")
    @$deleteButton = $(".delete_project")
    @handleCreate()
    @handleDelete()

  handleCreate: ->
    @$createButton.click (e) =>
      @$form.validate()
      if @$form.valid()
        e.preventDefault()
        $.ajax(
          type: "POST"
          url: "projects"
          data: @$form.serialize()
          success: (partial) =>
            @$projectNameField.val("")
            @$projectsList.prepend(partial)
          error: -> "You suck at creating projects"
        )

  handleDelete: ->
    @$projectsList.on "click", @$deleteButton, (e) ->
      $(e.target).parents(".project").remove()
