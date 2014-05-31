window.namespace = (target, name, block) ->
  [target, name, block] = [window, arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top
