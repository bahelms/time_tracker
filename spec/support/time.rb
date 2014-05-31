def monday?
  Time.current.localtime.wday == 1 ? true : false
end

def tasks_for(time)
  method = "beginning_of_#{time}"
  Task.where("created_at >= ?", Time.current.localtime.send(method)).count
end
