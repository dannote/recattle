local template = {}

function template.print(data, args)
  if type(data) == "function" then
    setfenv(data, args)
    data(template.print)
  else
    ngx.print(data)
  end
end

return template