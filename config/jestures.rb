combo :foo, [:left, :right, :left, :right]
combo :bar, [:up, :up, :up]
combo :uppity, [38, 38, 38, 38]

jesture :fight do
  presses :foo do
    "alert('Fight!')"
  end
end

jesture :color_change do
  presses :bar, "Foo.bar"
end

jesture :complainer do
  presses :uppity, "alert('Eww! None of those here!')"
end
