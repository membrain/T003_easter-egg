combo :foo, [37, 39, 37, 39]
combo :bar, [38, 38, 38]

jesture :fight do
  presses :foo do
    "alert('Fight!')"
  end
end

jesture :color_change do
  presses :bar, "Foo.bar"
  presses :foo do
    "alert('Fight!')"
  end
end
