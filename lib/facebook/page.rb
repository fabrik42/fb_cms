class Facebook::Page < Facebook::GraphObject

  def mission
    data["mission"]
  end

  def description
    data["description"]
  end

  class << self

    def load(id = settings.facebook["page_id"])
      page_data = cache(id) do
        graph.get_object(id)
      end
      new(page_data)
    end

  end
end
