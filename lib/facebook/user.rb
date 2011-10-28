class Facebook::User < Facebook::GraphObject

  def short_name
    name[/[^\s]*/]
  end

end