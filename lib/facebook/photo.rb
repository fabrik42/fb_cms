class Facebook::Photo < Facebook::GraphObject

  def thumb
    data["picture"].sub("_s.jpg", "_a.jpg")
  end

  def url
    data["picture"].sub("_s.jpg", "_n.jpg")
  end

end