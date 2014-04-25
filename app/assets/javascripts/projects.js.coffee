jQuery ->
  return unless $("@projects").length
  new ProjectsController($("@project_name"))

class ProjectsController
  constructor: (@$form) ->
    @$createButton = $("@create_project_button")
    @handleCreate()

  handleCreate: ->
    @$createButton.click( =>
      @$form.validate()
    )
